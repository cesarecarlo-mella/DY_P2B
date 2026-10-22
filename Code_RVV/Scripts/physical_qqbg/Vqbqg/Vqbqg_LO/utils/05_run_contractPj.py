import glob
import os
import shlex
import shutil
import subprocess
import sys
import concurrent.futures

# Step 05: contract every piece of every group pair of step 04 (tmp/squared_diagrams/<piece>/<piece>_i_j.inc) with
# its leptonic projector, then partial fractions, families and integrals (utils/template_contractPj.frm).
# Run from <P>_LO/:  python3 utils/05_run_contractPj.py
# Output: tmp/squared_contracted/<piece>/unreduced<PROJ>_i_j.ff. Jobs run in utils/job_<piece>_<PROJ>_<i_j>/;
# the folder (with form.log) is kept if the job fails, and the script then exits with an error.
# FORM: the command in $FORM (default "form"), e.g. FORM="tform -w4" on a cluster node.

FORM = shlex.split(os.environ.get("FORM", "form"))

# Code_v2/Families: partial-fraction identities and family rules (Families/README in Scripts/README.md)
FAMDIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../../../Families"))

# Projector per piece: L1 (symmetric) for the parity-even pieces (no or two gamma5), L6 (epsilon) for the odd
# ones (one gamma5). The other combinations vanish by parity and are not computed.
EVEN = ["vv", "aa", "vv2", "aa2", "v2v", "a2a", "v2v2", "a2a2", "vvX", "aaX"]
ODD = ["va", "av", "va2", "av2", "v2a", "a2v", "v2a2", "a2v2", "vaX", "avX"]
# pure singlet (V on the closed quark loop of the one-loop amplitude)
EVEN += ["vPSv", "vPSv2", "aPSa", "aPSa2"]
ODD += ["vPSa", "vPSa2", "aPSv", "aPSv2"]
PROJ = {**{c: 1 for c in EVEN}, **{c: 6 for c in ODD}}


def is_zero(path):
    with open(path) as f:
        return f.read().split("=", 1)[1].strip().rstrip(";").strip() == "0"


def run_form(coupl, which, debug):
    proj = PROJ[coupl]
    folder = f"./utils/job_{coupl}_{proj}_{which}"
    if os.path.exists(folder):
        shutil.rmtree(folder)
    os.makedirs(folder)
    shutil.copy("./utils/template_contractPj.frm", os.path.join(folder, "contractPj.frm"))
    command = FORM + ["-d", f"COUPL={coupl}", "-d", f"WHICH={which}", "-d", f"PROJ={proj}",
                      "-d", f"FAMDIR={FAMDIR}", "-d", f"NPF={NPF}",
                      "-d", f"DEBUG={debug}", "contractPj.frm"]
    with open(os.path.join(folder, "form.log"), "w") as log:
        rc = subprocess.run(command, cwd=folder, stdout=log, stderr=subprocess.STDOUT).returncode
    out = f"./tmp/squared_contracted/{coupl}/unreduced{proj}_{which}.ff"
    ok = rc == 0 and os.path.isfile(out) and os.path.getsize(out) > 0
    if ok:
        shutil.rmtree(folder)
    print(f"[{coupl} L{proj} {which}] {'done' if ok else 'FAILED, log in ' + folder + '/form.log'}", flush=True)
    return (coupl, which), ok


def main():
    global NPF, NFAM
    if shutil.which(FORM[0]) is None:
        sys.exit(f"FORM executable '{FORM[0]}' not found (set FORM=...)")
    if not os.environ.get("FORMPATH"):
        print("warning: FORMPATH not set (source Code_v2/setenv.sh)")
    NPF = len(glob.glob(os.path.join(FAMDIR, "partial_fraction", "partialfraction_*.inc")))
    NFAM = len(glob.glob(os.path.join(FAMDIR, "fams", "fams[0-9]*.inc")))
    if NPF == 0 or NFAM == 0 or not all(
            os.path.isfile(os.path.join(FAMDIR, "fams", t)) for t in ("isp_table.inc", "fammatch_table.inc")):
        sys.exit(f"partial fractions, families or the tables fams/isp_table.inc, fams/fammatch_table.inc missing "
                 f"in {FAMDIR}: run the Families scripts (family_rules.wl, isp_table.py, fammatch_table.py)")
    print(f"Families: {FAMDIR}  ({NPF} partial-fraction sets, {NFAM} families)")

    # all non-zero pieces of step 04
    jobs, zero = [], 0
    for coupl in EVEN + ODD:
        for f in sorted(glob.glob(f"./tmp/squared_diagrams/{coupl}/{coupl}_*.inc")):
            if is_zero(f):
                zero += 1
                continue
            jobs.append((coupl, os.path.basename(f)[len(coupl) + 1:-len(".inc")]))
    if not jobs:
        sys.exit("no step-04 output in tmp/squared_diagrams: run step 04 first")
    print(f"{len(jobs)} jobs (pieces x group pairs), {zero} zero pieces skipped")

    mode = input("a = run all, o = run one (by index), l = list: ").strip().lower()
    if mode == "l":
        for k, j in enumerate(jobs, start=1):
            print(f"{k}: {j[0]} {j[1]}")
        mode = input("a = run all, o = run one (by index): ").strip().lower()
    if mode == "o":
        jobs = [jobs[int(input("index: ").strip()) - 1]]
    elif mode != "a":
        raise ValueError("Invalid selection")
    mw = int(input("Enter the max number of parallel jobs: "))
    debug = int(input("write intermediate expressions (0/1)? ") or 0)

    for coupl in {c for c, _ in jobs}:
        os.makedirs(f"./tmp/squared_contracted/{coupl}", exist_ok=True)

    # FORM runs as a separate process for each job, so threads are enough to run them in parallel
    with concurrent.futures.ThreadPoolExecutor(max_workers=mw) as executor:
        results = list(executor.map(lambda j: run_form(j[0], j[1], debug), jobs))

    failed = [j for j, ok in results if not ok]
    if failed:
        print(f"\n{len(failed)} of {len(results)} FORM jobs failed: {failed}")
        sys.exit(1)
    print(f"\nDone: {len(results)} jobs, output in tmp/squared_contracted/<piece>/unreduced<PROJ>_<i_j>.ff")


if __name__ == "__main__":
    main()
