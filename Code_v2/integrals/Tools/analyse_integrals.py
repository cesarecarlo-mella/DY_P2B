#!/usr/bin/env python3
"""Sectors, top sectors and reduction parameters of a list of integrals.

    python3 analyse_integrals.py <integrals.m | integrals.txt | collection folder> [--out DIR] [--families 1,7,...]

Input: INT[topoN, n1, ..., n12] (integrals.m from run_all.py integrals) or topoN[n1,...,n12] (integrals.txt, kira/).
Definitions (Kira conventions, indices n1..n12 in the INT order of the family, see Families/fams/reconstruct.inc;
n1..n5 are the cut propagators, always 1):
  sector       the set of indices with n_i > 0;  ID = sum over them of 2^(i-1)  (all 12 positions)
  lines        number of indices with n_i > 0 (propagators of the sector, cut ones included)
  r            sum of the positive indices;  s = sum of |negative indices| (numerator rank);  dots = r - lines
  top sector   a sector that occurs and is not contained in another occurring sector of the same family
  tree of a top sector: all occurring sectors contained in it (the top sector itself included). The reduction of a
  top sector needs seeds up to the maximal r and s over its whole tree (a subsector can have higher r or s).
Output (default: next to the input, analysis/):
  report.txt   per family: top sectors with ID, lines (position:DD), integrals in the tree, r, s, dots maxima, and the
               tree of occurring subsectors (nested by inclusion; a subsector shared by several top sectors is listed
               under each of them, nested once and marked elsewhere)
  topsectors.csv   one row per top sector (family, ID, lines, regular DD numbers, integrals, r, s, dots, ...)
  sectors.json     everything per family: all sectors with their integrals count and r/s, top sectors and trees
"""
import csv
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
FAMDIR = os.path.join(HERE, "..", "..", "Families")


def read_integrals(path):
    if os.path.isdir(path):
        path = os.path.join(path, "integrals.m") if os.path.exists(os.path.join(path, "integrals.m")) else \
            os.path.join(path, "integrals.txt")
    text = open(path).read()
    pat = (r"INT\[topo(\d+),\s*([-\d,\s]+)\]" if path.endswith(".m") else r"topo(\d+)\[([-\d,\s]+)\]")
    ints = {}
    for m in re.finditer(pat, text):
        idx = tuple(int(x) for x in m.group(2).replace(" ", "").split(","))
        ints.setdefault(int(m.group(1)), set()).add(idx)
    if not ints:
        sys.exit(f"no integrals found in {path}")
    return path, ints


def dd_order():
    """family -> DD numbers of its 12 propagators in INT order (1..5 cut), if the family files are there"""
    out = {}
    f = os.path.join(FAMDIR, "fams", "reconstruct.inc")
    if os.path.exists(f):
        for line in open(f):
            m = re.match(r"id TOPO\((\d+)\)/DD1/DD2/DD3/DD4/DD5/(.*) = INT\(topo\d+,", line)
            if m:
                out[int(m.group(1))] = [1, 2, 3, 4, 5] + [int(x) for x in re.findall(r"DD(\d+)\^", m.group(2))]
    return out


def sector_of(idx):
    return frozenset(i + 1 for i, n in enumerate(idx) if n > 0)


def sid(sec):
    return sum(1 << (i - 1) for i in sec)


def stats(idxs):
    r = max(sum(n for n in x if n > 0) for x in idxs)
    s = max(sum(-n for n in x if n < 0) for x in idxs)
    d = max(sum(n for n in x if n > 0) - sum(1 for n in x if n > 0) for x in idxs)
    return r, s, d


def analyse_family(idxs):
    by_sec = {}
    for x in idxs:
        by_sec.setdefault(sector_of(x), []).append(x)
    secs = sorted(by_sec, key=lambda z: (-len(z), sid(z)))
    tops = [z for z in secs if not any(z < o for o in secs)]
    trees = {}
    for t in tops:
        members = [z for z in secs if z <= t]
        ints = [x for z in members for x in by_sec[z]]
        r, s, d = stats(ints)
        top_r, top_s, top_d = stats(by_sec[t])
        # where the maxima come from (sectors of the tree that reach them)
        arg = {k: sorted({sid(z) for z in members if stats(by_sec[z])[i] == v}) for i, (k, v) in
               enumerate((("r", r), ("s", s), ("dots", d)))}
        trees[t] = {"members": members, "n_int": len(ints), "r": r, "s": s, "dots": d,
                    "top_only": {"n_int": len(by_sec[t]), "r": top_r, "s": top_s, "dots": top_d}, "argmax": arg}
    return by_sec, secs, tops, trees


def hasse_children(sec, members):
    inside = [z for z in members if z < sec]
    return [z for z in inside if not any(z < o for o in inside)]


def fmt_lines(sec, order):
    return " ".join(f"{i}:{order[i - 1]}" if order else str(i) for i in sorted(sec))


def main(argv):
    if not argv or argv[0].startswith("-"):
        sys.exit(__doc__)
    path, ints = read_integrals(argv[0])
    out = argv[argv.index("--out") + 1] if "--out" in argv else os.path.join(os.path.dirname(os.path.abspath(path)),
                                                                                  "analysis")
    only = {int(x) for x in argv[argv.index("--families") + 1].split(",")} if "--families" in argv else None
    os.makedirs(out, exist_ok=True)
    orders = dd_order()
    rep, rows, js = [], [], {}
    total_tops, glob = 0, {"r": 0, "s": 0, "dots": 0, "lines": 0}
    for n in sorted(ints):
        if only and n not in only:
            continue
        order = orders.get(n)
        by_sec, secs, tops, trees = analyse_family(ints[n])
        total_tops += len(tops)
        fr, fs, fd = stats(ints[n])
        glob = {"r": max(glob["r"], fr), "s": max(glob["s"], fs), "dots": max(glob["dots"], fd),
                "lines": max(glob["lines"], max(len(z) for z in secs))}
        rep.append(f"=== topo{n}: {len(ints[n])} integrals, {len(secs)} sectors, {len(tops)} top sectors; "
                   f"family maxima r={fr} s={fs} dots={fd}")
        if order:
            rep.append(f"    propagators (position:DD): {' '.join(f'{i + 1}:{d}' for i, d in enumerate(order))}")
        js[f"topo{n}"] = {"n_int": len(ints[n]), "r": fr, "s": fs, "dots": fd,
                          "sectors": {sid(z): {"lines": sorted(z), "n_int": len(by_sec[z]),
                                               **dict(zip(("r", "s", "dots"), stats(by_sec[z])))} for z in secs},
                          "top_sectors": []}
        for t in tops:
            tr = trees[t]
            reg = [order[i - 1] for i in sorted(t) if i > 5] if order else []
            rep.append(f"  TOP ID {sid(t)}: {len(t)} lines ({len(t) - 5} regular) [{fmt_lines(t, order)}]")
            rep.append(f"      tree: {len(tr['members'])} sectors, {tr['n_int']} integrals;  r={tr['r']} s={tr['s']} "
                       f"dots={tr['dots']}   (top sector alone: {tr['top_only']['n_int']} integrals, "
                       f"r={tr['top_only']['r']} s={tr['top_only']['s']} dots={tr['top_only']['dots']})")
            rep.append(f"      maxima reached in sectors: r {tr['argmax']['r']}, s {tr['argmax']['s']}, "
                       f"dots {tr['argmax']['dots']}")
            seen = set()

            def walk(sec, depth):
                for c in sorted(hasse_children(sec, tr["members"]), key=lambda z: (-len(z), sid(z))):
                    r, s, d = stats(by_sec[c])
                    mark = " (listed above)" if c in seen else ""
                    rep.append(f"      {'   ' * depth}- ID {sid(c)}: {len(c)} lines [{fmt_lines(c, order)}] "
                               f"{len(by_sec[c])} int, r={r} s={s} dots={d}{mark}")
                    if c not in seen:
                        seen.add(c)
                        walk(c, depth + 1)
            walk(t, 0)
            rows.append([f"topo{n}", sid(t), len(t), " ".join(map(str, reg)), len(tr["members"]), tr["n_int"],
                         tr["r"], tr["s"], tr["dots"], tr["top_only"]["r"], tr["top_only"]["s"]])
            js[f"topo{n}"]["top_sectors"].append({"id": sid(t), "lines": sorted(t), "regular_DD": reg,
                                                  "tree": sorted(sid(z) for z in tr["members"]),
                                                  "n_int": tr["n_int"], "r": tr["r"], "s": tr["s"],
                                                  "dots": tr["dots"], "top_only": tr["top_only"],
                                                  "argmax": tr["argmax"]})
        rep.append("")
    head = [f"input: {path}", f"{sum(len(v) for k, v in ints.items() if not only or k in only)} integrals in "
            f"{len(js)} families, {total_tops} top sectors; maxima over everything: lines={glob['lines']} "
            f"r={glob['r']} s={glob['s']} dots={glob['dots']}",
            "lines = propagators with positive power (5 cut + regular); r = sum of positive powers; s = sum of "
            "|negative powers|; dots = r - lines; ID = sum 2^(i-1) over the positive positions", ""]
    with open(os.path.join(out, "report.txt"), "w") as f:
        f.write("\n".join(head + rep) + "\n")
    with open(os.path.join(out, "topsectors.csv"), "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["family", "sector_id", "lines", "regular_DD", "tree_sectors", "tree_integrals", "r", "s", "dots",
                    "r_top_only", "s_top_only"])
        w.writerows(rows)
    with open(os.path.join(out, "sectors.json"), "w") as f:
        json.dump(js, f, indent=1)
    print("\n".join(head[:2]))
    print(f"-> {out}/report.txt, topsectors.csv, sectors.json")


if __name__ == "__main__":
    main(sys.argv[1:])
