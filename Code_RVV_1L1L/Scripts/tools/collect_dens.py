#!/usr/bin/env python3
"""Distinct propagator sets of the step-04 output of one channel (Code_RRV): one FORM job per nonzero piece file.

    python3 collect_dens.py <P>_LO [jobs]

Writes <P>_LO/tmp/den/sets.txt: one line per distinct set, the k1-free propagators | the k1 propagators,
powers dropped. FORM: collect_dens.frm next to this script (FORMPATH as for the pipeline)."""
import concurrent.futures, glob, os, re, subprocess, sys

LO = os.path.abspath(sys.argv[1])
JOBS = int(sys.argv[2]) if len(sys.argv) > 2 else 1
FRM = os.path.join(os.path.dirname(os.path.abspath(__file__)), "collect_dens.frm")
FORM = os.environ.get("FORM", "form").split()
FACT = re.compile(r"(Prop|Den)\(([^()]*)\)(?:\^\d+)?")


def files():
    for f in sorted(glob.glob(os.path.join(LO, "tmp", "squared_diagrams", "*", "*.inc"))):
        with open(f) as fh:
            head = fh.read(200)
        if not re.match(r"l \[interf\d+_\d+\]= 0;", head.strip()):
            coupl = os.path.basename(os.path.dirname(f))
            yield coupl, os.path.basename(f)[len(coupl) + 1:-4]


def brackets(body):
    """print[] output split into its brackets: '+'/'-' at parenthesis depth 0 (not an exponent sign); a bracket with
    one term is printed in full, the others as 'outside * ( n terms )'"""
    out, depth, start = [], 0, 0
    for i, c in enumerate(body):
        if c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
        elif c in "+-" and depth == 0 and i > start and body[i - 1] != "^":
            out.append(body[start:i])
            start = i
    out.append(body[start:])
    return out


def run(job):
    coupl, which = job
    r = subprocess.run(FORM + ["-d", f"COUPL={coupl}", "-d", f"WHICH={which}", FRM], cwd=LO,
                       capture_output=True, text=True)
    if r.returncode:
        return job, None, r.stdout[-2000:] + r.stderr
    body = r.stdout.split(f"[interf{which}] =", 1)[1].split(";", 1)[0]
    sets = set()
    for br in brackets(re.sub(r"\s+", "", body)):
        fs = sorted({f"{m.group(1)}({m.group(2)})" for m in FACT.finditer(br)})
        if fs:
            sets.add(tuple(fs))
    return job, sets, None


if __name__ == "__main__":
    jobs = list(files())
    allsets, bad = {}, []
    with concurrent.futures.ThreadPoolExecutor(max_workers=JOBS) as ex:
        for job, sets, err in ex.map(run, jobs):
            if sets is None:
                bad.append(job)
                print(f"FAILED {job}:\n{err}", file=sys.stderr)
                continue
            for s in sets:
                allsets.setdefault(s, set()).add(job[0])
            print(f"{job[0]:6s} {job[1]:6s} {len(sets):5d} sets", flush=True)
    os.makedirs(os.path.join(LO, "tmp", "den"), exist_ok=True)
    out = os.path.join(LO, "tmp", "den", "sets.txt")
    with open(out, "w") as f:
        for s in sorted(allsets, key=lambda s: (len(s), s)):
            rr = [x for x in s if "k1" not in x]
            lp = [x for x in s if "k1" in x]
            f.write(" ".join(rr) + " | " + " ".join(lp) + "   # " + ",".join(sorted(allsets[s])) + "\n")
    print(f"{len(jobs)} files, {len(bad)} failed, {len(allsets)} distinct sets -> {out}")
    sys.exit(1 if bad else 0)
