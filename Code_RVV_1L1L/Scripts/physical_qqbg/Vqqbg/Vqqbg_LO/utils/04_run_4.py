import glob
import os
import shlex
import shutil
import subprocess
import sys
import concurrent.futures

# Step 04: square the amplitude, one FORM job (utils/4_square_ampl.frm) per pair (group i, conjugate group j).
# Run from <P>_LO/:  python3 utils/04_run_4.py
# Each job runs in utils/tmp_fld/tmp_i_j/ (same depth as before: the .frm includes ../../../process_header.h);
# its FORM log is kept there if the job fails, and the script then exits with an error.
# Works on macOS and Linux. FORM command from the environment variable FORM (default "form"),
# e.g. on a cluster:  export FORM="tform -w4"   (FORMPATH: source Code_v2/setenv.sh)
# SKIPAA (environment, default 1): skip the aa and a2a2 pieces (= vv, v2v2; written as 0); SKIPAA=0 computes them.

# amplitude coupling + conjugate coupling: v, a (q line), v2, a2 (Q2 line); see 4_square_ampl.frm
COUPLINGS = [x + y for x in ("v", "a", "v2", "a2") for y in ("v", "a", "v2", "a2")]
# identical quarks: flavour-1 couplings with the V vertices on different traces (class X)
COUPLINGS += ["vvX", "vaX", "avX", "aaX"]
# V on the closed quark loop of the one-loop amplitude (pure singlet)
COUPLINGS += ["vPSv", "vPSa", "vPSv2", "vPSa2", "aPSv", "aPSa", "aPSv2", "aPSa2"]
TMPDIR = "./utils/tmp_fld"
FORM = shlex.split(os.environ.get("FORM", "form"))
SKIPAA = os.environ.get("SKIPAA", "1")


def run_form(i, j, lc, onlyvector):
    folder = os.path.join(TMPDIR, f"tmp_{i}_{j}")
    os.mkdir(folder)
    shutil.copy("./utils/4_square_ampl.frm", folder)
    command = FORM + ["-d", f"LC={lc}", "-d", f"ONLYVECTOR={onlyvector}", "-d", f"SKIPAA={SKIPAA}",
               "-d", f"loopind={i}", "-d", f"loopind2={j}", "4_square_ampl.frm"]
    with open(os.path.join(folder, "form.log"), "w") as log:
        rc = subprocess.run(command, cwd=folder, stdout=log, stderr=subprocess.STDOUT).returncode
    outputs = [f"./tmp/squared_diagrams/{c}/{c}_{i}_{j}.inc" for c in COUPLINGS]
    ok = rc == 0 and all(os.path.isfile(f) and os.path.getsize(f) > 0 for f in outputs)
    if ok:
        shutil.rmtree(folder)
    return (i, j), ok


def main():
    if shutil.which(FORM[0]) is None:
        sys.exit(f"FORM executable '{FORM[0]}' not found: set the environment variable FORM or add it to PATH")
    if not os.environ.get("FORMPATH"):
        print("warning: FORMPATH is not set (source Code_v2/setenv.sh), FORM may not find all_header.h")
    if os.path.exists("./tmp/squared_diagrams"):
        shutil.rmtree("./tmp/squared_diagrams")
    for c in COUPLINGS:
        os.makedirs(f"./tmp/squared_diagrams/{c}")

    onlyvector = int(input("type 0 for full calculation, type > 0 for only vector "))
    lc = int(input("type 0 for full color calculation, type > 0 for lc "))
    mw = int(input("Enter the max number of parallel jobs: "))

    # Directory containing the parsed diagrams (groups of step 02, conjugates of step 03)
    parsed_dir = "./tmp/parsed_diagrams/groups/"
    ndiag1 = len(glob.glob(os.path.join(parsed_dir, "sum_*")))
    ndiag2 = len(glob.glob(os.path.join(parsed_dir, "Csum_*")))
    print("aa and a2a2 pieces:", "skipped (= vv, v2v2; SKIPAA=0 to compute them)" if SKIPAA != "0" else "computed")
    print("Number of diagrams for amp1:", ndiag1)
    print("Number of diagrams for amp2:", ndiag2)
    if ndiag1 == 0 or ndiag2 == 0:
        sys.exit("no groups found: run steps 02 and 03 first")

    all_runs = [(i, j) for i in range(1, ndiag1 + 1) for j in range(1, ndiag2 + 1)]
    print("\nAvailable runs:")
    for k, (i, j) in enumerate(all_runs, start=1):
        print(f"{k}: (i={i}, j={j})")
    print("\nChoose run mode:")
    print("  a = run all")
    print("  o = run one specific (by index)")
    mode = input("Selection: ").strip().lower()
    if mode == "a":
        selected_runs = all_runs
    elif mode == "o":
        idx = int(input("Enter the index of the run to execute: ").strip())
        selected_runs = [all_runs[idx - 1]]
    else:
        raise ValueError("Invalid selection")
    print("\nRuns selected:")
    print(selected_runs)

    if os.path.exists(TMPDIR):
        shutil.rmtree(TMPDIR)
    os.mkdir(TMPDIR)

    # FORM runs as a separate process for each job, so threads are enough to run them in parallel
    with concurrent.futures.ThreadPoolExecutor(max_workers=mw) as executor:
        results = list(executor.map(lambda ij: run_form(ij[0], ij[1], lc, onlyvector), selected_runs))

    failed = [ij for ij, ok in results if not ok]
    if failed:
        print(f"\n{len(failed)} of {len(results)} FORM jobs failed: {failed}")
        print(f"FORM logs kept in {TMPDIR}/tmp_<i>_<j>/form.log")
        sys.exit(1)
    shutil.rmtree(TMPDIR)
    print(f"\nDone: {len(results)} jobs, output in tmp/squared_diagrams/{{{','.join(COUPLINGS)}}}/")


if __name__ == "__main__":
    main()
