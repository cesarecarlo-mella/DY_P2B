import glob
import os
import re
import shlex
import shutil
import subprocess
import sys

# Step 06: sum the step-05 results of all group pairs, per piece (vv, va, ..., a2a2) and projector, and map the
# families to the independent ones (Families/fams/symm_loop_crossings.inc).
# Run from <P>_LO/:  python3 utils/06_run_sum_contracted.py
# In:  tmp/squared_contracted/<piece>/unreduced<PROJ>_<i_j>.ff
# Out: tmp/unreduced/<piece>/unreduced<PROJ>.ff (FORM) and .m (Mathematica)
# One FORM run per piece, one after the other; utils/sum_squared_diags_<piece>_<PROJ>.frm and its .log are kept
# if the run fails, and the script then exits with an error.

FORM = shlex.split(os.environ.get("FORM", "form"))
FAMDIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../../../Families"))


def main():
    if shutil.which(FORM[0]) is None:
        sys.exit(f"FORM executable '{FORM[0]}' not found (set FORM=...)")
    if not os.environ.get("FORMPATH"):
        print("warning: FORMPATH not set (source Code_v2/setenv.sh)")
    if not os.path.isfile(os.path.join(FAMDIR, "fams", "symm_loop_crossings.inc")):
        sys.exit(f"{FAMDIR}/fams/symm_loop_crossings.inc missing: run the Families scripts first")
    with open("./utils/template_sum_squared_diags.frm") as f:
        template = f.read()
    # dependent families: left-hand sides of the relabelling rules
    with open(os.path.join(FAMDIR, "fams", "symm_loop_crossings.inc")) as f:
        dep = sorted(set(re.findall(r"^id INT\((topo\d+),", f.read(), re.M)), key=lambda t: int(t[4:]))

    # (piece, projector) -> group pairs, from the step-05 output
    runs = {}
    for f in glob.glob("./tmp/squared_contracted/*/unreduced*_*.ff"):
        m = re.match(r"unreduced(\d+)_(\d+_\d+)\.ff$", os.path.basename(f))
        if m:
            runs.setdefault((os.path.basename(os.path.dirname(f)), m.group(1)), []).append(m.group(2))
    if not runs:
        sys.exit("no step-05 output in tmp/squared_contracted: run step 05 first")
    pairs = sorted({p for ps in runs.values() for p in ps})
    for (coupl, proj), ps in sorted(runs.items()):
        missing = sorted(set(pairs) - set(ps))
        print(f"{coupl} L{proj}: {len(ps)} group pairs" + (f", MISSING {missing}" if missing else ""))
    if input("sum all of them (y/n)? ").strip().lower() != "y":
        sys.exit(0)

    failed = []
    for (coupl, proj), ps in sorted(runs.items()):
        os.makedirs(f"./tmp/unreduced/{coupl}", exist_ok=True)
        name = f"sum_squared_diags_{coupl}_{proj}"
        frm = f"./utils/{name}.frm"
        with open(frm, "w") as f:
            f.write(template.replace("&toreplace", ",".join(sorted(ps))).replace("&coupl", coupl)
                    .replace("&proj", proj).replace("&famdir", FAMDIR).replace("&depset", ",".join(dep)))
        with open(f"./utils/{name}.log", "w") as log:
            rc = subprocess.run(FORM + [frm], stdout=log, stderr=subprocess.STDOUT).returncode
        ok = rc == 0 and os.path.isfile(f"./tmp/unreduced/{coupl}/unreduced{proj}.ff")
        print(f"[{coupl} L{proj}] {'done' if ok else 'FAILED, see utils/' + name + '.log'}", flush=True)
        if ok:
            os.remove(frm)
            os.remove(f"./utils/{name}.log")
        else:
            failed.append((coupl, proj))
    if failed:
        sys.exit(f"{len(failed)} sums failed: {failed}")
    print("Done: tmp/unreduced/<piece>/unreduced<PROJ>.ff and .m")


if __name__ == "__main__":
    main()
