#!/usr/bin/env python3
"""Draw the integral families of the triple-real phase-space integrals as cut diagrams -> families.pdf.

    python3 draw_families.py [--all] [N ...]       default: the independent families; --all: all; or family numbers
    python3 draw_families.py --sectors FILE        sectors, one per line: topoN[n1,...,n12] or "N: dd dd ..." -> sectors.pdf
    python3 draw_families.py --top-sectors integrals.m   maximal sectors per family among collected integrals

A family = 5 cut "propagators" (r1^2, r2^2, r3^2, q^2 - m2 and the linear rapidity condition) + 7 regular ones.
With all legs incoming (p1 + p2 + r1 + r2 + r3 + q = 0) every regular propagator (p1+r1)^2, (p1+p2+r1+r2)^2, ... is
a split of the six legs {p1, p2, r1, r2, r3, q}; a tree-level amplitude p1 p2 -> V(q) r1 r2 r3 is a set of compatible
(nested or disjoint) splits. The family is drawn as amplitude x conjugate amplitude glued along the cut lines
r1, r2, r3, q: the two trees (left = amplitude, right = conjugate) that together contain as many of the 7 regular
propagators as possible; the rest are irreducible numerators (listed). The rapidity condition is not a line (listed).
Families from ../Code_v2/Families (families_raw.m, families_relabelling.m, find_circuits.REGULAR).
Layout: graphviz dot; drawing: TikZ-Feynman (pdflatex). Writes families.tex, families.pdf, families.json.
"""
import itertools
import json
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
FAMDIR = os.path.join(HERE, "..", "Code_v2", "Families")
sys.path.insert(0, FAMDIR)
from find_circuits import REGULAR      # noqa: E402  DD6..DD29 momenta, e.g. "p1+r1"

LEGS = ["p1", "p2", "r1", "r2", "r3"]              # q = -(p1+p2+r1+r2+r3) is never in a regular momentum
SPLIT = {6 + i: frozenset(m.split("+")) for i, m in enumerate(REGULAR)}   # DD number -> legs on its non-q side
TEX = {"p1": "p_1", "p2": "p_2", "r1": "r_1", "r2": "r_2", "r3": "r_3", "q": "q"}


def read_families():
    raw = open(os.path.join(FAMDIR, "families_raw.m")).read()
    fams = [list(map(int, re.findall(r"\d+", x))) for x in re.findall(r"\{([\d,\s]+)\}", raw)]
    rel = open(os.path.join(FAMDIR, "families_relabelling.m")).read()
    indep = [int(x) for x in re.findall(r"FAM\[(\d+)\]", re.search(r"independentFamilies = \{(.*?)\};", rel, re.S).group(1))]
    return fams, indep


def compatible(a, b):
    return a <= b or b <= a or not (a & b)


def best_trees(dds):
    """two compatible subsets (amplitude, conjugate) of the regular propagators covering as many as possible"""
    cliques = [c for k in range(len(dds) + 1) for c in itertools.combinations(dds, k)
               if all(compatible(SPLIT[x], SPLIT[y]) for x, y in itertools.combinations(c, 2))]
    maximal = [c for c in cliques if not any(set(c) < set(d) for d in cliques)]
    best = max(((a, b) for a in maximal for b in maximal),
               key=lambda ab: (len(set(ab[0]) | set(ab[1])), -len(set(ab[0]) & set(ab[1])), min(len(ab[0]), len(ab[1])),
                               ab[0] <= ab[1]))
    a, b = sorted(best, key=lambda c: (-len(c), c))
    b = [x for x in b if x not in a]                 # a line in both trees only once (drawn on the amplitude side)
    return list(a), list(b)


def tree_edges(splits, side):
    """edges of one tree: (node, node, label); leaves p1, p2 (side) and cut nodes c_r1.. c_q; internal vertex per split
    plus a root vertex where q attaches"""
    nodes = {dd: SPLIT[dd] for dd in splits}
    root = f"{side}root"
    edges = []

    def parent(s):
        sup = [dd for dd, t in nodes.items() if s < t]
        return f"{side}{min(sup, key=lambda d: len(nodes[d]))}" if sup else root
    for dd, s in nodes.items():                                          # propagators
        edges.append((f"{side}{dd}", parent(s), str(dd)))
    for leg in LEGS:                                                     # external and cut legs
        leaf = f"{side}{leg}" if leg in ("p1", "p2") else f"c{leg}"
        edges.append((leaf, parent(frozenset([leg])), leg))
    edges.append(("cq", root, "q"))
    return edges


def layout(edges):
    """positions from graphviz dot, left to right: amplitude (edges oriented towards the cut), cut, conjugate
    (edges oriented away from the cut)"""
    cut = ["cr1", "cr2", "cr3", "cq"]
    adj = {}
    for a, b, _ in edges:
        adj.setdefault(a, set()).add(b)
        adj.setdefault(b, set()).add(a)
    dist, front = {c: 0 for c in cut}, list(cut)                      # distance from the cut
    while front:
        nxt = []
        for x in front:
            for y in adj[x]:
                if y not in dist:
                    dist[y] = dist[x] + 1
                    nxt.append(y)
        front = nxt
    lines = ["digraph G {", "rankdir=LR; nodesep=0.35; ranksep=0.6;",
             "{rank=min; Lp1; Lp2;}", "{rank=max; Rp1; Rp2;}", "{rank=same; " + "; ".join(cut) + ";}"]
    for a, b, _ in edges:
        left = a.startswith("L") or b.startswith("L")
        far, near = (a, b) if dist[a] >= dist[b] else (b, a)
        lines.append(f"{far} -> {near};" if left else f"{near} -> {far};")
    lines.append("}")
    out = subprocess.run(["dot", "-Tplain"], input="\n".join(lines), capture_output=True, text=True, check=True).stdout
    pos = {}
    for line in out.splitlines():
        p = line.split()
        if p and p[0] == "node":
            pos[p[1]] = (float(p[2]), float(p[3]))
    return pos


def tikz(n, dds, left, right):
    edges = tree_edges(left, "L") + tree_edges(right, "R")
    pos = layout(edges)
    xs = [x for x, _ in pos.values()]
    sx = 7.0 / (max(xs) - min(xs))
    pos = {k: ((x - min(xs)) * sx, y * sx) for k, (x, y) in pos.items()}
    ycut = [pos[c][1] for c in ("cr1", "cr2", "cr3", "cq")]
    xcut = sum(pos[c][0] for c in ("cr1", "cr2", "cr3", "cq")) / 4
    L = [r"\begin{tikzpicture}", r"\begin{feynman}"]
    for k, (x, y) in pos.items():
        if k in ("Lp1", "Lp2", "Rp1", "Rp2"):
            L.append(rf"\vertex ({k}) at ({x:.2f},{y:.2f}) {{\scriptsize ${TEX[k[1:]]}$}};")
        elif k.startswith("c"):
            L.append(rf"\vertex ({k}) at ({xcut:.2f},{y:.2f});")
        else:
            L.append(rf"\vertex[dot] ({k}) at ({x:.2f},{y:.2f}) {{}};")
    L.append(r"\diagram* {")
    for a, b, lab in edges:
        if lab in ("p1", "p2"):
            L.append(f"({a}) -- [plain] ({b}),")
        elif lab == "q":
            L.append(f"({a}) -- [boson, red!70!black] ({b}),")
        elif lab in ("r1", "r2", "r3"):
            L.append(f"({a}) -- [plain, blue!60!black] ({b}),")
        else:
            L.append(f"({a}) -- [plain, edge label={{\\tiny {lab}}}] ({b}),")
    L.append("};")
    L.append(r"\end{feynman}")
    L.append(rf"\draw[dashed, gray] ({xcut:.2f},{min(ycut) - 0.6:.2f}) -- ({xcut:.2f},{max(ycut) + 0.6:.2f});")
    for c in ("cr1", "cr2", "cr3", "cq"):
        L.append(rf"\node[font=\tiny, right] at ({xcut:.2f},{pos[c][1] + 0.15:.2f}) {{${TEX[c[1:]]}$}};")
    L.append(r"\end{tikzpicture}")
    return "\n".join(L)


def mom(dd):
    return "(" + "+".join(TEX[x] for x in REGULAR[dd - 6].split("+")) + ")^2"


def int_order():
    """family -> its 7 regular DD numbers in the order of the INT indices 6..12 (from reconstruct.inc)"""
    out = {}
    for line in open(os.path.join(FAMDIR, "fams", "reconstruct.inc")):
        m = re.match(r"id TOPO\((\d+)\)/DD1/DD2/DD3/DD4/DD5/(.*) = INT\(topo\d+,", line)
        if m:
            out[int(m.group(1))] = [int(x) for x in re.findall(r"DD(\d+)\^", m.group(2))]
    return out


def read_sectors(path, order):
    """lines 'topoN[n1,...,n12]' (positive index = line present) or 'N: dd dd dd' -> [(N, [DDs])]"""
    out = []
    for line in open(path):
        line = line.split("#")[0].strip()
        if not line:
            continue
        m = re.match(r"(?:INT\[)?topo(\d+)[\[,]\s*([-\d,\s]+)\]?", line)
        if m:
            n, idx = int(m.group(1)), [int(x) for x in m.group(2).replace(" ", "").strip(",").split(",")]
            out.append((n, [dd for dd, k in zip(order[n], idx[5:]) if k > 0]))
            continue
        m = re.match(r"(\d+)\s*:\s*([\d\s,]+)$", line)
        if m:
            out.append((int(m.group(1)), [int(x) for x in re.findall(r"\d+", m.group(2))]))
            continue
        sys.exit(f"{path}: cannot read line: {line}")
    return out


def top_sectors(path, order):
    """maximal sectors (sets of lines present) per family among the integrals of an integrals.m list"""
    secs = {}
    for m in re.finditer(r"INT\[topo(\d+), ([-\d, ]+)\]", open(path).read()):
        n, idx = int(m.group(1)), [int(x) for x in m.group(2).split(",")]
        secs.setdefault(n, set()).add(frozenset(dd for dd, k in zip(order[n], idx[5:]) if k > 0))
    out = []
    for n in sorted(secs):
        for sct in sorted(secs[n], key=lambda x: (-len(x), sorted(x))):
            if not any(sct < o for o in secs[n]):
                out.append((n, sorted(sct, key=order[n].index)))
    return out


def render(items, fams, indep, name, title):
    """items: [(family, lines present or None for the whole family)]"""
    data, blocks = [], []
    for n, present in items:
        dds = [x for x in fams[n - 1] if x > 5]
        lines = dds if present is None else present
        left, right = best_trees(lines)
        rest = [x for x in lines if x not in left and x not in right]
        absent = [x for x in dds if x not in lines]
        data.append({"family": n, "lines": lines, "amplitude": left, "conjugate": right,
                     "not_in_trees": rest, "absent": absent, "independent": n in indep})
        if present is None:
            cap = (rf"\textbf{{FAM[{n}]}} (topo{n})\\[1pt] \scriptsize left: {', '.join(map(str, left))}; "
                   rf"right: {', '.join(map(str, right))}"
                   + (rf"; numerators: {', '.join(f'{x} = ${mom(x)}$' for x in rest)}" if rest else "; no numerators"))
        else:
            cap = (rf"\textbf{{FAM[{n}]}} (topo{n}), sector with {len(lines)} of 7 lines"
                   + ("" if n in indep else r" \textcolor{red}{(not an independent family!)}")
                   + rf"\\[1pt] \scriptsize left: {', '.join(map(str, left)) or '--'}; right: {', '.join(map(str, right)) or '--'}"
                   + (rf"; absent: {', '.join(map(str, absent))}" if absent else "")
                   + (rf"; \textcolor{{red}}{{in no tree: {', '.join(map(str, rest))}}}" if rest else ""))
        blocks.append(r"\begin{minipage}[t]{0.48\textwidth}\centering\resizebox{0.92\linewidth}{!}{"
                      + tikz(n, lines, left, right) + r"}\\[1mm]" + cap + r"\end{minipage}")
    legend = r"\textbf{Regular propagators} (DD numbers, all legs incoming): " + "; ".join(
        f"{6 + i} = ${mom(6 + i)}$" for i in range(len(REGULAR))) + "."
    doc = [r"\documentclass[10pt]{article}", r"\usepackage[a4paper,margin=1.4cm]{geometry}", r"\usepackage{xcolor}",
           r"\usepackage[compat=1.1.0]{tikz-feynman}", r"\tikzfeynmanset{warn luatex=false}", r"\begin{document}",
           rf"\section*{{{title}}}",
           r"Amplitude (left) $\times$ conjugate (right) for $p_1 p_2 \to V(q)\, r_1 r_2 r_3$, glued along the cut "
           r"(dashed): $r_1, r_2, r_3$ (blue), $q$ (red, $q^2 = m^2$). The rapidity condition $-q\cdot p_1 + u\, q\cdot p_2 = 0$ "
           r"of every family is not a line. Internal lines carry their DD number. " + legend + r"\par\medskip"]
    for i, b in enumerate(blocks):
        doc.append(b + ("\n\n\\bigskip\n" if i % 2 else "\\hfill%"))
    doc.append(r"\end{document}")
    open(os.path.join(HERE, name + ".tex"), "w").write("\n".join(doc))
    json.dump(data, open(os.path.join(HERE, name + ".json"), "w"), indent=1)
    r = subprocess.run(["pdflatex", "-interaction=nonstopmode", name + ".tex"], cwd=HERE, capture_output=True, text=True)
    for ext in (".aux", ".log"):
        if r.returncode == 0 and os.path.exists(os.path.join(HERE, name + ext)):
            os.remove(os.path.join(HERE, name + ext))
    if r.returncode != 0:
        print(r.stdout[-2500:])
        sys.exit("pdflatex failed")
    print(f"{len(items)} drawings -> {HERE}/{name}.pdf, {name}.json")


def main(argv):
    fams, indep = read_families()
    if "--sectors" in argv or "--top-sectors" in argv:
        order = int_order()
        if "--sectors" in argv:
            items = read_sectors(argv[argv.index("--sectors") + 1], order)
        else:
            items = top_sectors(argv[argv.index("--top-sectors") + 1], order)
        render(items, fams, indep, "sectors", "Top sectors as cut diagrams")
        return
    if "--all" in argv:
        sel = list(range(1, len(fams) + 1))
    elif [a for a in argv if a.isdigit()]:
        sel = [int(a) for a in argv if a.isdigit()]
    else:
        sel = indep
    render([(n, None) for n in sel], fams, indep, "families", "Integral families as cut diagrams")


if __name__ == "__main__":
    main(sys.argv[1:])
