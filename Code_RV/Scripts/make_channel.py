#!/usr/bin/env python3
"""Create channel folders <group>/<P>/<P>_LO from channels.csv.

  python3 make_channel.py VgqqQ2Q2b Vqbqggg   # selected channels
  python3 make_channel.py --missing            # every channel in channels.csv without a folder
  options: --qgraf   also run QGRAF and set NDIAG in process_header.h
           --dest D  write into D instead of this folder (for tests)

Shared files (utils/, external/LeptonicCurrents, external/decayAmpSquared, cleanfld.py)
are copied from the reference channel REF; tmp/ gets REF's empty directory tree.
Existing channel folders are never overwritten.
"""
import csv, os, re, shutil, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
REF = os.path.join(HERE, "physical_qqbg/Vqqbg/Vqqbg_LO")
QGRAF = os.environ.get("QGRAF", "qgraf")

# files in REF/utils produced by running the pipeline, not part of a fresh channel
GENERATED = {"03_complex_conj_diags.frm", "sum_squared_diags.frm", "contractPj.frm"}

# same text as the original qgraf.dat files (including their trailing spaces)
QGRAF_DAT = ("output = '../external/{P}.0.inc' ;\n\n"
             "style = '../../../../../QGRAF/form.sty' ;\n \n"
             "model = '../../../../../QGRAF/model_file';\n\n"
             "in = {IN};\nout = ;\n\nloops = 0 ;\n\nloop_momentum = k ;\n\n"
             "options = nosnail, onshell, notadpole; \n")


def read_channels():
    with open(os.path.join(HERE, "channels.csv"), newline="") as f:
        return {r["name"]: r for r in csv.DictReader(f)}


def ignore_generated(src, names):
    skip = {n for n in names if n in GENERATED or n == "__pycache__" or n.startswith(".")}
    if os.path.basename(src) == "utils":
        skip |= {n for n in names if n.startswith("tmp")}
    return skip


def make(row, dest, run_qgraf):
    P = row["name"]
    lo = os.path.join(dest, row["group"], P, f"{P}_LO")
    if os.path.exists(lo):
        print(f"[skip] {lo} exists")
        return
    shutil.copytree(os.path.join(REF, "utils"), os.path.join(lo, "utils"), ignore=ignore_generated)
    for sub in ("LeptonicCurrents", "decayAmpSquared"):
        shutil.copytree(os.path.join(REF, "external", sub), os.path.join(lo, "external", sub),
                        ignore=ignore_generated)
    shutil.copy(os.path.join(REF, "cleanfld.py"), lo)
    for root, dirs, _ in os.walk(os.path.join(REF, "tmp")):
        for d in dirs:
            rel = os.path.relpath(os.path.join(root, d), REF)
            os.makedirs(os.path.join(lo, rel), exist_ok=True)
    os.makedirs(os.path.join(lo, "tmp"), exist_ok=True)
    for root, _, _ in os.walk(os.path.join(lo, "tmp")):  # keeps the empty tree in git (see Code_v2/.gitignore)
        open(os.path.join(root, ".gitkeep"), "w").close()
    os.makedirs(os.path.join(lo, "qgraf"))
    with open(os.path.join(lo, "qgraf", "qgraf.dat"), "w") as f:
        f.write(QGRAF_DAT.format(P=P, IN=row["in"]))
    ndiag = "TBD"
    if run_qgraf:
        qdir = os.path.join(lo, "qgraf")
        with open(os.path.join(qdir, "qgraf.log"), "w") as log:
            subprocess.run([QGRAF], cwd=qdir, stdout=log, stderr=subprocess.STDOUT, check=True)
        inc = os.path.join(lo, "external", f"{P}.0.inc")
        if not os.path.exists(inc):  # qgraf exits with 0 also on errors
            sys.exit(f"QGRAF failed for {P}, see {qdir}/qgraf.log:\n" + open(os.path.join(qdir, "qgraf.log")).read())
        with open(inc) as f:
            ndiag = str(len(re.findall(r"^id diag\d+ =", f.read(), re.M)))
    with open(os.path.join(lo, "process_header.h"), "w") as f:
        f.write(f'#define NDIAG "{ndiag}"\n#define NLOOP "0"\n#define PROC "{P}"\n')
    print(f"[made] {lo}  NDIAG={ndiag}")


def main(argv):
    run_qgraf = "--qgraf" in argv
    dest = HERE
    if "--dest" in argv:
        dest = os.path.abspath(argv[argv.index("--dest") + 1])
    channels = read_channels()
    names = [a for a in argv if not a.startswith("--") and a != dest and os.path.abspath(a) != dest]
    if "--missing" in argv:
        names = [n for n, r in channels.items()
                 if not os.path.exists(os.path.join(dest, r["group"], n))]
    unknown = [n for n in names if n not in channels]
    if unknown:
        sys.exit(f"not in channels.csv: {unknown}")
    for n in names:
        make(channels[n], dest, run_qgraf)


if __name__ == "__main__":
    main(sys.argv[1:])
