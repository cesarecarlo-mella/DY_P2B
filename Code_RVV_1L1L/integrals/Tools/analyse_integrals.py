#!/usr/bin/env python3
"""Sectors, top sectors and reduction parameters of a list of integrals.

    python3 analyse_integrals.py <integrals.m | integrals.txt | collection folder> [--out DIR] [--families 1,7,...]

RVV 1L x 1L version (Code_RVV_1L1L; copied from Code_RRV/integrals/Tools/analyse_integrals.py).
Input: INT[topoN, n1, ..., n12] (integrals.m from run_all.py integrals) or topoN[n1,...,n12] (integrals.txt, kira/).
Definitions (indices n1..n12 in the INT order of the family, see Families/fams/rvv_reconstruct.inc;
n1..n3 are the cut propagators, always 1; n4..n7 the k1 box (DD4..DD11 = (k1 + S)^2), n8..n11 the k2 box
(DD12..DD19 = (k2 + S)^2), n12 = (k1 + k2)^2 (DD20, numerator only)):
  sector       the set of indices with n_i > 0;  ID = sum over them of 2^(i-1)  (all 12 positions)
  t            number of indices with n_i > 0 (propagators of the sector, the 3 cut ones included)
  r            sum of the positive indices;  s = sum of |negative indices| (numerator rank);  dots = r - t
  top sector   a sector that occurs and is not contained in another occurring sector of the same family
  tree of a top sector: all occurring sectors contained in it (the top sector itself included). The reduction of a
  top sector needs seeds up to the maximal r and s over its whole tree (a subsector can have higher r or s).
Output (default: next to the input, analysis/; or --out DIR):
  topsectors.txt   one row per top sector: family, sector, t, r, s, dots (maxima over its tree), #sub (sectors in
                   the tree), #int (integrals in the tree), k1 | k2 propagators (DD numbers) [subsectors that set r, s or dots when they exceed the top sector's own]
  predicted.txt    the occurring top sectors against the predicted ones (Families/rvv_topsectors.m: all 11 lines): every occurring sector must lie inside a predicted top sector
  sectors.txt      one row per occurring sector: its own t, r, s, dots, #int and the top sectors containing it
  trees.txt        per top sector the occurring subsectors nested by inclusion, with their own values
  topsectors_list.txt   the top sectors as topoN[1,1,1,1,1,1,0,...] (1 = propagator present), one per line:
                   machine-readable list of the top sectors
  topsectors.csv, sectors.csv, sectors.json   the same, machine-readable
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


NCUT = 3
NPROP = 12
NK1 = 11            # DD4..DD11: k1 box propagators; DD12..DD19: k2 box; DD20 = (k1+k2)^2


def dd_order():
    """family -> DD numbers of its 12 propagators in INT order (1..4 cut), if the family files are there"""
    out = {}
    f = os.path.join(FAMDIR, "fams", "rvv_reconstruct.inc")
    if os.path.exists(f):
        for line in open(f):
            m = re.match(r"id RVTA\(\d+\)\*RVTB\(\d+\)\*TOPO\(1\)/DD1/DD2/DD3/(.*) = INT\(topo(\d+),", line)
            if m:
                out[int(m.group(2))] = [1, 2, 3] + [int(x) for x in re.findall(r"DD(\d+)\^", m.group(1))]
    return out


def predicted_tops():
    """family -> predicted top sectors (IDs) from Families/rvv_topsectors.m"""
    out = {}
    f = os.path.join(FAMDIR, "rvv_topsectors.m")
    if os.path.exists(f):
        for line in open(f):
            m = re.match(r"\s*\{topo(\d+), \{(.*)\}\},?\s*$", line)
            if m:
                out[int(m.group(1))] = [int(a) for a, _ in re.findall(r"\{(\d+), (\d+)\}", m.group(2))]
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


def table(header, rows):
    """aligned text table: first column left, the others right-aligned except the last one (left)"""
    w = [max(len(str(x)) for x in col) for col in zip(header, *rows)]

    def line(r):
        cells = [str(r[0]).ljust(w[0])] + [(str(x).ljust(w[k]) if isinstance(x, str) and not str(x).lstrip("-").isdigit()
                                            else str(x).rjust(w[k])) for k, x in enumerate(r[1:-1], 1)] + [str(r[-1])]
        return "  ".join(cells).rstrip()
    return "\n".join([line(header), line(["-" * k for k in w[:-1]] + ["-" * len(header[-1])])] + [line(r) for r in rows])


def main(argv):
    args, opts = [], {}
    k = 0
    while k < len(argv):
        if argv[k] in ("--out", "--families"):
            opts[argv[k]] = argv[k + 1]
            k += 2
        elif argv[k].startswith("-"):
            sys.exit(f"unknown option {argv[k]}\n\n" + __doc__)
        else:
            args.append(argv[k])
            k += 1
    if len(args) != 1:
        sys.exit("give one input (integrals.m, integrals.txt or a collection folder); output folder with --out\n\n"
                 + __doc__)
    path, ints = read_integrals(args[0])
    out = opts.get("--out", os.path.join(os.path.dirname(os.path.abspath(path)), "analysis"))
    only = {int(x) for x in opts["--families"].split(",")} if "--families" in opts else None
    os.makedirs(out, exist_ok=True)
    orders = dd_order()
    fams = [n for n in sorted(ints) if not only or n in only]

    top_rows, sec_rows, tree_txt, js, occ = [], [], [], {}, {}
    glob = {"t": 0, "r": 0, "s": 0, "dots": 0}
    for n in fams:
        order = orders.get(n)
        def reg(sec):
            dds = [order[i - 1] if order else i for i in sorted(sec) if i > NCUT]
            a, b = [d for d in dds if d <= NK1], [d for d in dds if NK1 < d < 20]
            return f"{' '.join(map(str, a)) or '-'} | {' '.join(map(str, b)) or '-'}"
        by_sec, secs, tops, trees = analyse_family(ints[n])
        occ[n] = ([sid(z) for z in secs], [sid(t) for t in tops])
        fr, fs, fd = stats(ints[n])
        glob = {"t": max(glob["t"], max(len(z) for z in secs)), "r": max(glob["r"], fr),
                "s": max(glob["s"], fs), "dots": max(glob["dots"], fd)}
        in_tops = {z: [sid(t) for t in tops if z <= t] for z in secs}
        js[f"topo{n}"] = {"n_int": len(ints[n]), "r": fr, "s": fs, "dots": fd, "propagators_DD": order,
                          "sectors": {}, "top_sectors": []}
        for z in secs:
            r, s_, d = stats(by_sec[z])
            sec_rows.append([f"topo{n}", sid(z), len(z), r, s_, d, len(by_sec[z]), " ".join(map(str, in_tops[z]))])
            js[f"topo{n}"]["sectors"][sid(z)] = {"lines": sorted(z), "t": len(z), "r": r, "s": s_, "dots": d,
                                                 "n_int": len(by_sec[z]), "top_sectors": in_tops[z]}
        tree_txt.append(f"=== topo{n}: {len(ints[n])} integrals, {len(secs)} sectors, {len(tops)} top sectors"
                        + (f"; propagators (position:DD) {' '.join(f'{i + 1}:{x}' for i, x in enumerate(order))}"
                           if order else ""))
        for t in tops:
            tr = trees[t]
            own = tr["top_only"]
            setby = "; ".join(f"{k} from {','.join(map(str, v))}" for k, v in tr["argmax"].items()
                              if v != [sid(t)] and (k != "r" or tr["r"] > own["r"]) and
                              (k != "s" or tr["s"] > own["s"]) and (k != "dots" or tr["dots"] > own["dots"]))
            top_rows.append([f"topo{n}", sid(t), len(t), reg(t), tr["s"], tr["dots"], tr["r"], len(tr["members"]),
                             tr["n_int"], setby])
            js[f"topo{n}"]["top_sectors"].append({"id": sid(t), "t": len(t), "lines": sorted(t), "regular_DD": reg(t),
                                                  "r": tr["r"], "s": tr["s"], "dots": tr["dots"],
                                                  "n_sub": len(tr["members"]), "n_int": tr["n_int"],
                                                  "top_only": own, "maxima_from": tr["argmax"],
                                                  "tree": sorted(sid(z) for z in tr["members"])})
            rows = [[f"{sid(t)}", len(t), *stats(by_sec[t]), len(by_sec[t]), reg(t)]]
            seen = set()

            def walk(sec, depth):
                for c in sorted(hasse_children(sec, tr["members"]), key=lambda z: (-len(z), sid(z))):
                    r, s_, d = stats(by_sec[c])
                    rows.append(["   " * depth + "- " + str(sid(c)), len(c), r, s_, d, len(by_sec[c]),
                                 reg(c) + ("   (listed above)" if c in seen else "")])
                    if c not in seen:
                        seen.add(c)
                        walk(c, depth + 1)
            walk(t, 1)
            tree_txt.append(f"\n  top sector {sid(t)}: tree r={tr['r']} s={tr['s']} dots={tr['dots']}, "
                            f"{len(tr['members'])} sectors, {tr['n_int']} integrals"
                            + (f"   [{setby}]" if setby else ""))
            tree_txt.append("  " + table(["sector", "t", "r", "s", "dots", "#int", "k1 | k2 propagators"],
                                         rows).replace("\n", "\n  "))
        tree_txt.append("")

    legend = ("t = number of propagators with positive power (3 cut + regular); r = sum of the positive powers; "
              "s = sum of |negative powers|; dots = r - t; sector = sum 2^(i-1) over the positive positions i")
    head = [f"input: {path}",
            f"{sum(len(ints[n]) for n in fams)} integrals in {len(fams)} families, {len(top_rows)} top sectors; "
            f"maxima: t={glob['t']} r={glob['r']} s={glob['s']} dots={glob['dots']}", legend]
    with open(os.path.join(out, "topsectors.txt"), "w") as f:
        f.write("\n".join(head) + "\ns(tree), dots(tree), r(tree): maxima over the tree of the top sector (all occurring "
                "sectors inside it) = what the reduction of the top sector needs; last column: the subsectors that set them "
                "when they exceed the top sector's own values\n\n"
                + table(["family", "sector", "t", "k1 | k2 propagators", "s(tree)", "dots(tree)", "r(tree)", "#sub",
                         "#int", "s/dots set by subsectors"], top_rows) + "\n")
    with open(os.path.join(out, "sectors.txt"), "w") as f:
        f.write("\n".join(head) + "\nr, s, dots, #int: the sector's own integrals only\n\n"
                + table(["family", "sector", "t", "r", "s", "dots", "#int", "in top sector(s)"], sec_rows) + "\n")
    with open(os.path.join(out, "trees.txt"), "w") as f:
        f.write("\n".join(head) + "\nper top sector: its occurring subsectors, nested by inclusion (own r, s, dots)\n\n"
                + "\n".join(tree_txt) + "\n")
    with open(os.path.join(out, "topsectors.csv"), "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["family", "sector", "t", "regular_DD", "s_tree", "dots_tree", "r_tree", "n_sub", "n_int",
                    "s_own", "dots_own", "r_own", "set_by"])
        for row, (n, x) in zip(top_rows, ((n, x) for n in fams for x in js[f"topo{n}"]["top_sectors"])):
            w.writerow(row[:9] + [x["top_only"]["s"], x["top_only"]["dots"], x["top_only"]["r"], row[9]])
    with open(os.path.join(out, "topsectors_list.txt"), "w") as f:        # top sectors, one per line
        f.write("".join(f"topo{n}[{','.join('1' if i + 1 in x['lines'] else '0' for i in range(NPROP))}]\n"
                        for n in fams for x in js[f"topo{n}"]["top_sectors"]))
    with open(os.path.join(out, "sectors.csv"), "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["family", "sector", "t", "r", "s", "dots", "n_int", "top_sectors"])
        w.writerows(sec_rows)
    with open(os.path.join(out, "sectors.json"), "w") as f:
        json.dump(js, f, indent=1)
    pred = predicted_tops()
    if pred:
        rows, outside_all = [], 0
        for n in fams:
            secs_n, tops_n = occ[n]
            p = pred.get(n, [])
            outside = [z for z in secs_n if not any(z & ~t == 0 for t in p)]
            used = [t for t in p if any(z & ~t == 0 for z in tops_n)]
            outside_all += len(outside)
            rows.append([f"topo{n}", len(tops_n), len(p), len(used), len(outside),
                         " ".join(map(str, outside[:10])) + (" ..." if len(outside) > 10 else "")])
        with open(os.path.join(out, "predicted.txt"), "w") as f:
            f.write("\n".join(head) + "\noccurring top sectors against the predicted ones (Families/rvv_topsectors.m); "
                    "'outside' = occurring sectors in no predicted top sector (must be 0)\n\n"
                    + table(["family", "#top occurring", "#top predicted", "#predicted used", "#outside",
                             "outside sectors"], rows) + "\n")
        print(f"predicted top sectors (Families/rvv_topsectors.m): {outside_all} occurring sectors outside them")
    for old in ("report.txt",):
        if os.path.exists(os.path.join(out, old)):
            os.remove(os.path.join(out, old))
    print("\n".join(head[:2]))
    print(f"-> {out}/: topsectors.txt, topsectors_list.txt, sectors.txt, trees.txt, predicted.txt "
          "(+ .csv, sectors.json)")


if __name__ == "__main__":
    main(sys.argv[1:])
