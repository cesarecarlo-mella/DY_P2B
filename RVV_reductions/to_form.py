#!/usr/bin/env python3
"""Reduze results of the RVV 1L x 1L families -> FORM tables for the insertion into the step-06 results.

    python3 to_form.py [--jobs topo1,topo2_test,...]       # default: every jobs/topoN with results/topoN.inc
    -> tables/red_topoN.inc   (CTable sparse RED<N>(9); one Fill per reduced integral and per master)

Input: jobs/<job>/results/topoN.m (Reduze Mathematica export, coefficients in z, u, d; each coefficient
put over a common denominator by Mathematica, $MATH, so that FORM gets RAT(numerator, denominator) with polynomials) and results/topoN.notfound (the
integrals Reduze did not reduce = masters). Reduze writes INT(topoN, t, ID, r, s, [], n1..n9) with the 9 loop indices
= positions 4..12 of the pipeline's INT(topoN, 1,1,1, n1..n9) (the 3 cut indices are always 1).
Masters: INT(topoN, a1..a4, b1..b4, n9) with n9 = 0 (the (k1+k2)^2 numerator is reduced away; anything else is an
error) is the product of a one-loop integral of box family A in k1 (amplitude, +i0) and one of box family B in k2
(conjugate, -i0), N = 3 (A - 1) + B: ML1(<k1 master>)*ML1C(<k2 master>), ML1C = complex conjugate. One-loop masters by
name (crossing notation 1 = p1, 2 = p2, 3 = r1), the same integral whatever the box ordering:
    B12, B13, B23, B123  bubbles (both indices 1) in (p1+p2)^2, (p1+r1)^2, (p2+r1)^2, q^2 = (p1+p2+r1)^2
    BOX1, BOX2, BOX3     boxes (all indices 1) of the RV orderings q-p1-p2-r1, q-p1-r1-p2, q-p2-p1-r1
    L1(A, a1, ..., a4)   anything else (kept explicit)
"""
import argparse
import glob
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
# RV box families (Code_RV topo1..3): the 4 propagators (k + S)^2, S as sets of legs
BOX = {1: [(), ("p1",), ("p1", "p2"), ("p1", "p2", "r1")],
       2: [(), ("p1",), ("p1", "r1"), ("p1", "p2", "r1")],
       3: [(), ("p2",), ("p1", "p2"), ("p1", "p2", "r1")]}
LEGNUM = {"p1": "1", "p2": "2", "r1": "3"}


def one_loop(A, a):
    """name of the one-loop integral of box family A with indices a (4)"""
    if list(a) == [1, 1, 1, 1]:
        return f"BOX{A}"
    pos = [i for i, x in enumerate(a) if x != 0]
    if len(pos) == 2 and all(a[i] == 1 for i in pos):
        S = set(BOX[A][pos[0]]) ^ set(BOX[A][pos[1]])          # momentum through the bubble
        if len(S) >= 2:
            return "B" + "".join(sorted(LEGNUM[x] for x in S))
    return f"L1({A},{','.join(map(str, a))})"


def master(N, idx):
    A, B = (N - 1) // 3 + 1, (N - 1) % 3 + 1
    if idx[8] != 0:
        sys.exit(f"topo{N}: master with a (k1+k2)^2 power: {idx}")
    k1, k2 = one_loop(A, idx[:4]), one_loop(B, idx[4:8])

    def wrap(f, x):
        return f"{f}({x[3:-1]})" if x.startswith("L1(") else f"{f}({x})"
    return f"{wrap('ML1', k1)}*{wrap('ML1C', k2)}"


MATH = os.environ.get("MATH", "math")
WL = r"""
(* one Reduze table: per rule, the left-hand side and per master the coefficient over a common denominator *)
rules = Get[$CommandLine[[-2]]];
out = OpenWrite[$CommandLine[[-1]]];
idx[i_] := StringRiffle[ToString /@ Last[List @@ i], ","];
str[e_] := StringReplace[ToString[e, InputForm], " " -> ""];
Do[Module[{lhs = r[[1]], rhs = Expand[r[[2]]], ms},
    ms = Union[Cases[{rhs}, _INT, Infinity]];
    WriteString[out, "L|" <> idx[lhs] <> "\n"];
    Do[Module[{c = Together[Coefficient[rhs, m]]},
        If[c =!= 0, WriteString[out, "M|" <> idx[m] <> "|" <> str[Numerator[c]] <> "|" <> str[Denominator[c]] <> "\n"]]],
      {m, ms}];
    If[Expand[rhs - Sum[Coefficient[rhs, m] m, {m, ms}]] =!= 0, WriteString[out, "E|rest not linear in the masters\n"]]],
  {r, rules}];
Close[out];
"""


def convert(job):
    res = glob.glob(os.path.join(HERE, "jobs", job, "results", "topo*.m"))
    if len(res) != 1:
        sys.exit(f"{job}: no (or more than one) results/topoN.m")
    N = int(re.search(r"topo(\d+)\.m$", res[0]).group(1))
    work = os.path.join(HERE, "jobs", job, "results")
    open(os.path.join(work, "to_form.wl"), "w").write(WL)
    flat = os.path.join(work, f"topo{N}.flat")
    subprocess.run([MATH, "-script", "to_form.wl", os.path.basename(res[0]), os.path.basename(flat)], cwd=work,
                   check=True, stdout=subprocess.DEVNULL)
    rows, masters, cur = [], set(), None
    for line in open(flat):
        w = line.rstrip("\n").split("|")
        if w[0] == "E":
            sys.exit(f"{job}: {w[1]}")
        if w[0] == "L":
            cur = (tuple(int(x) for x in w[1].split(",")), [])
            rows.append(cur)
        else:
            m = tuple(int(x) for x in w[1].split(","))
            masters.add(m)
            cur[1].append((m, w[2], w[3]))
    nf = res[0].replace(".m", ".notfound")
    if os.path.exists(nf):                                 # integrals not reduced = masters themselves
        for line in open(nf):
            w = line.split()
            if len(w) == 14 and w[0] == f"topo{N}":
                masters.add(tuple(int(x) for x in w[5:]))
    reduced = {r[0] for r in rows}
    if masters & reduced:
        sys.exit(f"{job}: integrals both reduced and master: {sorted(masters & reduced)[:3]}")
    os.makedirs(os.path.join(HERE, "tables"), exist_ok=True)
    out = os.path.join(HERE, "tables", f"red_topo{N}.inc")
    with open(out, "w") as f:
        f.write(f"* generated by RVV_reductions/to_form.py from jobs/{job}: INT(topo{N}, 1,1,1, n1..n9) -> masters\n"
                f"* ML1(k1 master) * ML1C(k2 master) * RAT(numerator, denominator) in z, u, d; ML1C = complex conjugate\n"
                f"CTable sparse, RED{N}(9);\n")
        for idx, terms in sorted(rows):
            body = "".join(f"+{master(N, m)}*RAT({num},{den})" for m, num, den in terms) or "0"
            f.write(f"Fill RED{N}({','.join(map(str, idx))}) = {body};\n")
        for idx in sorted(masters):
            f.write(f"Fill RED{N}({','.join(map(str, idx))}) = {master(N, idx)};\n")
    names = sorted({master(N, m) for m in masters})
    print(f"{job}: topo{N}, {len(rows)} reductions, {len(masters)} masters -> tables/red_topo{N}.inc")
    print("   masters: " + ", ".join(names))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--jobs", help="comma-separated job folders (default: every jobs/topoN with results)")
    args = ap.parse_args()
    jobs = args.jobs.split(",") if args.jobs else sorted(
        os.path.basename(d) for d in glob.glob(os.path.join(HERE, "jobs", "topo*"))
        if re.fullmatch(r"topo\d+", os.path.basename(d)) and glob.glob(os.path.join(d, "results", "topo*.m")))
    for job in jobs:
        convert(job)


if __name__ == "__main__":
    main()
