#!/usr/bin/env python3
"""Reduze reduction jobs for the RVV 1L x 1L integrals (Code_RVV_1L1L), one Reduze project per family.

    python3 make_jobs.py jobs [--collection all] [--fams 1,2] [--r-extra 1]   # -> jobs/topoN/
    python3 make_jobs.py test --fams 2 [--max-s 1] [--max-ints 20]           # cheap check -> jobs/topoN_test/

Inputs (nothing is changed there):
  ../Code_RVV_1L1L/Families/integralfamilies_r.rvv.m   the 9 families: DD numbers in INT order, DD[n] -> Den[momentum]
  ../Code_RVV_1L1L/integrals/<collection>/kira/topoN.txt             integrals to reduce (topoN[1,1,1,n4,...,n12])
  ../Code_RVV_1L1L/integrals/<collection>/analysis/topsectors.csv    top sectors with r, s over their trees
  (the last two from Code_RVV_1L1L/Scripts/run_all.py integrals and Code_RVV_1L1L/integrals/Tools/analyse_integrals.py)

Families (Reduze names topo1..topo9, as in Code_RVV_1L1L): loop-only, 9 propagators = INT positions 4..12: the k1 box
(4), the k2 box (4), (k1+k2)^2 (numerator only); the 3 cut propagators (always index 1) are constants at fixed
kinematics and are left out. Loop momenta k1 (amplitude) and k2 (conjugate, -i0).
NO sector relations, NO sector symmetries, no crossings: a relation exchanging k1 and k2 would move the complex
conjugation onto the other factor (notes_Larin/oneloop_squared.tex; tested in DY_P2B_work/2026-10-22/fact1x1 and
rvv_reduze: Reduze with these settings = Gram projection as ordered products M_a(k1) M_b(k2)).
Kinematics (as in Code_RVV_1L1L / FORM): p1, p2, r1 incoming, q = -p1-p2-r1, q^2 = m2, s = (p1+p2)^2, t = (p1+r1)^2,
(p2+r1)^2 = m2-s-t; m2 -> 1 in the reduction (Reduze restores it on export). In terms of z, u (Code_RVV_1L1L isp_table):
s = m2/z, t = m2 (u z - 1)/(z (1 + u)), m2 - s - t = m2 (z - u)/(z (1 + u)).
Seeds: r in [t, t + r_extra] (default 1), s in [0, s of the top-sector tree].
"""
import argparse
import csv
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CODE = os.path.join(HERE, "..", "Code_RVV_1L1L")
FAMDIR = os.path.join(CODE, "Families")
NCUT = 3

GLOBAL = """global_symbols:
  space_time_dimension: d
paths: {}
"""
KINEMATICS = """kinematics:
  # as in Code_RVV_1L1L: p1, p2, r1 incoming (r1 = minus the physical emission), q = -p1-p2-r1, q^2 = m2
  # s = m2/z, t = m2 (u z - 1)/(z (1 + u)), m2 - s - t = m2 (z - u)/(z (1 + u))
  incoming_momenta: [p1, p2, r1, q]
  outgoing_momenta: []
  momentum_conservation: [q, -p1-p2-r1]
  kinematic_invariants:
    - [s,  2]
    - [t,  2]
    - [m2, 2]
  scalarproduct_rules:
    - [[p1,p1], 0]
    - [[p2,p2], 0]
    - [[r1,r1], 0]
    - [[p1+p2, p1+p2], s]
    - [[p1+r1, p1+r1], t]
    - [[p2+r1, p2+r1], m2-s-t]
  symbol_to_replace_by_one: m2
"""
# exported in the variables of the FORM pipeline: s = m2/z, t = m2 (u z - 1)/(z (1 + u)), m2 = 1
EXPORT_REPARAM = """      new_parameters: [z, u]
      reparametrization_rules: [ ["s", "1/z"], ["t", "(u*z-1)/(z*(1+u))"], ["m2", "1"] ]"""
SETUP = """  # sector mappings WITHOUT sector relations and symmetries (no k1 <-> k2), only zero sectors
  - setup_sector_mappings:
      conditional: true
      find_sector_relations: false
      find_sector_symmetries: false
      setup_crossings: false
"""
RUN = """#!/bin/bash
# Reduze reduction of {fam} (RVV 1L x 1L); REDUZE = path of reduze (default: reduze in PATH); MPIRUN = MPI launcher
# for an MPI build, e.g. MPIRUN="mpirun -np 8" (default: none, serial); low priority
cd "$(dirname "$0")"
nice -n 19 ${{MPIRUN:-}} ${{REDUZE:-reduze}} jobs.yaml > reduze.out 2>&1
"""


def read_families():
    text = open(os.path.join(FAMDIR, "integralfamilies_r.rvv.m")).read()
    mom = {int(n): m.split(",")[0].strip() for n, m in re.findall(r"DD\[(\d+)\] -> Den\[([^\]]*)\]", text)}
    block = text[text.index("{\n{") + 2: text.index("},\n{\n DD[1] ->")]
    fams = [[int(x) for x in re.findall(r"DD\[(\d+)\]", f)] for f in re.findall(r"\{([^{}]*)\}", block)]
    return mom, {n + 1: f for n, f in enumerate(fams)}


MOM, FAMS = read_families()


def read_tops(collection):
    path = os.path.join(CODE, "integrals", collection, "analysis", "topsectors.csv")
    if not os.path.exists(path):
        sys.exit(f"{path} missing: run Code_RVV_1L1L/integrals/Tools/analyse_integrals.py {collection} first")
    tops = {}
    for row in csv.DictReader(open(path)):
        tops.setdefault(int(row["family"][4:]), []).append((int(row["sector"]), int(row["r_tree"]), int(row["s_tree"])))
    return tops


def read_list(collection, n):
    """topoN[1,1,1,n4..n12] -> [(n4..n12)]"""
    out = []
    for line in open(os.path.join(CODE, "integrals", collection, "kira", f"topo{n}.txt")):
        idx = [int(x) for x in line[line.index("[") + 1:line.index("]")].split(",")]
        if idx[:NCUT] != [1] * NCUT:
            sys.exit(f"topo{n}: cut indices != 1 in {line.strip()}")
        out.append(tuple(idx[NCUT:]))
    return out


def write_job(name, n, ints, tops, r_extra, note):
    d = os.path.join(HERE, "jobs", name)
    os.makedirs(os.path.join(d, "config"), exist_ok=True)
    os.makedirs(os.path.join(d, "toreduce"), exist_ok=True)
    open(os.path.join(d, "config", "global.yaml"), "w").write(GLOBAL)
    open(os.path.join(d, "config", "kinematics.yaml"), "w").write(KINEMATICS)
    props = FAMS[n][NCUT:]
    with open(os.path.join(d, "config", "integralfamilies.yaml"), "w") as f:
        f.write(f"integralfamilies:\n  # Code_RVV_1L1L topo{n} without its 3 cut propagators ({note})\n"
                f"  - name: \"topo{n}\"\n    loop_momenta: [k1, k2]\n    propagators:\n")
        for dd in props:
            kind = "k1 box" if 4 <= dd <= 11 else ("k2 box" if 12 <= dd <= 19 else "numerator only")
            f.write(f"      - [ \"{MOM[dd]}\", 0 ]   # DD{dd} ({kind})\n")
    with open(os.path.join(d, "toreduce", f"topo{n}"), "w") as f:
        f.write("{\n" + ",\n".join(f"INT[\"topo{n}\",{{{','.join(map(str, x))}}}]" for x in sorted(ints)) + "\n}\n")
    # loop-only sector IDs (positions 4..12 -> bits 0..8); top sectors with their r, s
    entries = []
    for sec, r, s in sorted(tops, key=lambda x: -bin(x[0]).count("1")):
        loop = sec >> NCUT
        entries.append((loop, r - NCUT, s))
    smax = max(e[2] for e in entries)
    with open(os.path.join(d, "jobs.yaml"), "w") as f:
        f.write(f"# Reduze, RVV 1L x 1L, Code_RVV_1L1L topo{n} ({note})\njobs:\n" + SETUP)
        f.write("  - reduce_sectors:\n      conditional: true\n      sector_selection:\n        select_recursively: ["
                + ", ".join(f"[topo{n}, {e[0]}]" for e in entries) + "]\n      identities:\n        ibp:\n"
                f"          - {{ r: [t, t+{r_extra}], s: [0, {smax}] }}\n")
        f.write(f"""  - select_reductions:
      input_file: "toreduce/topo{n}"
      output_file: "results/topo{n}.tmp"
      notfound_file: "results/topo{n}.notfound"
  - reduce_files:
      equation_files: ["results/topo{n}.tmp"]
      output_file: "results/topo{n}.sol"
  - export:
      input_file: "results/topo{n}.sol"
      output_file: "results/topo{n}.m"
      output_format: "mma"
{EXPORT_REPARAM}
  - export:
      input_file: "results/topo{n}.sol"
      output_file: "results/topo{n}.inc"
      output_format: "form"
{EXPORT_REPARAM}
""")
    with open(os.path.join(d, "run.sh"), "w") as f:
        f.write(RUN.format(fam=f"topo{n}"))
    os.chmod(os.path.join(d, "run.sh"), 0o755)
    os.makedirs(os.path.join(d, "results"), exist_ok=True)
    print(f"{name}: {len(ints)} integrals, top sectors (loop-only) {[e[0] for e in entries]}, seeds r <= t+{r_extra}, s <= {smax}")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("command", choices=["jobs", "test"])
    ap.add_argument("--collection", default="all", help="Code_RVV_1L1L/integrals/<collection> (default all)")
    ap.add_argument("--fams", help="comma-separated family numbers (default: all with integrals)")
    ap.add_argument("--r-extra", type=int, default=1, help="seeds r in [t, t + this] (default 1)")
    ap.add_argument("--tag", help="jobs: name the jobs topoN_<tag> (e.g. for a test collection)")
    ap.add_argument("--max-s", type=int, default=1, help="test: integrals with numerator rank <= this (default 1)")
    ap.add_argument("--max-ints", type=int, default=20, help="test: at most this many integrals (default 20)")
    args = ap.parse_args()
    tops = read_tops(args.collection)
    fams = [int(x) for x in args.fams.split(",")] if args.fams else sorted(tops)
    for n in fams:
        ints = read_list(args.collection, n)
        if args.command == "jobs":
            write_job(f"topo{n}" + (f"_{args.tag}" if args.tag else ""), n, ints, tops[n], args.r_extra,
                      f"integrals/{args.collection}")
        else:
            sel = sorted((x for x in ints if -sum(v for v in x if v < 0) <= args.max_s),
                         key=lambda x: (-sum(1 for v in x if v > 0), sum(v for v in x if v < 0)))[:args.max_ints]
            if not sel:
                sys.exit(f"test: no integral of topo{n} with s <= {args.max_s}")
            s_sel = max(-sum(v for v in x if v < 0) for x in sel)
            top = [(sec, r, min(s, s_sel)) for sec, r, s in tops[n]]
            write_job(f"topo{n}_test", n, sel, top, args.r_extra,
                      f"TEST: {len(sel)} integrals with s <= {args.max_s}; integrals/{args.collection}")


if __name__ == "__main__":
    main()
