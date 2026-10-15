#!/usr/bin/env python3
"""Collect the propagators of every channel in channels.csv (needs step 01 output).

  python3 collect_props.py                 # all channels
  python3 collect_props.py Vqqbggg Vqgqgg  # selected channels (the summary file then covers only those)

Reads   ../Scripts/<group>/<P>/<P>_LO/tmp/parsed_diagrams/diag<n>_<P>_colour_out.0.dat
        (pQuark, pgluon, pghost of every diagram).
Writes  propagators/<P>.m      per channel:
                                 props[P]        distinct propagators
                                 diagProps[P]    propagators of each diagram n = 1..NDIAG
                                 pairProps[P]    {i, j, propagators of diagram i x conjugate of diagram j}, i <= j
                                 products[P]     Union of pairProps[P]
                                 maxProducts[P]  products[P] without the sets contained in another set
        propagators/all.m      over the channels:
                                 allProps        Union of props[P]
                                 allMaxProducts  Union of products[P] without the sets contained in another set
                                                 (no relabelling of r1, r2, r3 or p1, p2)

Momenta are written in the basis p1, p2, r1, r2, r3 (q = -p1-p2-r1-r2-r3, all QGRAF legs incoming),
with the overall sign fixed (first non-zero coefficient positive), since 1/k^2 is even.
Only propagators depending on r1, r2, r3 are kept: p1+p2 (= s, a constant) is dropped everywhere.
Every list says only whether a propagator occurs (no repeats, no powers).
Not included (same in every term of a channel): the cut final-state legs r1, r2, r3, the V propagator
and the rapidity factor Den(cut, -q.p1 + u q.p2).
"""
import csv, os, re, sys
from collections import Counter

HERE = os.path.dirname(os.path.abspath(__file__))
SCRIPTS = os.path.join(HERE, "..", "Scripts")
OUT = os.path.join(HERE, "propagators")
BASIS = ("p1", "p2", "r1", "r2", "r3")


def momentum(expr):
    """'q + p1' -> coefficient tuple over BASIS, sign normalised."""
    c = Counter()
    for sign, coef, v in re.findall(r"([+-]?)(\d*)\*?([a-z]\d?)", expr):
        k = (-1 if sign == "-" else 1) * (int(coef) if coef else 1)
        if v == "q":
            for b in BASIS:
                c[b] -= k
        elif v in BASIS:
            c[v] += k
        else:
            raise ValueError(f"unknown momentum {v} in {expr}")
    vec = tuple(c[b] for b in BASIS)
    first = next((x for x in vec if x), 0)
    if first < 0:
        vec = tuple(-x for x in vec)
    if not any(vec):
        raise ValueError(f"zero momentum: {expr}")
    return vec


def show(vec):
    s = ""
    for b, x in zip(BASIS, vec):
        if x:
            s += ("+" if x > 0 and s else "-" if x < 0 else "") + (f"{abs(x)}*" if abs(x) != 1 else "") + b
    return s


def propagators(term):
    t = re.sub(r"\s+", "", term)
    found = (re.findall(r"pQuark\(\d+,([^,()]+),\d+\)", t)
             + re.findall(r"pgluon\(\w+,\w+,([^,()]+)\)", t)
             + re.findall(r"pghost\(([^,()]+)\)", t))
    return Counter(momentum(m) for m in found)


def diagram(path):
    """Set of r-dependent propagators of one diagram; every term must have the same ones."""
    terms = [x for x in re.split(r"\n\s*\n", open(path).read().split("=", 1)[1]) if x.strip(" \n;")]
    sets = {tuple(sorted(propagators(x).items())) for x in terms}
    if len(sets) != 1:
        sys.exit(f"{path}: terms with different propagators")
    return {v for v, _ in sets.pop() if any(v[2:])}


def maximal(sets):
    """The sets not contained in another set."""
    out = []
    for x in sorted(sets, key=len, reverse=True):
        fx = frozenset(x)
        if not any(fx < y for y in out):
            out.append(fx)
    return {tuple(sorted(x)) for x in out}


def mlist(items):
    return "{" + ", ".join(items) + "}"


def mproducts(products):
    return "{\n  " + ",\n  ".join(mlist(show(v) for v in p) for p in sorted(products)) + "\n}"


def main(names):
    rows = list(csv.DictReader(open(os.path.join(SCRIPTS, "channels.csv"), newline="")))
    if names:
        unknown = set(names) - {r["name"] for r in rows}
        if unknown:
            sys.exit(f"not in channels.csv: {sorted(unknown)}")
        rows = [r for r in rows if r["name"] in names]
    os.makedirs(OUT, exist_ok=True)
    all_props, all_products = set(), set()
    print(f"{'channel':14s} diagrams  propagators  products  maximal")
    for r in rows:
        P = r["name"]
        lo = os.path.join(SCRIPTS, r["group"], P, f"{P}_LO")
        nd = int(re.search(r'NDIAG "(\d+)"', open(os.path.join(lo, "process_header.h")).read()).group(1))
        diags = [diagram(os.path.join(lo, "tmp", "parsed_diagrams", f"diag{n}_{P}_colour_out.0.dat"))
                 for n in range(1, nd + 1)]
        props = sorted({v for d in diags for v in d})
        pairs = [(i + 1, j + 1, tuple(sorted(diags[i] | diags[j])))
                 for i in range(nd) for j in range(i, nd)]
        products = {p for _, _, p in pairs}
        all_props |= set(props)
        all_products |= products
        with open(os.path.join(OUT, f"{P}.m"), "w") as f:
            f.write(f"(* {P}: {r['in']}; {nd} diagrams; generated by collect_props.py *)\n")
            f.write(f'props["{P}"] = {mlist(show(v) for v in props)};\n')
            f.write(f'diagProps["{P}"] = {{\n  ' + ",\n  ".join(mlist(show(v) for v in sorted(d)) for d in diags) + "\n};\n")
            f.write(f'pairProps["{P}"] = {{\n  ' + ",\n  ".join(f"{{{i}, {j}, {mlist(show(v) for v in p)}}}" for i, j, p in pairs) + "\n};\n")
            f.write(f'products["{P}"] = {mproducts(products)};\n')
            f.write(f'maxProducts["{P}"] = {mproducts(maximal(products))};\n')
        print(f"{P:14s} {nd:8d} {len(props):12d} {len(products):9d} {len(maximal(products)):8d}")
    all_max = maximal(all_products)
    with open(os.path.join(OUT, "all.m"), "w") as f:
        f.write(f"(* {len(rows)} channels: {', '.join(r['name'] for r in rows)}; generated by collect_props.py *)\n")
        f.write(f"allProps = {mlist(show(v) for v in sorted(all_props))};\n")
        f.write(f"allMaxProducts = {mproducts(all_max)};\n")
    print(f"\nall {len(rows)} channels: {len(all_props)} distinct propagators, {len(all_products)} distinct products, "
          f"{len(all_max)} not contained in another  ->  {os.path.relpath(OUT)}/")


if __name__ == "__main__":
    main(sys.argv[1:])
