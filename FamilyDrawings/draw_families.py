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


CUTLEGS = ["r1", "r2", "r3", "q"]


def contiguous(members, seq):
    """are the members a contiguous block of the cyclic sequence seq?"""
    flags = [x in members for x in seq]
    return sum(flags[k] != flags[k - 1] for k in range(len(flags))) <= 2


def cut_order(left, right):
    """order of the cut lines (top to bottom) for which as many propagators as possible can be drawn without crossing:
    a tree is planar with its legs on the boundary in the cyclic order p1, cut lines, p2 iff every propagator's legs
    form a contiguous block"""
    def cost(order):
        seq = ["p1"] + list(order) + ["p2"]
        return sum(not contiguous(SPLIT[dd], seq) for dd in left + right)
    return min(itertools.permutations(CUTLEGS),
               key=lambda o: (cost(o), abs(o.index("q") - 1.5), o))


def positions(edges, fixed, xp, xc):
    """legs fixed; a vertex's x from its place between the p legs (x = xp) and the cut (x = xc): graph distances
    dp, dc -> x = xp + (xc - xp) dp / (dp + dc); its y the average of its neighbours' y"""
    adj = {}
    for a, b, _ in edges:
        adj.setdefault(a, set()).add(b)
        adj.setdefault(b, set()).add(a)

    def dist(sources):
        d, front = {v: 0 for v in sources}, list(sources)
        while front:
            nxt = []
            for v in front:
                for w in adj[v]:
                    if w not in d:
                        d[w] = d[v] + 1
                        nxt.append(w)
            front = nxt
        return d
    pl = [v for v in fixed if v[1:] in ("p1", "p2")]
    cl = [v for v in fixed if v not in pl]
    dp, dc = dist(pl), dist(cl)
    pos = dict(fixed)
    free = [v for v in adj if v not in fixed]
    for v in free:
        pos[v] = (xp + (xc - xp) * dp[v] / (dp[v] + dc[v]), 0.0)
    for _ in range(500):
        for v in free:
            pos[v] = (pos[v][0], sum(pos[w][1] for w in adj[v]) / len(adj[v]))
    # vertices at about the same x keep a minimum vertical distance (order kept)
    for _ in range(200):
        moved = False
        for v in free:
            for u in free:
                if u >= v or abs(pos[u][0] - pos[v][0]) > 0.45:
                    continue
                dy = pos[v][1] - pos[u][1]
                if abs(dy) < 0.8:
                    sgn = 1.0 if dy > 0 or (dy == 0 and v > u) else -1.0
                    shift = (0.8 - abs(dy)) / 2
                    pos[v] = (pos[v][0], pos[v][1] + sgn * shift)
                    pos[u] = (pos[u][0], pos[u][1] - sgn * shift)
                    moved = True
        if not moved:
            break
    return pos


SMOOTH = True                                                     # --straight: straight lines
ARROWS = True                                                     # --no-arrows: no momentum-flow arrows
MOMLABELS = False                                                 # --momentum-labels: momenta instead of DD numbers


def curve(pos, a, b):
    """smooth line from a to b: leaves and arrives horizontally (straight if nearly vertical)"""
    (xa, ya), (xb, yb) = pos[a], pos[b]
    if not SMOOTH or abs(xb - xa) < 0.7 or abs(yb - ya) < 0.05:
        return ""
    return (", out=0, in=180" if xb > xa else ", out=180, in=0") + ", looseness=0.75"


def tikz(n, dds, left, right):
    order = cut_order(left, right)
    W, H = 3.2, 1.0                                               # half width, spacing of the cut lines
    ycut = {leg: (1.5 - k) * H for k, leg in enumerate(order)}
    yp = {"p1": 2.3 * H, "p2": -2.3 * H}
    A = 0.75                                                      # cut lines: horizontal segments from -A to +A
    rename = lambda edges, side: [(a.replace("c", side + "c", 1) if a.startswith("c") else a,
                                   b.replace("c", side + "c", 1) if b.startswith("c") else b, lab) for a, b, lab in edges]
    edges_l, edges_r = rename(tree_edges(left, "L"), "L"), rename(tree_edges(right, "R"), "R")
    fixed_l = {"Lp1": (-W, yp["p1"]), "Lp2": (-W, yp["p2"]), **{f"Lc{x}": (-A, ycut[x]) for x in CUTLEGS}}
    fixed_r = {"Rp1": (W, yp["p1"]), "Rp2": (W, yp["p2"]), **{f"Rc{x}": (A, ycut[x]) for x in CUTLEGS}}
    pos = {**positions(edges_l, fixed_l, -W, -A), **positions(edges_r, fixed_r, W, A)}
    L = [r"\begin{tikzpicture}", r"\begin{feynman}"]
    for k, (x, y) in pos.items():
        if k in ("Lp1", "Lp2"):
            L.append(rf"\vertex ({k}) at ({x:.3f},{y:.3f}) {{${TEX[k[1:]]}$}};")
        elif k in ("Rp1", "Rp2"):
            L.append(rf"\vertex ({k}) at ({x:.3f},{y:.3f}) {{${TEX[k[1:]]}$}};")
        elif k[1:].startswith("c"):
            L.append(rf"\vertex ({k}) at ({x:.3f},{y:.3f});")
            if k == "Lcq":
                L.append(rf"\vertex (Mq) at (0,{y:.3f});")
        else:
            L.append(rf"\vertex[dot] ({k}) at ({x:.3f},{y:.3f}) {{}};")
    L.append(r"\diagram* {")
    # momentum flow (all legs incoming): in the amplitude every line carries the sum of the incoming momenta of the
    # legs below it towards the root (edges are listed child -> parent); in the conjugate the same momenta flow out
    # (parent -> child); through the cut r_i, q flow from right to left
    arrow = ", with arrow=0.55" if ARROWS else ""
    for side, edges in (("L", edges_l), ("R", edges_r)):
        for a, b, lab in edges:
            if side == "R":
                a, b = b, a
            c = curve(pos, a, b)
            if lab in ("p1", "p2"):
                L.append(f"({a}) -- [plain, thick{arrow}] ({b}),")
            elif lab == "q" and side == "R":                      # conjugate side of q: the rapidity half
                L.append(f"({a}) -- [plain, red!70!black, double, double distance=1.2pt, thick{c}] ({b}),")
            elif lab == "q":
                L.append(f"({a}) -- [boson, red!70!black{c}] ({b}),")
            elif lab in ("r1", "r2", "r3"):
                L.append(f"({a}) -- [plain, blue!60!black{c}{arrow}] ({b}),")
            else:
                text = (rf"\scriptsize ${'+'.join(TEX[x] for x in REGULAR[int(lab) - 6].split('+'))}$" if MOMLABELS
                        else rf"\footnotesize\bfseries {lab}")
                L.append(f"({a}) -- [plain{c}{arrow}, edge label={{{text}}}] ({b}),")
    for x in CUTLEGS:                                             # the cut lines through the cut
        if x == "q":                                              # q: wavy half (q^2 = m2), double half (rapidity)
            L.append("(Rcq) -- [plain, red!70!black, double, double distance=1.2pt, thick] (Mq) -- [boson, red!70!black] (Lcq),")
        else:
            L.append(f"(Rc{x}) -- [plain, blue!60!black{arrow}] (Lc{x}),")
    L.append("};")
    L.append(r"\end{feynman}")
    L.append(rf"\draw[dashed, gray!70] (0,{min(ycut.values()) - 0.8:.2f}) -- (0,{max(ycut.values()) + 0.8:.2f});")
    for x in CUTLEGS:
        col = "red!70!black" if x == "q" else "blue!60!black"
        L.append(rf"\node[font=\footnotesize, {col}, above] at (0.32,{ycut[x]:.2f}) {{${TEX[x]}$}};")
        if ARROWS and x == "q":
            L.append(rf"\draw[-{{Stealth[length=1.6mm]}}, red!70!black] (0.25,{ycut[x] - 0.2:.2f}) -- (-0.25,{ycut[x] - 0.2:.2f});")
    L.append(r"\end{tikzpicture}")
    return "\n".join(L)


def prop_table(lines, left, right, rest, absent):
    """the propagators of a drawing as a small table"""
    rows = [rf"\textbf{{{dd}}} & ${mom(dd)}$ & {'amplitude' if dd in left else 'conjugate'}\\" for dd in left + right]
    rows += [rf"\textbf{{{dd}}} & ${mom(dd)}$ & \textcolor{{red}}{{in no tree}}\\" for dd in rest]
    t = r"{\footnotesize\begin{tabular}{@{}r@{\ \ }l@{\ \ }l@{}}" + "\n".join(rows) + r"\end{tabular}}"
    if absent:
        t += r"\\[2pt]{\scriptsize pinched: " + ", ".join(rf"{dd} = ${mom(dd)}$" for dd in absent) + "}"
    return t


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
            cap = rf"\textbf{{FAM[{n}]}} (topo{n})\\[2pt]" + prop_table(lines, left, right, [], []) + (
                (r"\\[2pt]{\scriptsize irreducible numerators: " + ", ".join(rf"{dd} = ${mom(dd)}$" for dd in rest) + "}")
                if rest else "")
        else:
            cap = (rf"\textbf{{FAM[{n}]}} (topo{n}), sector with {len(lines)} of 7 lines"
                   + ("" if n in indep else r" \textcolor{red}{(not an independent family!)}") + r"\\[2pt]"
                   + prop_table(lines, left, right, rest, absent))
        blocks.append(r"\begin{minipage}[t]{0.48\textwidth}\centering\resizebox{0.9\linewidth}{!}{"
                      + tikz(n, lines, left, right) + r"}\\[2mm]" + cap + r"\end{minipage}")
    legend = r"\textbf{Regular propagators} (DD numbers, all legs incoming): " + "; ".join(
        f"{6 + i} = ${mom(6 + i)}$" for i in range(len(REGULAR))) + "."
    doc = [r"\documentclass[10pt]{article}", r"\usepackage[a4paper,margin=1.4cm]{geometry}", r"\usepackage{xcolor}",
           r"\usepackage[compat=1.1.0]{tikz-feynman}", r"\usetikzlibrary{arrows.meta}", r"\tikzfeynmanset{warn luatex=false}", r"\begin{document}",
           rf"\section*{{{title}}}",
           r"Amplitude (left) $\times$ conjugate (right) for $p_1 p_2 \to V(q)\, r_1 r_2 r_3$, glued along the cut "
           r"(dashed): $r_1, r_2, r_3$ (blue), $q$ (red). The rapidity condition $-q\cdot p_1 + u\, q\cdot p_2 = 0$ "
           r"of every family is not a line: the $q$ line is drawn wavy up to the cut ($q^2 = m^2$) and as a double line "
           r"after it (the rapidity condition). Internal lines carry their DD number. Arrows: momentum flow with all legs "
           r"incoming ($p_1+p_2+r_1+r_2+r_3+q=0$): in the amplitude every line carries the sum of the incoming momenta "
           r"on its far side, e.g.\ line 6 carries $p_1+r_1$; the conjugate is the mirror image, so $p_1, p_2$ leave on "
           r"the right and $r_i, q$ flow through the cut from right to left (the physical final-state momenta $-r_i$ "
           r"from left to right). " + legend + r"\par\medskip"]
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
    global SMOOTH, ARROWS, MOMLABELS
    SMOOTH = "--straight" not in argv
    ARROWS = "--no-arrows" not in argv
    MOMLABELS = "--momentum-labels" in argv
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
