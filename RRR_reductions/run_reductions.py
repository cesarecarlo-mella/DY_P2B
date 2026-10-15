#!/usr/bin/env python3
"""Run all Kira jobs of RRR_reductions/jobs/, N at a time, with CPU/RAM monitoring, logs and statistics.

    python3 run_reductions.py run    [--parallel 5] [--threads 4] [--only g01,g02] [--retry-failed]
                                     [--interval 30] [--report 600] [--min-free-gb 0] [--kira PATH]
    python3 run_reductions.py status     # one line per job (also while the driver runs)
    python3 run_reductions.py stats      # totals, resources per job, estimate of what is left
    python3 run_reductions.py stop       # SIGTERM to the driver: it stops its Kira jobs, they go back to the queue

Run it detached on the cluster, e.g.  nohup python3 run_reductions.py run > /dev/null 2>&1 &   (or in tmux).

What it does
  queue      every jobs/<group>/ with a jobs.yaml (or --only), largest first (#integrals in toreduce/); groups already
             done are skipped, failed ones only with --retry-failed. A group that is (re)started is cleaned first
             (Kira output: sectors/ results/ tmp/ firefly_saves/ kira.out); config/, toreduce/, jobs.yaml are kept.
  running    nice -n 19 kira --parallel=<threads> jobs.yaml in the group folder, output in <group>/kira.out, each job in
             its own process group (Kira and its Fermat helpers). At most --parallel jobs; a new one starts only if
             the machine has at least --min-free-gb of available memory (Linux).
  monitoring every --interval s: per job RAM (sum of RSS over its processes), CPU (cores in use, from the CPU time
             between two samples), number of processes -> run_state/samples/<group>.csv; peaks in the state file.
             Every --report s a summary of the running jobs and of the machine (load, available memory) in the log.
  end of job exit code + CPU time from the kernel (os.wait4: Kira and every helper it waited for). Done = exit 0
             and a non-empty results/; otherwise failed, with the end of kira.out in the log.
  stop       SIGTERM/SIGINT to the driver (or 'stop'): Kira jobs are terminated (SIGTERM, SIGKILL after 15 s) and
             marked 'killed'; the next 'run' restarts them from scratch. If the driver died (kill -9, lost session),
             the next 'run' kills the orphaned Kira jobs it left (by process group) and requeues them.
Files (run_state/, not in git): driver.log, state.json, samples/<group>.csv, driver.pid.
"""
import argparse
import datetime
import glob
import json
import os
import re
import shutil
import signal
import statistics
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
KIRA_OUTPUT = ("sectors", "results", "tmp", "firefly_saves", "kira.out", "kira.log")
GB = 1024 ** 3

STOP = False


def on_signal(signum, frame):
    global STOP
    STOP = True


# ---------------------------------------------------------------- small helpers
def now():
    return time.time()


def stamp(t=None):
    return datetime.datetime.fromtimestamp(t or now()).strftime("%Y-%m-%d %H:%M:%S")


def hms(sec):
    sec = int(sec or 0)
    return f"{sec // 3600:d}:{sec % 3600 // 60:02d}:{sec % 60:02d}"


def gb(nbytes):
    return f"{(nbytes or 0) / GB:.1f}"


class Log:
    def __init__(self, path, quiet=False):
        self.f = open(path, "a", buffering=1)
        self.quiet = quiet

    def __call__(self, msg):
        line = f"[{stamp()}] {msg}"
        self.f.write(line + "\n")
        if not self.quiet:
            print(line, flush=True)


def load_state(path):
    try:
        return json.load(open(path))
    except (OSError, ValueError):
        return {"jobs": {}, "driver": {}}


def save_state(path, state):
    tmp = path + ".tmp"
    with open(tmp, "w") as f:
        json.dump(state, f, indent=1, sort_keys=True)
    os.replace(tmp, path)


def alive(pid):
    try:
        os.kill(pid, 0)
        return True
    except (OSError, TypeError):
        return False


def driver_pid(state_dir):
    try:
        pid = int(open(os.path.join(state_dir, "driver.pid")).read())
    except (OSError, ValueError):
        return None
    return pid if alive(pid) else None


def mem_available():
    """bytes of available memory (Linux /proc/meminfo), None elsewhere"""
    try:
        for line in open("/proc/meminfo"):
            if line.startswith("MemAvailable:"):
                return int(line.split()[1]) * 1024
    except OSError:
        pass
    return None


def cpu_seconds(field):
    """ps 'time' field: [dd-][hh:]mm:ss[.xx] -> seconds"""
    days = 0
    if "-" in field:
        d, field = field.split("-", 1)
        days = int(d)
    parts = [float(x) for x in field.split(":")]
    sec = 0.0
    for p in parts:
        sec = sec * 60 + p
    return days * 86400 + sec


def process_groups():
    """pgid -> (rss bytes, cumulative CPU s of the live processes, #processes), from one ps call"""
    out = subprocess.run(["ps", "-A", "-o", "pgid=,rss=,time="], capture_output=True, text=True).stdout
    groups = {}
    for line in out.splitlines():
        f = line.split()
        if len(f) != 3:
            continue
        try:
            pgid, rss, cpu = int(f[0]), int(f[1]) * 1024, cpu_seconds(f[2])
        except ValueError:
            continue
        r, c, n = groups.get(pgid, (0, 0.0, 0))
        groups[pgid] = (r + rss, c + cpu, n + 1)
    return groups


def n_integrals(job_dir):
    n = 0
    for f in glob.glob(os.path.join(job_dir, "toreduce", "*.txt")):
        with open(f) as fh:
            n += sum(1 for line in fh if line.strip())
    return n


def masters(job_dir):
    """best effort: number of master integrals listed by Kira in results/<topo>/masters*"""
    files = glob.glob(os.path.join(job_dir, "results", "*", "masters*"))
    if not files:
        return None
    best = {}
    for f in files:        # 'masters' and 'masters.final' may both exist: take per topology the last one
        topo = os.path.basename(os.path.dirname(f))
        if topo not in best or f.endswith(".final"):
            best[topo] = f
    return sum(1 for f in best.values() for line in open(f) if line.strip())


def tail(path, n=5):
    try:
        with open(path, errors="replace") as f:
            return [line.rstrip() for line in f.readlines()[-n:]]
    except OSError:
        return []


# ---------------------------------------------------------------- run
class Job:
    def __init__(self, name, jobs_dir):
        self.name = name
        self.dir = os.path.join(jobs_dir, name)
        self.proc = None
        self.prev = None          # (time, cpu) of the previous sample
        self.csv = None


def cmd_run(args):
    os.makedirs(os.path.join(args.state_dir, "samples"), exist_ok=True)
    state_path = os.path.join(args.state_dir, "state.json")
    if driver_pid(args.state_dir):
        sys.exit(f"a driver is already running (pid {driver_pid(args.state_dir)}); 'stop' it first")
    kira = shutil.which(args.kira) or (args.kira if os.access(args.kira, os.X_OK) else None)
    if not kira:
        sys.exit(f"kira not found ('{args.kira}'): put it on PATH or pass --kira /path/to/kira")
    log = Log(os.path.join(args.state_dir, "driver.log"))
    state = load_state(state_path)
    jobs = state["jobs"]

    names = sorted(os.path.basename(os.path.dirname(p)) for p in glob.glob(os.path.join(args.jobs_dir, "*", "jobs.yaml")))
    if args.only:
        wanted = args.only.split(",")
        missing = [n for n in wanted if n not in names]
        if missing:
            sys.exit(f"no jobs/<group>/jobs.yaml for: {', '.join(missing)}")
        names = wanted
    if not names:
        sys.exit(f"no jobs in {args.jobs_dir}")
    for n, j in jobs.items():                             # stale entries of a dead driver (all groups, not only --only)
        if j["status"] == "running":
            if alive(j.get("pid")):                       # its Kira may still run as an orphan: stop it first
                try:
                    os.killpg(j["pid"], signal.SIGKILL)
                    log(f"{n}: orphan Kira of a dead driver (process group {j['pid']}) killed")
                except OSError:
                    pass
            log(f"{n}: was 'running' under a dead driver -> requeued")
            j["status"] = "killed"
    queue = []
    for n in names:
        j = jobs.setdefault(n, {"status": "queued"})
        j["name"] = n
        if j["status"] == "done" or (j["status"] == "failed" and not args.retry_failed):
            continue
        d = os.path.join(args.jobs_dir, n)
        if not glob.glob(os.path.join(d, "toreduce", "*.txt")):
            log(f"{n}: toreduce/ is empty (rsync the integral lists first) -> skipped")
            continue
        j["n_int"] = n_integrals(d)
        queue.append(n)
    queue.sort(key=lambda n: -jobs[n]["n_int"])
    skipped = {s: sum(1 for n in names if jobs[n]["status"] == s) for s in ("done", "failed")}

    with open(os.path.join(args.state_dir, "driver.pid"), "w") as f:
        f.write(str(os.getpid()))
    state["driver"] = {"pid": os.getpid(), "start": now(), "parallel": args.parallel, "threads": args.threads,
                       "host": os.uname().nodename, "kira": kira}
    save_state(state_path, state)
    signal.signal(signal.SIGTERM, on_signal)
    signal.signal(signal.SIGINT, on_signal)
    log(f"driver start on {os.uname().nodename}: {len(queue)} jobs queued ({skipped['done']} done, "
        f"{skipped['failed']} failed skipped), {args.parallel} at a time x {args.threads} threads, kira = {kira}")
    if args.min_free_gb and mem_available() is None:
        log("note: --min-free-gb needs /proc/meminfo (Linux); ignored here")

    running = {}
    last_report = 0.0
    waiting_mem = False
    while (queue or running) and not STOP:
        # ---- start new jobs
        while queue and len(running) < args.parallel and not STOP:
            avail = mem_available()
            if args.min_free_gb and avail is not None and avail < args.min_free_gb * GB:
                if not waiting_mem:
                    log(f"waiting: available memory {gb(avail)} GB < --min-free-gb {args.min_free_gb}")
                    waiting_mem = True
                break
            waiting_mem = False
            name = queue.pop(0)
            job = Job(name, args.jobs_dir)
            for x in KIRA_OUTPUT:
                p = os.path.join(job.dir, x)
                if os.path.isdir(p):
                    shutil.rmtree(p, ignore_errors=True)
                elif os.path.exists(p):
                    os.remove(p)
            out = open(os.path.join(job.dir, "kira.out"), "w")
            job.proc = subprocess.Popen(["nice", "-n", "19", kira, f"--parallel={args.threads}", "jobs.yaml"],
                                        cwd=job.dir, stdout=out, stderr=subprocess.STDOUT, stdin=subprocess.DEVNULL,
                                        start_new_session=True)
            out.close()
            job.csv = open(os.path.join(args.state_dir, "samples", f"{name}.csv"), "w", buffering=1)
            job.csv.write("time,elapsed_s,rss_GB,cores,nproc\n")
            job.prev = (now(), 0.0)
            running[name] = job
            jobs[name].update({"status": "running", "start": now(), "end": None, "pid": job.proc.pid,
                               "peak_rss": 0, "max_cores": 0.0, "last_rss": 0, "last_cores": 0.0, "nproc": 0,
                               "threads": args.threads, "rc": None, "cpu": None, "wall": None, "masters": None})
            log(f"{name}: start (pid {job.proc.pid}, {jobs[name]['n_int']} integrals); "
                f"running {len(running)}, queued {len(queue)}")
        save_state(state_path, state)

        # ---- sleep in small steps, reacting quickly to finished jobs and signals
        t_end = now() + args.interval
        while now() < t_end and not STOP:
            if any(finished(j) for j in running.values()):
                break
            time.sleep(1)

        # ---- sample all running jobs
        groups = process_groups()
        t = now()
        for name, job in running.items():
            rss, cpu, nproc = groups.get(job.proc.pid, (0, 0.0, 0))
            t0, c0 = job.prev
            cores = max(cpu - c0, 0.0) / max(t - t0, 1e-6)
            job.prev = (t, cpu)
            j = jobs[name]
            j.update({"last_rss": rss, "last_cores": round(cores, 2), "nproc": nproc,
                      "peak_rss": max(j["peak_rss"], rss), "max_cores": round(max(j["max_cores"], cores), 2),
                      "cpu_live": cpu})
            job.csv.write(f"{stamp(t)},{t - j['start']:.0f},{rss / GB:.3f},{cores:.2f},{nproc}\n")

        # ---- collect finished jobs
        for name in [n for n, j in running.items() if j.proc.returncode is not None or finished(j)]:
            job = running.pop(name)
            collect(job, jobs[name], log)
        save_state(state_path, state)

        if now() - last_report >= args.report and running:
            last_report = now()
            report(running, jobs, queue, log)

    if STOP:
        log(f"stop requested: terminating {len(running)} running job(s)")
        for name, job in running.items():
            try:
                os.killpg(job.proc.pid, signal.SIGTERM)
            except OSError:
                pass
        t0 = now()
        while any(job.proc.returncode is None and not finished(job) for job in running.values()) and now() - t0 < 15:
            time.sleep(1)
        for name, job in running.items():
            try:
                os.killpg(job.proc.pid, signal.SIGKILL)
            except OSError:
                pass
            if job.proc.returncode is None:
                try:
                    job.proc.wait(timeout=5)
                except subprocess.TimeoutExpired:
                    pass
            jobs[name].update({"status": "killed", "end": now(), "wall": now() - jobs[name]["start"]})
            job.csv.close()
            log(f"{name}: killed after {hms(jobs[name]['wall'])} (requeued for the next run)")
    save_state(state_path, state)
    done = sum(1 for n in names if jobs[n]["status"] == "done")
    log(f"driver end: {done}/{len(names)} done, "
        f"{sum(1 for n in names if jobs[n]['status'] == 'failed')} failed, "
        f"{sum(1 for n in names if jobs[n]['status'] in ('queued', 'killed'))} not run")
    try:
        os.remove(os.path.join(args.state_dir, "driver.pid"))
    except OSError:
        pass
    print_stats(state, names, log)


def finished(job):
    """reap the job if its main process ended; keep the kernel's resource usage"""
    if job.proc.returncode is not None:
        return True
    try:
        pid, status, ru = os.wait4(job.proc.pid, os.WNOHANG)
    except ChildProcessError:
        job.proc.returncode = job.proc.returncode if job.proc.returncode is not None else -1
        return True
    if pid == 0:
        return False
    job.proc.returncode = os.waitstatus_to_exitcode(status)
    job.rusage = ru
    return True


def collect(job, j, log):
    end = now()
    ru = getattr(job, "rusage", None)
    cpu = ru.ru_utime + ru.ru_stime if ru else 0.0
    cpu = max(cpu, j.get("cpu_live") or 0.0)
    rc = job.proc.returncode
    results = [f for f in glob.glob(os.path.join(job.dir, "results", "**", "*"), recursive=True) if os.path.isfile(f)]
    ok = rc == 0 and results
    wall = end - j["start"]
    j.update({"status": "done" if ok else "failed", "end": end, "wall": wall, "cpu": cpu, "rc": rc,
              "avg_cores": round(cpu / max(wall, 1e-6), 2), "n_results": len(results),
              "masters": masters(job.dir) if ok else None})
    job.csv.close()
    msg = (f"{job.name}: {j['status'].upper()} rc={rc} wall {hms(wall)}, CPU {cpu / 3600:.2f} h "
           f"(avg {j['avg_cores']} cores), peak RAM {gb(j['peak_rss'])} GB")
    if ok:
        msg += f", {len(results)} result files" + (f", {j['masters']} masters" if j["masters"] is not None else "")
    log(msg)
    if not ok:
        why = "exit code != 0" if rc != 0 else "no files in results/"
        log(f"{job.name}: failed ({why}); end of kira.out:")
        for line in tail(os.path.join(job.dir, "kira.out"), 8):
            log(f"    | {line}")


def report(running, jobs, queue, log):
    avail = mem_available()
    load = os.getloadavg()
    log(f"--- {len(running)} running, {len(queue)} queued; load {load[0]:.0f}/{load[1]:.0f}/{load[2]:.0f}"
        + (f", available memory {gb(avail)} GB" if avail is not None else ""))
    for name in running:
        j = jobs[name]
        log(f"    {name}: {hms(now() - j['start'])}  RAM {gb(j['last_rss'])} GB (peak {gb(j['peak_rss'])}), "
            f"{j['last_cores']} cores, {j['nproc']} procs")


# ---------------------------------------------------------------- status / stats
def cmd_status(args):
    state = load_state(os.path.join(args.state_dir, "state.json"))
    jobs = state["jobs"]
    if not jobs:
        sys.exit("no state yet (run first)")
    pid = driver_pid(args.state_dir)
    d = state.get("driver", {})
    print(f"driver: {'running, pid ' + str(pid) if pid else 'not running'}"
          + (f" (started {stamp(d['start'])} on {d.get('host')}, {d.get('parallel')} x {d.get('threads')} threads)"
             if d.get("start") else ""))
    counts = {}
    for j in jobs.values():
        counts[j["status"]] = counts.get(j["status"], 0) + 1
    print("jobs:   " + ", ".join(f"{v} {k}" for k, v in sorted(counts.items())))
    print(f"\n{'group':6} {'status':8} {'#int':>7} {'started':19} {'wall':>9} {'CPU h':>7} {'cores':>6} "
          f"{'RAM GB':>7} {'peak GB':>8} {'masters':>7}")
    order = {"running": 0, "failed": 1, "killed": 2, "queued": 3, "done": 4}
    for name in sorted(jobs, key=lambda n: (order.get(jobs[n]["status"], 9), n)):
        j = jobs[name]
        run = j["status"] == "running"
        wall = now() - j["start"] if run and j.get("start") else j.get("wall")
        cpu = (j.get("cpu_live") if run else j.get("cpu")) or 0
        cores = j.get("last_cores") if run else j.get("avg_cores")
        print(f"{name:6} {j['status']:8} {j.get('n_int', 0):7d} "
              f"{stamp(j['start']) if j.get('start') else '-':19} {hms(wall) if wall else '-':>9} "
              f"{cpu / 3600:7.2f} {cores if cores is not None else '-':>6} "
              f"{gb(j.get('last_rss')) if run else '-':>7} {gb(j.get('peak_rss')):>8} "
              f"{j['masters'] if j.get('masters') is not None else '-':>7}")


def print_stats(state, names, out=print):
    jobs = state["jobs"]
    done = [jobs[n] for n in names if jobs[n].get("status") == "done"]
    todo = [jobs[n] for n in names if jobs[n].get("status") in ("queued", "killed", "running", "failed")]
    out(f"=== statistics: {len(done)} done, {len(todo)} not done")
    if not done:
        return
    walls = [j["wall"] for j in done]
    cpus = [j["cpu"] for j in done]
    peaks = [j["peak_rss"] for j in done]
    nint = sum(j.get("n_int", 0) for j in done)
    out(f"    wall per job: mean {hms(statistics.mean(walls))}, median {hms(statistics.median(walls))}, "
        f"max {hms(max(walls))}")
    out(f"    CPU: total {sum(cpus) / 3600:.1f} h, per job mean {statistics.mean(cpus) / 3600:.2f} h; "
        f"{sum(cpus) / max(nint, 1):.2f} CPU s per integral")
    out(f"    peak RAM per job: mean {gb(statistics.mean(peaks))} GB, max {gb(max(peaks))} GB "
        f"({max(done, key=lambda j: j['peak_rss']).get('name', '')})")
    ms = [j["masters"] for j in done if j.get("masters") is not None]
    if ms:
        out(f"    masters: {sum(ms)} in total over {len(ms)} groups (before identifying them across groups)")
    left = sum(j.get("n_int", 0) for j in todo)
    if todo and nint:
        par = state.get("driver", {}).get("parallel") or 1
        cpu_left = sum(cpus) / nint * left
        wall_left = sum(walls) / nint * left / par
        out(f"    left: {left} integrals in {len(todo)} groups -> ~{cpu_left / 3600:.1f} CPU h, "
            f"~{hms(wall_left)} wall with {par} in parallel (scaling by #integrals; rough)")
    longest = sorted((n for n in names if jobs[n].get("status") == "done"), key=lambda n: -jobs[n]["wall"])[:5]
    out("    longest: " + ", ".join(f"{n} {hms(jobs[n]['wall'])} ({jobs[n].get('n_int', 0)} int)" for n in longest))


def cmd_stats(args):
    state = load_state(os.path.join(args.state_dir, "state.json"))
    if not state["jobs"]:
        sys.exit("no state yet (run first)")
    for n, j in state["jobs"].items():
        j["name"] = n
    names = sorted(state["jobs"])
    print_stats(state, names)
    failed = [n for n in names if state["jobs"][n]["status"] == "failed"]
    if failed:
        print(f"    failed: {', '.join(failed)} (see run_state/driver.log and jobs/<group>/kira.out; "
              f"rerun with --retry-failed)")


def cmd_stop(args):
    pid = driver_pid(args.state_dir)
    if not pid:
        sys.exit("no driver running")
    os.kill(pid, signal.SIGTERM)
    print(f"SIGTERM sent to the driver (pid {pid}); it stops its Kira jobs within ~15 s (see run_state/driver.log)")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("command", choices=["run", "status", "stats", "stop"])
    ap.add_argument("--parallel", type=int, default=5, help="Kira jobs at the same time (default 5)")
    ap.add_argument("--threads", type=int, default=4, help="kira --parallel per job (default 4)")
    ap.add_argument("--only", help="comma-separated groups (default: all jobs/*)")
    ap.add_argument("--retry-failed", action="store_true", help="also rerun groups that failed")
    ap.add_argument("--interval", type=int, default=30, help="seconds between samples (default 30)")
    ap.add_argument("--report", type=int, default=600, help="seconds between summaries in the log (default 600)")
    ap.add_argument("--min-free-gb", type=float, default=0, help="start a job only with this much available memory")
    ap.add_argument("--kira", default=os.environ.get("KIRA", "kira"), help="Kira executable (default $KIRA or kira)")
    ap.add_argument("--jobs-dir", default=os.path.join(HERE, "jobs"))
    ap.add_argument("--state-dir", default=os.path.join(HERE, "run_state"))
    args = ap.parse_args()
    {"run": cmd_run, "status": cmd_status, "stats": cmd_stats, "stop": cmd_stop}[args.command](args)


if __name__ == "__main__":
    main()
