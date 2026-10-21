#!/usr/bin/env python3
"""[Code_RRV: one-loop amplitude (diagram set 1) x tree conjugate (set 0), two emissions r1, r2; qgraf, 01, 02 run both sets, 03 the tree] The whole pipeline for many channels at once, with one global job queue: QGRAF, steps 01 (parse, colour), 02 (groups
of 10 diagrams), 03 (conjugates), 04 (square), 05 (contract, partial fractions, families), 06 (sum, relabelling).
Linux (and macOS for tests). Run from anywhere after `source Code_RRR/setenv.sh`.

  python3 run_all.py run      --set gluons --jobs 100     run (or resume) everything of the set
  python3 run_all.py status   --set gluons                progress per channel and step, memory, CPU, ETA (any time)
  python3 run_all.py check    --set gluons                scan all outputs: missing, leftovers, made with old templates
  python3 run_all.py verify   --set gluons --n 2          numerical check of random finished step-05 results
  python3 run_all.py selftest [--jobs 8]                  check the local FORM against reference numbers (FORM 5.0)
  python3 run_all.py integrals --set gluons               all distinct integrals to reduce -> Code_RRR/integrals/gluons/
  python3 run_all.py integrals --merge                    union of all collections in Code_RRR/integrals -> .../all/

Sets: gluons = physical_qqbggg (7 channels), quarks = all other groups (42), all; or --channels Vqqbggg,VqqbQ2Q2bg,...
Two sets can run at the same time (two run commands); each keeps its state in run_state/<set>/ (or --state DIR).

Jobs: qgraf, 01, 02, 03 = one per channel, in this order (02 makes groups of 10 diagrams, as the per-channel runner
with "10, 1"); 04 = one group pair (i x conjugate j) of a channel, started once its 03 is done; 05 = one non-zero piece (vv, va, ...) of one pair, started as
soon as its 04 job is done; 06 = one piece of a channel, started when all its 05 jobs are done. The same FORM files as
the per-channel runners are used (utils/4_square_ampl.frm, utils/template_contractPj.frm,
utils/template_sum_squared_diags.frm, Code_RRR/Families). The most expensive jobs are started first.

Resume: a job counts as done only after its output passed the checks below (marker in <state>/done/). After a crash or
Ctrl-C just run the same command again: done jobs are skipped, everything else (also failed jobs) runs again.

Checks after every job (on top of the exit checks inside the FORM files): qgraf: output written, number of diagrams
= NDIAG of process_header.h; 01: one parsed file per diagram; 02/03: ceil(NDIAG/10) groups and as many conjugates;
04: all 28 pieces written; 05: no Prop,
Den(cut), D/DD, TOPO, PropSet, FAM, ISP, scalar products, m2, s12 left, every INT with cut indices 1,1,1,1,1;
06: no dependent family (left-hand sides of symm_loop_crossings.inc) left. Failed jobs keep their folder and
form.log; the reason is in <state>/failed/ and in jobs.csv.

Environment: FORM (default "form"; e.g. FORM="tform -w2"), QGRAF (default "qgraf"), SKIPAA (default 1: aa and a2a2
are not computed), FORMPATH (set by setenv.sh). Rerunning a step of qgraf..03 for a channel invalidates its later steps.
"""
import argparse
import csv
import glob
import hashlib
import heapq
import json
import os
import random
import re
import shlex
import shutil
import signal
import subprocess
import sys
import time

SCRIPTS = os.path.dirname(os.path.abspath(__file__))
CODE = os.path.dirname(SCRIPTS)
FAMDIR = os.path.join(CODE, "Families")
FORM = shlex.split(os.environ.get("FORM", "form"))
SKIPAA = os.environ.get("SKIPAA", "1")
QGRAF = os.environ.get("QGRAF", "qgraf")
PREP = ["qgraf", "01", "02", "03"]                                       # per channel, in this order
ALLSTEPS = PREP + ["04", "05", "06"]
GROUP_SIZE = 10

PIECES = [x + y for x in ("v", "a", "v2", "a2") for y in ("v", "a", "v2", "a2")]
# identical quarks: flavour-1 couplings with the V vertices on different traces (class X, trace tag in step 04)
XPIECES = ["vvX", "vaX", "avX", "aaX"]
PIECES += XPIECES
# pure singlet: V on the closed quark loop of the one-loop amplitude, x conjugate tree
PSPIECES = ["vPSv", "vPSa", "vPSv2", "vPSa2", "aPSv", "aPSa", "aPSv2", "aPSa2"]
PIECES += PSPIECES
EVEN = ["vv", "aa", "vv2", "aa2", "v2v", "a2a", "v2v2", "a2a2", "vvX", "aaX"]          # projector L1
EVEN += ["vPSv", "vPSv2", "aPSa", "aPSa2"]
PROJ = {c: (1 if c in EVEN else 6) for c in PIECES}                      # L6 for the parity-odd pieces
GLUON_GROUPS = {"physical_qqbgg"}
NCUT = 4                       # RR: cut propagators r1^2, r2^2, q^2 - m2, rapidity (INT(topoN, 1,1,1,1, n1,n2,n3))
NPROP = 7                      # propagators per family
LEFTOVERS_05 = [r"\bProp\(", r"\bDen\(cut", r"\bD\d+\b", r"\bDD\d+\b", r"\bTOPO\(", r"\bPropSet\(", r"\bFAM\d\(",
                r"\bISP\(", r"\b[pr]\d\.[pr]\d\b", r"\bm2\b", r"\bs12\b", r"\bq\b"]
VERSION_FILES = ["fams/dens.inc", "fams/fammatch_table.inc", "fams/isp_table.inc", "fams/reconstruct.inc",
                 "fams/symm_loop_crossings.inc"]


# ---------------------------------------------------------------- channels
def read_channels():
    with open(os.path.join(SCRIPTS, "channels.csv")) as f:
        return [(r["group"], r["name"]) for r in csv.DictReader(f)]


def select_channels(args):
    chans = read_channels()
    if args.channels:
        names = set(args.channels.split(","))
        out = [c for c in chans if c[1] in names]
        missing = names - {c[1] for c in out}
        if missing:
            sys.exit(f"unknown channels: {sorted(missing)}")
        return out
    if args.set == "gluons":
        return [c for c in chans if c[0] in GLUON_GROUPS]
    if args.set == "quarks":
        return [c for c in chans if c[0] not in GLUON_GROUPS]
    return chans


def set_name(args):
    return args.set if not args.channels else "custom_" + hashlib.md5(args.channels.encode()).hexdigest()[:6]


class Channel:
    def __init__(self, group, name):
        self.group, self.name = group, name
        self.dir = os.path.join(SCRIPTS, group, name, name + "_LO")
        with open(os.path.join(self.dir, "process_header.h")) as f:
            hdr = f.read()
        # two diagram sets: 1 = one-loop amplitude, 0 = tree (conjugate); pairs = loop group i x tree group j
        self.ndiag = {n: int(re.search(rf'#define NDIAG{n} "(\d+)"', hdr).group(1)) for n in (0, 1)}
        self.ngroups = {n: -(-self.ndiag[n] // GROUP_SIZE) for n in (0, 1)}     # groups of 10 (step 02)
        self.gsize = {n: [min(GROUP_SIZE, self.ndiag[n] - GROUP_SIZE * k) for k in range(self.ngroups[n])]
                      for n in (0, 1)}
        self.pairs = [f"{i}_{j}" for i in range(1, self.ngroups[1] + 1) for j in range(1, self.ngroups[0] + 1)]
        self.weight = 5.0 if group in GLUON_GROUPS else 1.0

    def groups_ok(self):
        """step-02/03 output present and consistent with groups of 10"""
        gdir = os.path.join(self.dir, "tmp", "parsed_diagrams", "groups")
        n1 = len(glob.glob(os.path.join(gdir, f"sum_*_{self.name}_1.dat")))
        n0 = len(glob.glob(os.path.join(gdir, f"sum_*_{self.name}_0.dat")))
        nc = len(glob.glob(os.path.join(gdir, "Csum_*")))
        return n1 == self.ngroups[1] and n0 == nc == self.ngroups[0]

    def cost04(self, pair):
        i, j = map(int, pair.split("_"))
        return self.weight * self.gsize[1][i - 1] * self.gsize[0][j - 1] * 60.0


# ---------------------------------------------------------------- helpers
def md5(path):
    h = hashlib.md5()
    with open(path, "rb") as f:
        for block in iter(lambda: f.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()[:12]


_FAMV = {}


def versions(ch):
    if not _FAMV:
        _FAMV.update({f: md5(os.path.join(FAMDIR, f)) for f in VERSION_FILES})
    v = {"4_square_ampl.frm": md5(os.path.join(ch.dir, "utils", "4_square_ampl.frm")),
         "template_contractPj.frm": md5(os.path.join(ch.dir, "utils", "template_contractPj.frm")),
         "template_sum_squared_diags.frm": md5(os.path.join(ch.dir, "utils", "template_sum_squared_diags.frm"))}
    v.update(_FAMV)
    return v


def is_zero(path):
    if os.path.getsize(path) > 200:                          # a zero piece is "l [interfi_j]= 0;"
        return False
    with open(path) as f:
        return f.read().split("=", 1)[1].strip().rstrip(";").strip() == "0"


def flat(path):
    with open(path) as f:
        return re.sub(r"\s+", "", f.read())


def deptopos():
    with open(os.path.join(FAMDIR, "fams", "symm_loop_crossings.inc")) as f:
        return set(re.findall(r"^id INT\((topo\d+),", f.read(), re.M))


def npf():
    return len(glob.glob(os.path.join(FAMDIR, "partial_fraction", "partialfraction_*.inc")))


def mem_available_gb():
    try:
        with open("/proc/meminfo") as f:
            for line in f:
                if line.startswith("MemAvailable:"):
                    return int(line.split()[1]) / 2**20
    except OSError:
        return None
    return None


def rss_gb(pid):
    try:
        with open(f"/proc/{pid}/status") as f:
            for line in f:
                if line.startswith("VmRSS:"):
                    return int(line.split()[1]) / 2**20
    except OSError:
        pass
    try:                                                     # macOS (tests)
        out = subprocess.run(["ps", "-o", "rss=", "-p", str(pid)], capture_output=True, text=True).stdout.strip()
        return int(out) / 2**20 if out else 0.0
    except (OSError, ValueError):
        return 0.0


def form_reason(log):
    """first meaningful error lines of a FORM log"""
    try:
        with open(log, errors="replace") as f:
            lines = [l.rstrip() for l in f if l.strip() and not l.startswith("    ") and not l.startswith("~~~")]
    except OSError:
        return "no form.log"
    bad = [l for l in lines if not l.startswith("FORM ") and "sec out of" not in l]
    return " | ".join(bad[:3])[:300] if bad else "unknown"


# ---------------------------------------------------------------- output checks
def lint04(ch, pair):
    nonzero = []
    for p in PIECES:
        f = os.path.join(ch.dir, "tmp", "squared_diagrams", p, f"{p}_{pair}.inc")
        if p in XPIECES and not os.path.isfile(f):
            continue                                  # output made before the trace tag: piece is zero
        if not os.path.isfile(f) or os.path.getsize(f) == 0:
            return False, f"missing {p}_{pair}.inc", []
        with open(f) as fh:
            head = fh.read(64)
        if not head.startswith(f"l [interf{pair}]"):
            return False, f"{p}_{pair}.inc: unexpected header", []
        if not is_zero(f):
            nonzero.append(p)
    return True, "", nonzero


def lint05(path):
    if not os.path.isfile(path) or os.path.getsize(path) == 0:
        return False, "no output", 0
    t = flat(path)
    for pat in LEFTOVERS_05:
        m = re.search(pat, t)
        if m:
            return False, f"leftover {m.group(0)}", 0
    ints = re.findall(r"INT\(topo\d+," + ",".join([r"([-\d]+)"] * NCUT) + ",", t)
    bad = [x for x in ints if x != ("1",) * NCUT]
    if bad:
        return False, f"INT with cut indices {','.join(bad[0])}", 0
    return True, "", len(ints)


def lint06(path, dep):
    if not os.path.isfile(path) or os.path.getsize(path) == 0:
        return False, "no output"
    if not os.path.isfile(path[:-3] + ".m"):
        return False, "no .m output"
    t = flat(path)
    left = set(re.findall(r"INT\((topo\d+),", t)) & dep
    if left:
        return False, f"dependent families left: {sorted(left)[:5]}"
    for pat in LEFTOVERS_05:
        m = re.search(pat, t)
        if m:
            return False, f"leftover {m.group(0)}"
    return True, ""


# ---------------------------------------------------------------- jobs
class Job:
    def __init__(self, step, ch, piece, pair, cost):
        self.step, self.ch, self.piece, self.pair, self.cost = step, ch, piece, pair, cost
        self.proc = None
        self.start = None
        self.maxrss = 0.0

    @property
    def key(self):
        return f"{self.step}__{self.ch.name}__{self.piece or '-'}__{self.pair or '-'}"

    def label(self):
        return f"{self.step} {self.ch.name} {self.piece or ''} {self.pair or ''}".replace("  ", " ").strip()

    def __lt__(self, other):
        return self.cost > other.cost              # heapq: most expensive first

    # paths
    def folder(self):
        u = os.path.join(self.ch.dir, "utils")
        if self.step == "qgraf":
            return os.path.join(self.ch.dir, "qgraf")
        if self.step in PREP:
            return self.ch.dir
        if self.step == "04":
            return os.path.join(u, "tmp_fld", f"tmp_{self.pair}")
        if self.step == "05":
            return os.path.join(u, f"job_{self.piece}_{PROJ[self.piece]}_{self.pair}")
        return self.ch.dir

    def formtmp(self, args):
        """own folder for FORM's temporary files: FORM names them xformxxx.* (no process number), so jobs sharing a
        folder would overwrite each other's files"""
        base = os.path.abspath(args.form_tmp) if args.form_tmp else os.path.join(self.ch.dir, "utils")
        return os.path.join(base, "formtmp", self.key)

    def tflag(self, args):
        d = self.formtmp(args)
        shutil.rmtree(d, ignore_errors=True)
        os.makedirs(d)
        return ["-t", d]

    def output(self):
        if self.step == "qgraf":
            return os.path.join(self.ch.dir, "external", f"{self.ch.name}.0.inc")
        if self.step == "05":
            return os.path.join(self.ch.dir, "tmp", "squared_contracted", self.piece,
                                f"unreduced{PROJ[self.piece]}_{self.pair}.ff")
        if self.step == "06":
            return os.path.join(self.ch.dir, "tmp", "unreduced", self.piece, f"unreduced{PROJ[self.piece]}.ff")
        return None

    def prepare(self, args, pairs06=None):
        d, u = self.ch.dir, os.path.join(self.ch.dir, "utils")
        self.stdin = None
        if self.step == "qgraf":
            for n in (0, 1):                                         # QGRAF does not overwrite its output
                f = os.path.join(d, "external", f"{self.ch.name}.{n}.inc")
                if os.path.exists(f):
                    os.remove(f)
            q = shlex.quote(QGRAF)                                   # tree in qgraf/, one loop in qgraf/loop/
            drop = f"{shlex.quote(sys.executable)} {shlex.quote(os.path.join(SCRIPTS, 'tools', 'drop_quark2_loops.py'))}"
            return ["sh", "-c", f"{q} && cd loop && {q} && {drop} ../../external/{self.ch.name}.1.inc"], self.folder()
        if self.step == "01":
            os.makedirs(os.path.join(d, "tmp", "parsed_diagrams", "groups"), exist_ok=True)
            for f in glob.glob(os.path.join(d, "tmp", "parsed_diagrams", "*.dat")):
                os.remove(f)
            f = shlex.join(FORM + self.tflag(args))                 # both sets: one loop, then tree
            return ["sh", "-c", f"{f} -d NLOOP=1 utils/01_colour_algebra.frm && "
                                f"{f} -d NLOOP=0 utils/01_colour_algebra.frm"], d
        if self.step == "02":
            py = shlex.quote(sys.executable)                       # both sets; group size, parallel FORM jobs
            inp = f"printf '{GROUP_SIZE}\\n1\\n'"
            return ["sh", "-c", f"{inp} | {py} utils/02_run_sum_diags_group.py 1 && "
                                f"{inp} | {py} utils/02_run_sum_diags_group.py 0"], d
        if self.step == "03":
            for f in glob.glob(os.path.join(d, "tmp", "parsed_diagrams", "groups", "Csum_*")):
                os.remove(f)
            return FORM + self.tflag(args) + ["utils/03_complex_conj_diags.frm"], d
        if self.step == "04":
            for sub in ("squared_contracted", "unreduced"):
                os.makedirs(os.path.join(d, "tmp", sub), exist_ok=True)
            for p in PIECES:
                os.makedirs(os.path.join(d, "tmp", "squared_diagrams", p), exist_ok=True)
                f = os.path.join(d, "tmp", "squared_diagrams", p, f"{p}_{self.pair}.inc")
                if os.path.exists(f):
                    os.remove(f)
            fo = self.folder()
            shutil.rmtree(fo, ignore_errors=True)
            os.makedirs(fo)
            shutil.copy(os.path.join(u, "4_square_ampl.frm"), fo)
            i, j = self.pair.split("_")
            cmd = FORM + ["-d", "LC=0", "-d", "ONLYVECTOR=0", "-d", f"SKIPAA={SKIPAA}",
                          "-d", f"loopind={i}", "-d", f"loopind2={j}"]
            frm = "4_square_ampl.frm"
        elif self.step == "05":
            os.makedirs(os.path.dirname(self.output()), exist_ok=True)
            if os.path.exists(self.output()):
                os.remove(self.output())
            fo = self.folder()
            shutil.rmtree(fo, ignore_errors=True)
            os.makedirs(fo)
            shutil.copy(os.path.join(u, "template_contractPj.frm"), os.path.join(fo, "contractPj.frm"))
            cmd = FORM + ["-d", f"COUPL={self.piece}", "-d", f"WHICH={self.pair}", "-d", f"PROJ={PROJ[self.piece]}",
                          "-d", f"FAMDIR={FAMDIR}", "-d", f"NPF={npf()}", "-d", "DEBUG=0"]
            frm = "contractPj.frm"
        else:
            os.makedirs(os.path.dirname(self.output()), exist_ok=True)
            for f in (self.output(), self.output()[:-3] + ".m"):
                if os.path.exists(f):
                    os.remove(f)
            with open(os.path.join(u, "template_sum_squared_diags.frm")) as f:
                tpl = f.read()
            dep = sorted(deptopos(), key=lambda t: int(t[4:]))
            name = f"sum_squared_diags_{self.piece}_{PROJ[self.piece]}"
            with open(os.path.join(u, name + ".frm"), "w") as f:
                f.write(tpl.replace("&toreplace", ",".join(sorted(pairs06))).replace("&coupl", self.piece)
                        .replace("&proj", str(PROJ[self.piece])).replace("&famdir", FAMDIR)
                        .replace("&depset", ",".join(dep) or "topo0"))     # no relabelling rules: dummy
            fo = self.folder()
            cmd = list(FORM)
            frm = os.path.join("utils", name + ".frm")
        cmd += self.tflag(args)
        return cmd + [frm], fo

    def logfile(self):
        if self.step in PREP:
            return os.path.join(self.ch.dir, f"run{self.step}.log")
        if self.step == "06":
            return os.path.join(self.ch.dir, "utils", f"sum_squared_diags_{self.piece}_{PROJ[self.piece]}.log")
        return os.path.join(self.folder(), "form.log")

    def verify(self, dep):
        """-> ok, reason, info"""
        ch = self.ch
        if self.step == "qgraf":
            if not os.path.isfile(self.output()):
                return False, "no QGRAF output (see qgraf/../runqgraf.log)", {}
            got = {}
            for n in (0, 1):
                f = os.path.join(ch.dir, "external", f"{ch.name}.{n}.inc")
                if not os.path.isfile(f):
                    return False, f"no QGRAF output {ch.name}.{n}.inc", {}
                with open(f) as fh:
                    got[n] = len(re.findall(r"^id diag\d+ =", fh.read(), re.M))
            ok = all(got[n] == ch.ndiag[n] for n in (0, 1))
            return ok, "" if ok else f"QGRAF gave {got[0]} (tree), {got[1]} (one loop), NDIAG0/1 = {ch.ndiag}", {}
        if self.step == "01":
            got = {n: len(glob.glob(os.path.join(ch.dir, "tmp", "parsed_diagrams",
                                                  f"diag*_{ch.name}_colour_out.{n}.dat"))) for n in (0, 1)}
            ok = all(got[n] == ch.ndiag[n] for n in (0, 1))
            return ok, "" if ok else f"{got} parsed diagrams, NDIAG0/1 = {ch.ndiag}", {}
        if self.step in ("02", "03"):
            gdir = os.path.join(ch.dir, "tmp", "parsed_diagrams", "groups")
            if self.step == "03":
                got = {0: len(glob.glob(os.path.join(gdir, "Csum_*")))}
            else:
                got = {n: len(glob.glob(os.path.join(gdir, f"sum_*_{ch.name}_{n}.dat"))) for n in (0, 1)}
            ok = all(got[n] == ch.ngroups[n] for n in got)
            return ok, "" if ok else f"{got} groups, expected {ch.ngroups}", {}
        if self.step == "04":
            ok, why, nonzero = lint04(self.ch, self.pair)
            return ok, why, {"nonzero": nonzero}
        if self.step == "05":
            ok, why, nint = lint05(self.output())
            return ok, why, {"INT": nint}
        ok, why = lint06(self.output(), dep)
        return ok, why, {}

    def cleanup_tmp(self, args):
        shutil.rmtree(self.formtmp(args), ignore_errors=True)

    def cleanup(self):
        if self.step in PREP:
            return
        if self.step in ("04", "05"):
            shutil.rmtree(self.folder(), ignore_errors=True)
        else:
            for f in (os.path.join(self.ch.dir, "utils", f"sum_squared_diags_{self.piece}_{PROJ[self.piece]}.frm"),
                      self.logfile()):
                if os.path.exists(f):
                    os.remove(f)


# ---------------------------------------------------------------- state
class State:
    def __init__(self, path):
        self.path = path
        for d in ("done", "failed"):
            os.makedirs(os.path.join(path, d), exist_ok=True)
        self.jobs_csv = os.path.join(path, "jobs.csv")
        self.sys_csv = os.path.join(path, "system.csv")

    def done(self, key):
        return os.path.exists(os.path.join(self.path, "done", key + ".json"))

    def read(self, kind, key):
        with open(os.path.join(self.path, kind, key + ".json")) as f:
            return json.load(f)

    def mark(self, kind, key, info):
        other = "failed" if kind == "done" else "done"
        p = os.path.join(self.path, other, key + ".json")
        if os.path.exists(p):
            os.remove(p)
        with open(os.path.join(self.path, kind, key + ".json"), "w") as f:
            json.dump(info, f)

    def log_job(self, row):
        new = not os.path.exists(self.jobs_csv)
        with open(self.jobs_csv, "a", newline="") as f:
            w = csv.writer(f)
            if new:
                w.writerow(["end", "step", "channel", "piece", "pair", "status", "reason", "wall_s", "cpu_s",
                            "maxrss_gb", "output_mb"])
            w.writerow(row)

    def log_sys(self, row):
        new = not os.path.exists(self.sys_csv)
        with open(self.sys_csv, "a", newline="") as f:
            w = csv.writer(f)
            if new:
                w.writerow(["time", "running", "pending", "mem_available_gb", "form_rss_gb", "load1", "disk_free_gb"])
            w.writerow(row)

    def write_json(self, name, obj):
        tmp = os.path.join(self.path, name + ".tmp")
        with open(tmp, "w") as f:
            json.dump(obj, f, indent=1)
        os.replace(tmp, os.path.join(self.path, name))


# ---------------------------------------------------------------- run
def preflight(steps=()):
    if "qgraf" in steps and shutil.which(QGRAF) is None:
        sys.exit(f"QGRAF executable '{QGRAF}' not found (set QGRAF=... or PATH, or leave out the step qgraf)")
    if shutil.which(FORM[0]) is None:
        sys.exit(f"FORM executable '{FORM[0]}' not found (set FORM=... or PATH)")
    fp = os.environ.get("FORMPATH", "")
    if not os.path.isfile(os.path.join(fp, "all_header.h")):
        sys.exit("FORMPATH does not contain all_header.h: source Code_RRR/setenv.sh")
    for f in VERSION_FILES:
        if not os.path.isfile(os.path.join(FAMDIR, f)):
            sys.exit(f"missing {FAMDIR}/{f}: run the Families scripts (family_rules.wl, isp_table.py, fammatch_table.py)")
    if npf() == 0:
        sys.exit(f"no partial-fraction files in {FAMDIR}/partial_fraction")
    cov = os.path.join(FAMDIR, "coverage.py")
    r = subprocess.run([sys.executable, cov], capture_output=True, text=True) if os.path.exists(cov) else None
    if r is not None and r.returncode != 0:
        sys.exit("Families/coverage.py: some propagator sets after partial fractions lie in no family:\n" + r.stdout)


def cmd_run(args):
    steps = set(args.steps.split(","))
    if steps - set(ALLSTEPS):
        sys.exit(f"unknown steps {sorted(steps - set(ALLSTEPS))}; steps are {','.join(ALLSTEPS)}")
    preflight(steps)
    chans = [Channel(g, n) for g, n in select_channels(args)]
    st = State(args.state)
    dep = deptopos()
    run_id = time.strftime("%Y%m%d-%H%M%S")
    print(f"run {run_id}: {len(chans)} channels, steps {sorted(steps)}, {args.jobs} jobs, FORM={' '.join(FORM)}, "
          f"SKIPAA={SKIPAA}, state {args.state}", flush=True)
    st.write_json("config.json", {"run_id": run_id, "channels": [c.name for c in chans], "steps": sorted(steps),
                                  "jobs": args.jobs, "form": FORM, "skipaa": SKIPAA, "host": os.uname().nodename,
                                  "min_free_gb": args.min_free_gb, "max_job_gb": args.max_job_gb})

    heap, plan = [], {}
    pending_05 = {c.name: {} for c in chans}       # channel -> pair -> set of pieces still to do (05)
    nonzero = {c.name: {} for c in chans}          # channel -> pair -> non-zero pieces
    by_name = {c.name: c for c in chans}

    def push(job):
        heapq.heappush(heap, job)

    def add05(ch, pair, pieces):
        nonzero[ch.name][pair] = pieces
        pending_05[ch.name][pair] = set()
        for p in pieces:
            j = Job("05", ch, p, pair, 0)
            if st.done(j.key):
                continue
            f = os.path.join(ch.dir, "tmp", "squared_diagrams", p, f"{p}_{pair}.inc")
            j.cost = os.path.getsize(f) / 1e6 * (3.0 if PROJ[p] == 6 else 1.0) * ch.weight
            pending_05[ch.name][pair].add(p)
            if "05" in steps:
                push(j)

    def maybe06(ch):
        if "06" not in steps or len(nonzero[ch.name]) < len(ch.pairs):
            return
        if any(pending_05[ch.name][p] for p in ch.pairs):
            return
        pieces = sorted({p for ps in nonzero[ch.name].values() for p in ps})
        for p in pieces:
            j = Job("06", ch, p, None, 1e12)
            if not st.done(j.key) and j.key not in queued06:
                queued06.add(j.key)
                push(j)

    queued06 = set()

    def next_stage(ch):
        """queue the channel's next preparation step (qgraf, 01, 02, 03), or, when those are done, its 04 jobs"""
        for s in PREP:
            j = Job(s, ch, None, None, 1e13)
            if s in steps and not st.done(j.key):
                push(j)
                return
        if not ch.groups_ok():
            if steps & {"04", "05", "06"}:
                print(f"{ch.name}: no step-02/03 groups (expected {ch.ngroups}): add the steps 01,02,03", flush=True)
            return
        for pair in ch.pairs:
            j = Job("04", ch, None, pair, ch.cost04(pair))
            if st.done(j.key):
                add05(ch, pair, st.read("done", j.key)["nonzero"])
            elif "04" in steps:
                push(j)
        maybe06(ch)

    def invalidate_after(ch, step):
        """a preparation step was redone: the channel's later steps are no longer valid"""
        later = ALLSTEPS[ALLSTEPS.index(step) + 1:]
        for s in later:
            for f in glob.glob(os.path.join(args.state, "done", f"{s}__{ch.name}__*.json")):
                os.remove(f)
        nonzero[ch.name].clear()
        pending_05[ch.name].clear()

    for ch in chans:
        plan[ch.name] = {"group": ch.group, "pairs": len(ch.pairs), "ndiag": ch.ndiag}
        next_stage(ch)
    st.write_json("plan.json", plan)

    running = {}
    stop = {"flag": False}

    def handler(signum, frame):
        stop["flag"] = True
    signal.signal(signal.SIGINT, handler)
    signal.signal(signal.SIGTERM, handler)

    def start(job):
        cmd, cwd = job.prepare(args, pairs06=[p for p, ps in nonzero[job.ch.name].items() if job.piece in ps]
                               if job.step == "06" else None)
        log = open(job.logfile(), "w")
        nice = args.nice

        def pre():
            os.setpgrp()
            if nice:
                os.nice(nice)
        job.proc = subprocess.Popen(cmd, cwd=cwd, stdout=log, stderr=subprocess.STDOUT, preexec_fn=pre,
                                    stdin=subprocess.PIPE if job.stdin else subprocess.DEVNULL)
        if job.stdin:
            job.proc.stdin.write(job.stdin.encode())
            job.proc.stdin.close()
        log.close()
        job.start = time.time()
        running[job.proc.pid] = job

    def finish(job, status_code, rusage, killed_reason=None):
        wall = time.time() - job.start
        cpu = rusage.ru_utime + rusage.ru_stime if rusage else 0.0
        maxrss = (rusage.ru_maxrss / (2**20 if sys.platform != "darwin" else 2**30)) if rusage else job.maxrss
        rc = os.waitstatus_to_exitcode(status_code) if status_code is not None else -1
        if killed_reason:
            ok, why, info = False, killed_reason, {}
        elif rc != 0:
            ok, why, info = False, f"FORM rc={rc}: {form_reason(job.logfile())}", {}
        else:
            ok, why, info = job.verify(dep)
        job.cleanup_tmp(args)
        out = job.output()
        out_mb = os.path.getsize(out) / 1e6 if out and os.path.exists(out) else 0.0
        info.update({"wall_s": round(wall, 1), "cpu_s": round(cpu, 1), "maxrss_gb": round(maxrss, 3),
                     "output_mb": round(out_mb, 2), "end": time.strftime("%Y-%m-%d %H:%M:%S"), "run_id": run_id,
                     "versions": versions(job.ch), "reason": why, "log": job.logfile()})
        st.mark("done" if ok else "failed", job.key, info)
        st.log_job([info["end"], job.step, job.ch.name, job.piece or "", job.pair or "", "done" if ok else "FAILED",
                    why, info["wall_s"], info["cpu_s"], info["maxrss_gb"], info["output_mb"]])
        print(f"{info['end']}  {'done  ' if ok else 'FAILED'} {job.label():35s} cpu {cpu/60:7.1f} min  "
              f"{maxrss:6.2f} GB  {('  ' + why) if why else ''}", flush=True)
        if ok:
            job.cleanup()
            if job.step in PREP:
                invalidate_after(job.ch, job.step)
                next_stage(job.ch)
            if job.step == "04":
                add05(job.ch, job.pair, info["nonzero"])
            if job.step in ("04", "05"):
                if job.step == "05":
                    pending_05[job.ch.name][job.pair].discard(job.piece)
                maybe06(job.ch)

    last_sample = 0.0
    while (heap or running) and not stop["flag"]:
        # finished jobs
        for pid, job in list(running.items()):
            try:
                rpid, status, ru = os.wait4(pid, os.WNOHANG)
            except ChildProcessError:
                rpid, status, ru = pid, None, None
            if rpid == 0:
                continue
            del running[pid]
            finish(job, status, ru, getattr(job, "killed", None))
        now = time.time()
        # memory: per-job limit, system sample
        if now - last_sample >= args.sample:
            last_sample = now
            tot = 0.0
            for pid, job in running.items():
                r = rss_gb(pid)
                job.maxrss = max(job.maxrss, r)
                tot += r
                if args.max_job_gb and r > args.max_job_gb and not getattr(job, "killed", None):
                    job.killed = f"killed: memory {r:.1f} GB > --max-job-gb {args.max_job_gb}"
                    os.killpg(pid, signal.SIGTERM)
            avail = mem_available_gb()
            st.log_sys([time.strftime("%Y-%m-%d %H:%M:%S"), len(running), len(heap),
                        round(avail, 1) if avail is not None else "", round(tot, 2),
                        round(os.getloadavg()[0], 1), round(shutil.disk_usage(SCRIPTS).free / 2**30, 1)])
            st.write_json("running.json", {"time": time.strftime("%Y-%m-%d %H:%M:%S"), "pending": len(heap),
                                           "pending_by_step": {s: sum(1 for j in heap if j.step == s)
                                                               for s in ("04", "05", "06")},
                                           "jobs": [{"job": j.label(), "pid": p, "elapsed_min": round((now - j.start) / 60, 1),
                                                     "rss_gb": round(rss_gb(p), 2)} for p, j in running.items()]})
        # start new jobs
        while heap and len(running) < args.jobs and not stop["flag"]:
            avail = mem_available_gb()
            if avail is not None and avail < args.min_free_gb:
                break
            start(heapq.heappop(heap))
        time.sleep(1)

    if stop["flag"]:
        print(f"stopping: terminating {len(running)} running FORM jobs (they will run again on the next start)",
              flush=True)
        for pid in running:
            try:
                os.killpg(pid, signal.SIGTERM)
            except ProcessLookupError:
                pass
        for pid in list(running):
            try:
                os.waitpid(pid, 0)
            except ChildProcessError:
                pass
        sys.exit(1)
    nfail = len(glob.glob(os.path.join(args.state, "failed", "*.json")))
    print(f"finished: {nfail} failed jobs" + (f" (see {args.state}/failed/, run again to retry)" if nfail else ""),
          flush=True)
    sys.exit(1 if nfail else 0)


# ---------------------------------------------------------------- status
def cmd_status(args):
    st = State(args.state)
    try:
        plan = json.load(open(os.path.join(args.state, "plan.json")))
        cfg = json.load(open(os.path.join(args.state, "config.json")))
    except OSError:
        sys.exit(f"no run state in {args.state}")
    done = {os.path.basename(p)[:-5]: p for p in glob.glob(os.path.join(args.state, "done", "*.json"))}
    failed = {os.path.basename(p)[:-5]: p for p in glob.glob(os.path.join(args.state, "failed", "*.json"))}
    try:
        run = json.load(open(os.path.join(args.state, "running.json")))
    except OSError:
        run = {"jobs": [], "pending": 0, "time": "-"}
    running_by = {}
    for j in run["jobs"]:
        s, name = j["job"].split()[:2]
        running_by[(name, s)] = running_by.get((name, s), 0) + 1

    def count(name, step, d):
        return sum(1 for k in d if k.startswith(f"{step}__{name}__"))

    cpu = {"04": [], "05": [], "06": []}
    for k, p in done.items():
        try:
            cpu.setdefault(k.split("__")[0], []).append(json.load(open(p))["cpu_s"])
        except (OSError, KeyError, ValueError):
            pass
    print(f"set {cfg.get('channels') and len(cfg['channels'])} channels, {cfg['jobs']} jobs, host {cfg.get('host')}, "
          f"state {args.state}, last update {run['time']}")
    print(f"{'channel':16s} {'prep':>6s} {'04 done/all':>12s} {'05 done/known':>14s} {'06 done':>8s} {'running':>8s} "
          f"{'FAILED':>7s}")
    tot = {"04": [0, 0], "05": [0, 0], "06": [0], "run": 0, "fail": 0}
    for name, p in plan.items():
        d04, d05, d06 = count(name, "04", done), count(name, "05", done), count(name, "06", done)
        # known 05 jobs: non-zero pieces of the finished 04 jobs
        k05 = 0
        for k, path in done.items():
            if k.startswith(f"04__{name}__"):
                try:
                    k05 += len(json.load(open(path))["nonzero"])
                except (OSError, KeyError, ValueError):
                    pass
        nrun = sum(v for (n, s), v in running_by.items() if n == name)
        nfail = sum(1 for k in failed if f"__{name}__" in k)
        prep = ([s for s in PREP if count(name, s, done)] or ["-"])[-1]
        print(f"{name:16s} {prep:>6s} {d04:5d}/{p['pairs']:<6d} {d05:6d}/{k05:<7d} {d06:8d} {nrun:8d} {nfail:7d}")
        tot["04"][0] += d04
        tot["04"][1] += p["pairs"]
        tot["05"][0] += d05
        tot["05"][1] += k05
        tot["06"][0] += d06
        tot["run"] += nrun
        tot["fail"] += nfail
    print(f"{'TOTAL':16s} {'':>6s} {tot['04'][0]:5d}/{tot['04'][1]:<6d} {tot['05'][0]:6d}/{tot['05'][1]:<7d} "
          f"{tot['06'][0]:8d} {tot['run']:8d} {tot['fail']:7d}")
    for s in ALLSTEPS:
        if cpu.get(s):
            print(f"step {s}: {len(cpu[s])} done, CPU {sum(cpu[s])/3600:.1f} h, mean {sum(cpu[s])/len(cpu[s])/60:.1f} min, "
                  f"max {max(cpu[s])/60:.1f} min")
    # rough ETA: remaining 04 x mean04 + (known remaining 05 + 05 expected from remaining 04) x mean05, / jobs
    if cpu["04"] and cpu["05"]:
        m4, m5 = sum(cpu["04"]) / len(cpu["04"]), sum(cpu["05"]) / len(cpu["05"])
        per_pair = tot["05"][1] / max(tot["04"][0], 1)
        rem = (tot["04"][1] - tot["04"][0]) * (m4 + per_pair * m5) + (tot["05"][1] - tot["05"][0]) * m5
        print(f"ETA (rough, {cfg['jobs']} jobs): {rem / cfg['jobs'] / 3600:.1f} h")
    try:
        with open(st.sys_csv) as f:
            last = list(csv.reader(f))[-1]
        print(f"system ({last[0]}): {last[1]} running, {last[2]} pending, available memory {last[3]} GB, "
              f"FORM memory {last[4]} GB, load {last[5]}, free disk {last[6]} GB")
    except (OSError, IndexError):
        pass
    if args.running:
        for j in sorted(run["jobs"], key=lambda j: -j["elapsed_min"]):
            print(f"  {j['job']:35s} {j['elapsed_min']:8.1f} min {j['rss_gb']:7.2f} GB")
    if failed:
        print("failed jobs (reason):")
        for k, p in sorted(failed.items())[:args.max_failed]:
            try:
                print(f"  {k}: {json.load(open(p))['reason']}")
            except (OSError, KeyError, ValueError):
                print(f"  {k}")


# ---------------------------------------------------------------- check
def cmd_check(args):
    chans = [Channel(g, n) for g, n in select_channels(args)]
    st = State(args.state)
    dep = deptopos()
    problems = 0
    for ch in chans:
        cur = versions(ch)
        msgs = []
        for pair in ch.pairs:
            ok, why, nz = lint04(ch, pair)
            if not ok:
                msgs.append(f"04 {pair}: {why}")
                continue
            for p in nz:
                f = os.path.join(ch.dir, "tmp", "squared_contracted", p, f"unreduced{PROJ[p]}_{pair}.ff")
                if not os.path.exists(f):
                    msgs.append(f"05 {p} {pair}: missing")
                    continue
                ok, why, _ = lint05(f)
                if not ok:
                    msgs.append(f"05 {p} {pair}: {why}")
        for f in glob.glob(os.path.join(ch.dir, "tmp", "unreduced", "*", "unreduced*.ff")):
            ok, why = lint06(f, dep)
            if not ok:
                msgs.append(f"06 {os.path.relpath(f, ch.dir)}: {why}")
        for k in glob.glob(os.path.join(args.state, "done", f"*__{ch.name}__*.json")):
            try:
                v = json.load(open(k))["versions"]
            except (OSError, KeyError, ValueError):
                continue
            changed = [n for n in v if v[n] != cur.get(n)]
            if changed:
                msgs.append(f"{os.path.basename(k)[:-5]}: made with older {', '.join(changed)}")
        problems += len(msgs)
        print(f"{ch.name}: {'ok' if not msgs else str(len(msgs)) + ' problems'}")
        for m in msgs[:args.max_failed]:
            print(f"   {m}")
    print(f"{problems} problems in total")
    sys.exit(1 if problems else 0)


# ---------------------------------------------------------------- verify / selftest
def run_check05(chdir, piece, pair, seed, workdir):
    os.makedirs(workdir, exist_ok=True)
    subprocess.run([sys.executable, os.path.join(SCRIPTS, "tools", "check05.py"), chdir, piece, pair,
                    str(PROJ[piece]), FAMDIR, str(seed), workdir], check=True, capture_output=True)
    r = subprocess.run(FORM + ["check.frm"], cwd=workdir, capture_output=True, text=True)
    text = r.stdout
    verdict = "IDENTICAL" if "~~~IDENTICAL" in text else ("DIFFERENT" if "~~~DIFFERENT" in text else
                                                         f"ERROR: {form_reason_text(text)}")
    m = re.search(r"\n\s+Before =(.*?);", text, re.S)
    before = re.sub(r"\s+", "", m.group(1)) if m else ""
    return verdict, before


def form_reason_text(text):
    lines = [l for l in text.splitlines() if l.strip() and not l.startswith("    ") and not l.startswith("~~~")
             and not l.startswith("FORM ") and "sec out of" not in l]
    return " | ".join(lines[:3])[:300]


def cmd_verify(args):
    preflight()
    chans = [Channel(g, n) for g, n in select_channels(args)]
    rng = random.Random(args.seed)
    bad = 0
    for ch in chans:
        files = glob.glob(os.path.join(ch.dir, "tmp", "squared_contracted", "*", "unreduced*_*.ff"))
        for f in rng.sample(files, min(args.n, len(files))):
            piece = os.path.basename(os.path.dirname(f))
            pair = re.search(r"_(\d+_\d+)\.ff$", f).group(1)
            work = os.path.join(args.state, "verify", f"{ch.name}_{piece}_{pair}")
            verdict, _ = run_check05(ch.dir, piece, pair, rng.randint(1, 10**6), work)
            bad += verdict != "IDENTICAL"
            print(f"{ch.name:16s} {piece:5s} {pair:6s} {verdict}", flush=True)
            if verdict == "IDENTICAL":
                shutil.rmtree(work, ignore_errors=True)
    sys.exit(1 if bad else 0)



# ---------------------------------------------------------------- integrals
INT_RE = re.compile(r"INT\((topo\d+),([-\d,]+)\)")
INTEGRALS_DIR = os.environ.get("DY_INTEGRALS", os.path.join(CODE, "integrals"))   # Code_RRR/integrals/<set>


def write_integrals(ints, out, sources, missing):
    """ints: set of (topo, (n1..n12)). Writes integrals.m (Mathematica), kira/ (one list per family), summary.txt"""
    os.makedirs(os.path.join(out, "kira"), exist_ok=True)
    for f in glob.glob(os.path.join(out, "kira", "*.txt")):
        os.remove(f)
    fams = {}
    for t, n in ints:
        fams.setdefault(t, []).append(n)
    order = sorted(fams, key=lambda t: int(t[4:]))
    with open(os.path.join(out, "integrals.m"), "w") as f:
        f.write("(* all integrals INT[topoN, n1, ..., n12] to reduce (families: Families/reduction/), run_all.py "
                "integrals *)\n{\n" + ",\n".join(f"INT[{t}, {', '.join(map(str, n))}]"
                                                 for t in order for n in sorted(fams[t])) + "\n}\n")
    with open(os.path.join(out, "integrals.txt"), "w") as f:
        for t in order:
            for n in sorted(fams[t]):
                f.write(f"{t}[{','.join(map(str, n))}]\n")
    lines = [f"{len(ints)} integrals in {len(fams)} families, from {len(sources)} result files"
             + (f"; {len(missing)} channels without step-06 results: {' '.join(missing)}" if missing else ""),
             f"{'family':>9s} {'integrals':>10s} {'sectors':>8s} {'max dots':>9s} {'max numerator':>14s}"]
    for t in order:
        ns = fams[t]
        with open(os.path.join(out, "kira", f"{t}.txt"), "w") as f:
            f.write("".join(f"{t}[{','.join(map(str, n))}]\n" for n in sorted(ns)))
        sectors = {tuple(int(x > 0) for x in n[5:]) for n in ns}
        dots = max(sum(x - 1 for x in n[5:] if x > 1) for n in ns)
        nums = max(sum(-x for x in n[5:] if x < 0) for n in ns)
        lines.append(f"{t:>9s} {len(ns):10d} {len(sectors):8d} {dots:9d} {nums:14d}")
    with open(os.path.join(out, "summary.txt"), "w") as f:
        f.write("\n".join(lines) + "\n")
    with open(os.path.join(out, "sources.txt"), "w") as f:
        f.write("\n".join(sorted(sources)) + "\n")
    print("\n".join(lines[:2] + lines[2:12] + (["   ..."] if len(lines) > 12 else [])))
    print(f"-> {out}/integrals.m, integrals.txt, kira/topoN.txt, summary.txt")


def read_integrals_m(path):
    ints = set()
    for m in re.finditer(r"INT\[(topo\d+), ([-\d, ]+)\]", open(path).read()):
        ints.add((m.group(1), tuple(int(x) for x in m.group(2).split(","))))
    return ints


def cmd_integrals(args):
    """all distinct integrals of the step-06 results (or with --step 05 the per-pair step-05 results, all families)"""
    base = os.path.expanduser(INTEGRALS_DIR)
    if args.merge is not None:
        dirs = args.merge or sorted(d for d in glob.glob(os.path.join(base, "*"))
                                    if os.path.basename(d) != "all" and os.path.isfile(os.path.join(d, "integrals.m")))
        if not dirs:
            sys.exit(f"nothing to merge in {base}")
        out = os.path.abspath(os.path.expanduser(args.out or os.path.join(base, "all")))
        print("merging " + ", ".join(dirs))
    else:
        out = os.path.abspath(os.path.expanduser(args.out or os.path.join(base, set_name(args))))
    ints, sources, missing = set(), [], []
    if args.merge is not None:
        for d in dirs:
            ints |= read_integrals_m(os.path.join(d, "integrals.m"))
            sources += [os.path.join(d, "integrals.m")]
        write_integrals(ints, out, sources, missing)
        return
    sub = "unreduced" if args.step == "06" else "squared_contracted"
    pat = "unreduced*.ff" if args.step == "06" else "unreduced*_*.ff"
    for g, n in select_channels(args):
        d = os.path.join(SCRIPTS, g, n, n + "_LO", "tmp", sub)
        files = sorted(glob.glob(os.path.join(d, "*", pat)))
        if not files:
            missing.append(n)
            continue
        for f in files:
            t = flat(f)
            found = INT_RE.findall(t)
            for topo, idx in found:
                key = tuple(int(x) for x in idx.split(","))
                if len(key) != NPROP or key[:NCUT] != (1,) * NCUT:
                    sys.exit(f"{f}: unexpected INT({topo},{idx})")
                ints.add((topo, key))
            sources.append(os.path.relpath(f, SCRIPTS))
    if args.step == "06":
        dep = deptopos()
        bad = {t for t, _ in ints} & dep
        if bad:
            sys.exit(f"dependent families in step-06 results: {sorted(bad)[:5]}")
    write_integrals(ints, out, sources, missing)


SELFTEST_CHANNEL = ("physical_qqbgg", "Vqqbgg")
SELFTEST_PAIR = "3_3"
SELFTEST_SEED = 20261014


def cmd_selftest(args):
    """steps 01, 02, 03, 04 (pair 3x3) and 05 of VqqbQ2Q2bg in a scratch copy, from the QGRAF output stored in
    tools/selftest_VqqbQ2Q2bg.0.inc (QGRAF not needed), then the numerical check of every non-zero piece:
    After == Before (this FORM is consistent) and Before == the stored value from FORM 5.0 (laptop)"""
    preflight()
    ref_file = os.path.join(SCRIPTS, "tools", "selftest_reference.json")
    src = Channel(*SELFTEST_CHANNEL)
    work = os.path.abspath(args.workdir or os.path.join(args.state, "selftest"))
    chdir = os.path.join(work, src.name + "_LO")
    shutil.rmtree(work, ignore_errors=True)
    os.makedirs(os.path.join(chdir, "tmp", "parsed_diagrams"))
    shutil.copy(os.path.join(src.dir, "process_header.h"), chdir)
    shutil.copytree(os.path.join(src.dir, "external"), os.path.join(chdir, "external"),
                    ignore=shutil.ignore_patterns("*.0.inc"))
    shutil.copy(os.path.join(SCRIPTS, "tools", f"selftest_{src.name}.0.inc"),
                os.path.join(chdir, "external", f"{src.name}.0.inc"))
    shutil.copytree(os.path.join(src.dir, "utils"), os.path.join(chdir, "utils"),
                    ignore=shutil.ignore_patterns("tmp_fld", "job_*", "03_complex_conj_diags.frm"))
    ch = Channel(*SELFTEST_CHANNEL)
    ch.dir = chdir

    def run(job, pairs06=None):
        cmd, cwd = job.prepare(args)
        t0 = time.time()
        with open(job.logfile(), "w") as log:
            rc = subprocess.run(cmd, cwd=cwd, stdout=log, stderr=subprocess.STDOUT,
                                input=job.stdin.encode() if job.stdin else None).returncode
        job.cleanup_tmp(args)
        ok, why, info = (job.verify(set()) if rc == 0 else (False, f"FORM rc={rc}: {form_reason(job.logfile())}", {}))
        print(f"  {job.label():32s} {time.time()-t0:6.1f} s  {'ok' if ok else 'FAILED: ' + why}", flush=True)
        return ok, info

    vers = (subprocess.run(FORM + ["-v"], capture_output=True, text=True).stdout.strip().splitlines() or ["?"])[0]
    print(f"selftest with {' '.join(FORM)} ({vers}) in {work}", flush=True)
    for s in ("01", "02", "03"):
        if not run(Job(s, ch, None, None, 0))[0]:
            sys.exit(1)
    ok, info = run(Job("04", ch, None, SELFTEST_PAIR, 0))
    if not ok:
        sys.exit(1)
    pieces = info["nonzero"]
    from concurrent.futures import ThreadPoolExecutor
    with ThreadPoolExecutor(max_workers=args.jobs) as ex:
        res05 = list(ex.map(lambda p: (p, run(Job("05", ch, p, SELFTEST_PAIR, 0))[0]), pieces))
    ref = json.load(open(ref_file)) if os.path.exists(ref_file) else {}
    out, nbad = {}, sum(1 for _, ok in res05 if not ok)
    with ThreadPoolExecutor(max_workers=args.jobs) as ex:
        res = list(ex.map(lambda p: (p, run_check05(chdir, p, SELFTEST_PAIR, SELFTEST_SEED,
                                                    os.path.join(work, "check", p))), [p for p, ok in res05 if ok]))
    for p, (verdict, before) in res:
        out[p] = before
        same = ("no reference" if p not in ref else ("= reference (FORM 5.0)" if ref[p] == before
                                                     else "!= REFERENCE"))
        nbad += verdict != "IDENTICAL" or same == "!= REFERENCE"
        print(f"  check {p:5s}: step 05 {verdict:9s}  step-04 value {same}", flush=True)
    if args.write_reference:
        with open(ref_file, "w") as f:
            json.dump(out, f, indent=1, sort_keys=True)
        print(f"reference written: {ref_file}")
    print("SELFTEST " + ("PASSED" if nbad == 0 else f"FAILED ({nbad} problems)"))
    sys.exit(1 if nbad else 0)


# ---------------------------------------------------------------- main
def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)

    def common(p, jobs=None):
        p.add_argument("--set", choices=["gluons", "quarks", "all"], default="all")
        p.add_argument("--channels", help="comma-separated channel names instead of --set")
        p.add_argument("--state", help="state directory (default Scripts/run_state/<set>)")
        if jobs is not None:
            p.add_argument("--jobs", type=int, default=jobs, help="parallel FORM jobs")
    p = sub.add_parser("run", help="run / resume")
    common(p, jobs=4)
    p.add_argument("--steps", default=",".join(ALLSTEPS),
                   help="comma-separated, from qgraf,01,02,03,04,05,06 (default all)")
    p.add_argument("--min-free-gb", type=float, default=100.0,
                   help="start no new job while the machine has less available memory (Linux)")
    p.add_argument("--max-job-gb", type=float, default=60.0, help="kill a FORM job above this memory (0 = never)")
    p.add_argument("--nice", type=int, default=10, help="nice level of the FORM jobs")
    p.add_argument("--form-tmp", help="directory for FORM's temporary sort files (FORM -t)")
    p.add_argument("--sample", type=float, default=30.0, help="seconds between memory samples / status updates")
    p = sub.add_parser("status", help="progress, memory, failed jobs")
    common(p)
    p.add_argument("--running", action="store_true", help="also list the running jobs")
    p.add_argument("--max-failed", type=int, default=30)
    p = sub.add_parser("check", help="scan outputs for missing / leftovers / old versions")
    common(p)
    p.add_argument("--max-failed", type=int, default=30)
    p = sub.add_parser("verify", help="numerical check of random finished step-05 results")
    common(p)
    p.add_argument("--n", type=int, default=2, help="results per channel")
    p.add_argument("--seed", type=int, default=1)
    p = sub.add_parser("integrals", help="collect all distinct integrals to reduce")
    common(p)
    p.add_argument("--out", help="output folder (default Code_RRR/integrals/<set>, or Code_RRR/integrals/all with "
                                 "--merge; base folder changeable with DY_INTEGRALS)")
    p.add_argument("--step", choices=["06", "05"], default="06",
                   help="06: summed results, independent families (default); 05: per pair, all families")
    p.add_argument("--merge", nargs="*", metavar="DIR",
                   help="instead: union of the collections in these folders (no folder: all in Code_RRR/integrals "
                        "except all)")
    p = sub.add_parser("selftest", help="FORM check: VqqbQ2Q2bg 3x3 against reference numbers")
    common(p, jobs=4)
    p.add_argument("--workdir")
    p.add_argument("--form-tmp")
    p.add_argument("--write-reference", action="store_true", help=argparse.SUPPRESS)
    args = ap.parse_args()
    if not args.state:
        args.state = os.path.join(SCRIPTS, "run_state", set_name(args))
    args.state = os.path.abspath(args.state)
    {"run": cmd_run, "status": cmd_status, "check": cmd_check, "verify": cmd_verify,
     "selftest": cmd_selftest, "integrals": cmd_integrals}[args.cmd](args)


if __name__ == "__main__":
    main()
