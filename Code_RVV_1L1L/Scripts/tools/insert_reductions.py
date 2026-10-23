#!/usr/bin/env python3
"""Insert the reductions of the RVV 1L x 1L families into the step-06 results -> one-loop masters.

    python3 tools/insert_reductions.py [--channels Vqqbg,...] [--pieces vv,aPSa,...] [--tables DIR] [--jobs 2]

Input: <P>_LO/tmp/unreduced/<piece>/unreduced<PROJ>.ff (step 06: INT(topoN, 1,1,1, n1..n9) x coefficients) and the
FORM tables of RVV_reductions/to_form.py (default ../../RVV_reductions/tables/red_topoN.inc).
Output: <P>_LO/tmp/reduced/<piece>/reduced<PROJ>.ff, l [reduced_<PROJ>] = sum over products of one-loop masters
ML1(k1 master) * ML1C(k2 master) (ML1C = complex conjugate) x coefficients RAT(num, den) in z, u, d (PolyRatFun),
bracketed in the masters. Stops (FORM exit) if an integral has no table entry.
Run from Code_RVV_1L1L/Scripts after `source ../setenv.sh`.
"""
import argparse
import concurrent.futures
import glob
import os
import re
import subprocess
import sys

SCRIPTS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FORM = os.environ.get("FORM", "form").split()


def script(ff, proj, tables, out):
    fams = sorted(int(re.search(r"red_topo(\d+)\.inc$", t).group(1)) for t in tables)
    L = ["off statistics;", "#-", "#include all_header.h",
         "* one-loop masters (RVV_reductions/to_form.py); ML1 = amplitude (k1), ML1C = conjugate (k2, complex conjugate)",
         "s B12, B13, B23, B123, BOX1, BOX2, BOX3;", "cf ML1, ML1C, RAT;"]
    L += [f"#include {t}" for t in sorted(tables)]
    L += [f"#include {ff}", ".sort", f"l RED = [unreduced_{proj}];", ".sort", f"Drop [unreduced_{proj}];"]
    L += [f"id INT(topo{n},1,1,1,n1?,n2?,n3?,n4?,n5?,n6?,n7?,n8?,n9?) = RED{n}(n1,n2,n3,n4,n5,n6,n7,n8,n9);"
          for n in fams]
    L += [".sort", "if ( count(INT,1) != 0 ) exit \"insert_reductions: integral of a family without a table\";",
          "if ( count(" + ",".join(f"RED{n},1" for n in fams) + ") != 0 ) "
          "exit \"insert_reductions: integral not in its table\";",
          "* coefficients -> one rational function RAT(numerator, denominator) per master product",
          "id Num(x?) = RAT(x,1);", "id Den(x?) = RAT(1,x);"]
    for v in ("z", "u", "d"):
        L += [f"id {v}^n?pos_ = RAT({v}^n,1);", f"id {v}^n?neg_ = RAT(1,{v}^-n);"]
    L += [".sort", "PolyRatFun RAT;", ".sort",
          "if ( count(ML1,1) != 1 || count(ML1C,1) != 1 ) exit \"insert_reductions: term without one ML1 and one ML1C\";",
          "b ML1, ML1C, gs, Nc, [Nc^2-1], Nf, NfV;", ".sort",
          f"#write <{out}> \"l [reduced_{proj}] = %e\" RED", ".end"]
    return "\n".join(L) + "\n"


def run(job):
    ff, proj, tables, out, work = job
    os.makedirs(work, exist_ok=True)
    open(os.path.join(work, "insert.frm"), "w").write(script(ff, proj, tables, out))
    if os.path.exists(out):
        os.remove(out)
    r = subprocess.run(FORM + ["insert.frm"], cwd=work, capture_output=True, text=True)
    open(os.path.join(work, "insert.log"), "w").write(r.stdout + r.stderr)
    ok = r.returncode == 0 and os.path.isfile(out)
    msg = "" if ok else " | ".join(l for l in r.stdout.splitlines() if "insert_reductions" in l or "-->" in l)[:300]
    return ok, msg


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--channels", help="comma-separated channel names (default: all with step-06 results)")
    ap.add_argument("--pieces", help="comma-separated pieces (default: all with step-06 results)")
    ap.add_argument("--tables", default=os.path.join(SCRIPTS, "..", "..", "RVV_reductions", "tables"))
    ap.add_argument("--chdirs", help="channel folders <P>_LO instead of Scripts/<group>/<P>/<P>_LO (tests)")
    ap.add_argument("--jobs", type=int, default=2)
    args = ap.parse_args()
    tables = [os.path.abspath(t) for t in glob.glob(os.path.join(args.tables, "red_topo*.inc"))]
    if not tables:
        sys.exit(f"no tables in {args.tables} (RVV_reductions/to_form.py)")
    dirs = args.chdirs.split(",") if args.chdirs else sorted(glob.glob(os.path.join(SCRIPTS, "*", "*", "*_LO")))
    if args.channels:
        dirs = [d for d in dirs if os.path.basename(d)[:-3] in args.channels.split(",")]
    jobs = []
    for d in dirs:
        for ff in sorted(glob.glob(os.path.join(d, "tmp", "unreduced", "*", "unreduced*.ff"))):
            piece = os.path.basename(os.path.dirname(ff))
            if args.pieces and piece not in args.pieces.split(","):
                continue
            if re.search(r"=\s*0;\s*$", open(ff).read()[-200:]):
                continue                                     # zero piece
            proj = re.search(r"unreduced(\d+)\.ff$", ff).group(1)
            outdir = os.path.join(d, "tmp", "reduced", piece)
            os.makedirs(outdir, exist_ok=True)
            jobs.append((os.path.abspath(ff), proj, tables, os.path.join(os.path.abspath(outdir), f"reduced{proj}.ff"),
                         os.path.join(os.path.abspath(outdir), "work")))
    print(f"{len(jobs)} pieces, {len(tables)} tables")
    bad = 0
    with concurrent.futures.ThreadPoolExecutor(args.jobs) as ex:
        for job, (ok, msg) in zip(jobs, ex.map(run, jobs)):
            name = "/".join(job[0].split("/")[-6:-4] + job[0].split("/")[-2:-1])
            print(f"{'ok    ' if ok else 'FAILED'} {name} {msg}", flush=True)
            bad += not ok
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
