#!/usr/bin/env python3
"""Draw the RRV integral families (one-loop amplitude x tree conjugate, two emissions) as cut diagrams.

    python3 draw_families_rrv.py [N ...]                 the 77 independent families (or the given ones) -> families_rrv.pdf
    python3 draw_families_rrv.py --sectors FILE          sectors, one per line: topoN[n1,...,n12] or "N: dd dd ..." -> sectors_rrv.pdf
    python3 draw_families_rrv.py --top-sectors integrals.m   maximal sectors per family among collected integrals

A family (Code_RRV/Families/integralfamilies_r.rrv.m) = 4 cut "propagators" (r1^2, r2^2, q^2 - m2 and the linear
rapidity condition) + 3 RR propagators DD5..DD13 (k1-free) + 5 loop propagators DD14..DD29 = (k1 + S)^2.
With all legs incoming (p1 + p2 + r1 + r2 + q = 0, k1 incoming) the loop propagators of a family form a chain
S_0 < S_1 < ... (the pentagon q-a-b-c-d); the legs entering the loop between two consecutive loop lines form a
group attached to one loop vertex. An RR propagator is a split of the five legs: it is drawn in the amplitude when
one of its sides lies inside a group (a tree attached to the loop), in the conjugate tree otherwise; the choice
covering most RR propagators is taken, the others are irreducible numerators (listed).
Layout and helpers from ../RRR/draw_families.py; drawing: TikZ-Feynman (pdflatex). Writes <name>.tex, .pdf, .json.
"""
import itertools
import json
import math
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
FAMDIR = os.path.join(HERE, "..", "..", "Code_RRV", "Families")
sys.path.insert(0, os.path.join(HERE, "..", "RRR"))
import draw_families as rrr                     # noqa: E402  ../RRR/draw_families.py: positions(), curve(), ...

LEGS = ["p1", "p2", "r1", "r2"]                # q = -(p1+p2+r1+r2)
ALL5 = frozenset(LEGS + ["q"])
CUTLEGS = ["r1", "r2", "q"]
TEX = {"p1": "p_1", "p2": "p_2", "r1": "r_1", "r2": "r_2", "q": "q", "k1": "k_1"}
NRR = 13                                        # DD5..DD13 RR, DD14..DD29 loop


def read_definitions():
    """DD number -> momentum string, e.g. 9 -> 'p1+r1+r2', 17 -> 'k1+p1+p2'; families (lists of DD numbers)"""
    text = open(os.path.join(FAMDIR, "integralfamilies_r.rrv.m")).read()
    mom = {int(n): m.split(",")[0].strip() for n, m in re.findall(r"DD\[(\d+)\] -> Den\[([^\]]*)\]", text)}
    block = text[text.index("{\n{") + 2: text.index("},\n{\n DD[1] ->")]
    fams = [[int(x) for x in re.findall(r"DD\[(\d+)\]", f)] for f in re.findall(r"\{([^{}]*)\}", block)]
    return mom, fams


MOM, FAMS = read_definitions()
SPLIT = {dd: frozenset(MOM[dd].split("+")) for dd in range(5, NRR + 1)}             # non-q side of an RR line
LOOPS = {dd: frozenset(x for x in MOM[dd].split("+") if x != "k1") for dd in range(NRR + 1, 30)}


def read_info():
    """family -> (RR family, pentagon legs) from rrv_families.txt"""
    out = {}
    for line in open(os.path.join(FAMDIR, "rrv_families.txt")):
        m = re.match(r"topo(\d+)\s+RR\s+(\d+)\s+(\S+)", line)
        if m:
            out[int(m.group(1))] = (int(m.group(2)), m.group(3))
    return out


def loop_groups(loop):
    """loop lines (a chain S_0 < S_1 < ...) -> ordered lines and the leg group at each loop vertex:
    vertex j sits between line j-1 and line j (cyclically); line j runs from vertex j to vertex j+1"""
    lines = sorted(loop, key=lambda dd: len(LOOPS[dd]))
    S = [LOOPS[dd] for dd in lines]
    groups = [frozenset(S[0] | (frozenset(LEGS) - S[-1]) | {"q"})]
    groups += [S[j] - S[j - 1] for j in range(1, len(S))]
    return lines, groups


def inside(dd, groups):
    """(group index, inside leg set) if one side of the RR line dd lies in a group with >= 2 legs, else None"""
    a = SPLIT[dd]
    b = ALL5 - a
    for g, G in enumerate(groups):
        for side in (a, b):
            if len(side) >= 2 and side <= G:
                return g, side
    return None


def compatible5(x, y):
    return x <= y or y <= x or not (x & y)


def assign(rr, groups):
    """RR lines -> (amplitude {dd: (group, inside set)}, conjugate [dd], numerators [dd]): most lines covered,
    then the most in the conjugate tree"""
    best = None
    for choice in itertools.product((0, 1, 2), repeat=len(rr)):        # 0 amplitude, 1 conjugate, 2 numerator
        amp, conj = {}, []
        ok = True
        for dd, c in zip(rr, choice):
            if c == 0:
                f = inside(dd, groups)
                if f is None:
                    ok = False
                    break
                amp[dd] = f
            elif c == 1:
                conj.append(dd)
        if not ok:
            continue
        if any(amp[x][0] == amp[y][0] and not compatible5(amp[x][1], amp[y][1]) for x, y in itertools.combinations(amp, 2)):
            continue
        if any(not rrr.compatible(SPLIT[x], SPLIT[y]) for x, y in itertools.combinations(conj, 2)):
            continue
        key = (len(amp) + len(conj), len(conj), tuple(-c for c in choice))
        if best is None or key > best[0]:
            best = (key, amp, conj)
    _, amp, conj = best
    return amp, conj, [dd for dd in rr if dd not in amp and dd not in conj]


def cyclic_blocks(groups, seq):
    """order of the groups along the cyclic sequence seq if every group is a contiguous block, else None"""
    if not all(rrr.contiguous(G, seq) for G in groups):
        return None
    n = len(seq)
    start = {}
    for g, G in enumerate(groups):
        for k in range(n):
            if seq[k] in G and seq[k - 1] not in G:
                start[g] = k
                break
        else:
            start[g] = 0
    return sorted(range(len(groups)), key=lambda g: start[g])


def same_cycle(a, b):
    n = len(a)
    if sorted(a) != sorted(b):
        return False
    for r in range(n):
        rot = b[r:] + b[:r]
        if rot == a or rot[::-1] == a:
            return True
    return False


def cut_order(groups, amp, conj):
    """order of the cut lines (top to bottom) for which the loop, its trees and the conjugate tree are planar"""
    def cost(order):
        seq = ["p1"] + list(order) + ["p2"]
        blocks = cyclic_blocks(groups, seq)
        c = 0 if blocks is not None and same_cycle(blocks, list(range(len(groups)))) else 2
        c += sum(not rrr.contiguous(side, seq) for _, side in amp.values())
        c += sum(not rrr.contiguous(SPLIT[dd], seq) for dd in conj)
        return c
    return min(itertools.permutations(CUTLEGS), key=lambda o: (cost(o), abs(o.index("q") - 1), o))


def amplitude_graph(lines, groups, amp, ycut, W, A, yp):
    """nodes, positions and edges of the one-loop amplitude (left half)"""
    m = len(lines)
    fixed = {"Lp1": (-W, yp["p1"]), "Lp2": (-W, yp["p2"]), **{f"Lc{x}": (-A, ycut[x]) for x in CUTLEGS}}
    leaf = {"p1": "Lp1", "p2": "Lp2", **{x: f"Lc{x}" for x in CUTLEGS}}
    xc, yc, R = -(W + A) / 2 - 0.15, 0.0, 0.85 if m > 2 else 0.6
    target = []
    for G in groups:
        xs = [fixed[leaf[x]] for x in G]
        target.append(math.atan2(sum(p[1] for p in xs) / len(xs) - yc, sum(p[0] for p in xs) / len(xs) - xc))
    best = None
    for sgn in (1, -1):
        for off in [k * math.pi / 36 for k in range(72)]:
            ang = [off + sgn * 2 * math.pi * j / m for j in range(m)]
            err = sum(min(abs(a - t) % (2 * math.pi), 2 * math.pi - abs(a - t) % (2 * math.pi)) ** 2
                      for a, t in zip(ang, target))
            if best is None or err < best[0]:
                best = (err, ang)
    pos = dict(fixed)
    for j, a in enumerate(best[1]):
        pos[f"Lv{j}"] = (xc + R * math.cos(a), yc + R * math.sin(a))
    edges = []                                                      # (from, to, kind, label) in momentum direction
    for j, dd in enumerate(lines):
        edges.append((f"Lv{j}", f"Lv{(j + 1) % m}", "loop", dd))
    tree_nodes = []
    for g, G in enumerate(groups):
        sets = {dd: side for dd, (gg, side) in amp.items() if gg == g}

        def parent(X):
            sup = [dd for dd, Y in sets.items() if X < Y]
            return f"Lt{min(sup, key=lambda d: len(sets[d]))}" if sup else f"Lv{g}"
        for dd, X in sets.items():
            edges.append((f"Lt{dd}", parent(X), "tree", dd))
            tree_nodes.append(f"Lt{dd}")
        for x in G:
            edges.append((leaf[x], parent(frozenset([x])), x, None))
    adj = {}
    for a, b, _, _ in edges:
        adj.setdefault(a, set()).add(b)
        adj.setdefault(b, set()).add(a)
    for v in tree_nodes:
        pos[v] = (sum(pos.get(w, (xc, yc))[0] for w in adj[v]) / len(adj[v]),
                  sum(pos.get(w, (xc, yc))[1] for w in adj[v]) / len(adj[v]))
    for _ in range(300):
        for v in tree_nodes:
            pos[v] = (sum(pos[w][0] for w in adj[v]) / len(adj[v]), sum(pos[w][1] for w in adj[v]) / len(adj[v]))
    return pos, edges


def conjugate_graph(conj, ycut, W, A, yp):
    nodes = {dd: SPLIT[dd] for dd in conj}
    edges = []

    def parent(s):
        sup = [dd for dd, t in nodes.items() if s < t]
        return f"R{min(sup, key=lambda d: len(nodes[d]))}" if sup else "Rroot"
    for dd, s in nodes.items():
        edges.append((f"R{dd}", parent(s), str(dd)))
    for leg in LEGS:
        edges.append((f"R{leg}" if leg in ("p1", "p2") else f"Rc{leg}", parent(frozenset([leg])), leg))
    edges.append(("Rcq", "Rroot", "q"))
    fixed = {"Rp1": (W, yp["p1"]), "Rp2": (W, yp["p2"]), **{f"Rc{x}": (A, ycut[x]) for x in CUTLEGS}}
    return rrr.positions(edges, fixed, W, A), edges


def mom(dd):
    return "(" + "+".join(TEX[x] for x in MOM[dd].split("+")) + ")^2"


def tikz(lines, groups, amp, conj):
    order = cut_order(groups, amp, conj)
    W, H, A = 3.4, 1.0, 0.75
    ycut = {leg: (1.0 - k) * H for k, leg in enumerate(order)}
    yp = {"p1": 2.1 * H, "p2": -2.1 * H}
    posL, edgesL = amplitude_graph(lines, groups, amp, ycut, W, A, yp)
    posR, edgesR = conjugate_graph(conj, ycut, W, A, yp)
    pos = {**posL, **posR}
    arrow = ", with arrow=0.55" if rrr.ARROWS else ""
    L = [r"\begin{tikzpicture}", r"\begin{feynman}"]
    for k, (x, y) in pos.items():
        if k in ("Lp1", "Lp2", "Rp1", "Rp2"):
            L.append(rf"\vertex ({k}) at ({x:.3f},{y:.3f}) {{${TEX[k[1:]]}$}};")
        elif k[1:].startswith("c"):
            L.append(rf"\vertex ({k}) at ({x:.3f},{y:.3f});")
            if k == "Lcq":
                L.append(rf"\vertex (Mq) at (0,{y:.3f});")
        else:
            L.append(rf"\vertex[dot] ({k}) at ({x:.3f},{y:.3f}) {{}};")
    L.append(r"\diagram* {")

    def label(dd):
        if rrr.MOMLABELS:
            return rf"\scriptsize ${'+'.join(TEX[x] for x in MOM[dd].split('+'))}$"
        return rf"\footnotesize\bfseries {dd}"
    m = len(lines)
    for a, b, kind, dd in edgesL:
        if kind == "loop":
            bend = ", half left" if m == 2 else ""                 # bubble: the two lines on opposite sides
            L.append(f"({a}) -- [plain, thick, green!45!black{bend}{arrow}, edge label={{{label(dd)}}}] ({b}),")
        elif kind == "tree":
            c = rrr.curve(pos, a, b)
            L.append(f"({a}) -- [plain{c}{arrow}, edge label={{{label(dd)}}}] ({b}),")
        elif kind in ("p1", "p2"):
            L.append(f"({a}) -- [plain, thick{arrow}] ({b}),")
        elif kind == "q":
            L.append(f"({a}) -- [boson, red!70!black{rrr.curve(pos, a, b)}] ({b}),")
        else:
            L.append(f"({a}) -- [plain, blue!60!black{rrr.curve(pos, a, b)}{arrow}] ({b}),")
    for a, b, lab in edgesR:
        a, b = b, a                                                  # conjugate: momenta flow out
        c = rrr.curve(pos, a, b)
        if lab in ("p1", "p2"):
            L.append(f"({a}) -- [plain, thick{arrow}] ({b}),")
        elif lab == "q":
            L.append(f"({a}) -- [plain, red!70!black, double, double distance=1.2pt, thick{c}] ({b}),")
        elif lab in ("r1", "r2"):
            L.append(f"({a}) -- [plain, blue!60!black{c}{arrow}] ({b}),")
        else:
            L.append(f"({a}) -- [plain{c}{arrow}, edge label={{{label(int(lab))}}}] ({b}),")
    for x in CUTLEGS:
        if x == "q":
            L.append("(Rcq) -- [plain, red!70!black, double, double distance=1.2pt, thick] (Mq) -- [boson, red!70!black] (Lcq),")
        else:
            L.append(f"(Rc{x}) -- [plain, blue!60!black] (Lc{x}),")
    L.append("};")
    L.append(r"\end{feynman}")
    L.append(rf"\draw[dashed, gray!70] (0,{min(ycut.values()) - 0.8:.2f}) -- (0,{max(ycut.values()) + 0.8:.2f});")
    for x in CUTLEGS:
        col = "red!70!black" if x == "q" else "blue!60!black"
        L.append(rf"\node[font=\footnotesize, {col}, above] at (0.32,{ycut[x]:.2f}) {{${TEX[x]}$}};")
    L.append(r"\end{tikzpicture}")
    return "\n".join(L)


def prop_table(lines, amp, conj, rest, absent):
    rows = [rf"\textbf{{{dd}}} & ${mom(dd)}$ & loop\\" for dd in lines]
    rows += [rf"\textbf{{{dd}}} & ${mom(dd)}$ & amplitude (tree on the loop)\\" for dd in amp]
    rows += [rf"\textbf{{{dd}}} & ${mom(dd)}$ & conjugate\\" for dd in conj]
    rows += [rf"\textbf{{{dd}}} & ${mom(dd)}$ & \textcolor{{red}}{{irreducible numerator}}\\" for dd in rest]
    t = r"{\footnotesize\begin{tabular}{@{}r@{\ \ }l@{\ \ }l@{}}" + "\n".join(rows) + r"\end{tabular}}"
    if absent:
        t += r"\\[2pt]{\scriptsize pinched: " + ", ".join(rf"{dd} = ${mom(dd)}$" for dd in absent) + "}"
    return t


def int_order():
    """family -> its 8 regular DD numbers in the order of the INT indices 5..12"""
    return {n + 1: [dd for dd in f if dd > 4] for n, f in enumerate(FAMS)}


def read_sectors(path, order):
    out = []
    for line in open(path):
        line = line.split("#")[0].strip()
        if not line:
            continue
        m = re.match(r"(?:INT\[)?topo(\d+)[\[,]\s*([-\d,\s]+)\]?", line)
        if m:
            n, idx = int(m.group(1)), [int(x) for x in m.group(2).replace(" ", "").strip(",").split(",")]
            out.append((n, [dd for dd, k in zip(order[n], idx[4:]) if k > 0]))
            continue
        m = re.match(r"(\d+)\s*:\s*([\d\s,]+)$", line)
        if m:
            out.append((int(m.group(1)), [int(x) for x in re.findall(r"\d+", m.group(2))]))
            continue
        sys.exit(f"{path}: cannot read line: {line}")
    return out


def top_sectors(path, order):
    secs = {}
    for m in re.finditer(r"INT\[topo(\d+), ([-\d, ]+)\]", open(path).read()):
        n, idx = int(m.group(1)), [int(x) for x in m.group(2).split(",")]
        secs.setdefault(n, set()).add(frozenset(dd for dd, k in zip(order[n], idx[4:]) if k > 0))
    out = []
    for n in sorted(secs):
        for sct in sorted(secs[n], key=lambda x: (-len(x), sorted(x))):
            if not any(sct < o for o in secs[n]):
                out.append((n, sorted(sct, key=order[n].index)))
    return out


def render(items, name, title):
    info = read_info()
    data, blocks = [], []
    for n, present in items:
        dds = [x for x in FAMS[n - 1] if x > 4]
        lines = dds if present is None else present
        loop = [dd for dd in lines if dd > NRR]
        rr = [dd for dd in lines if dd <= NRR]
        absent = [x for x in dds if x not in lines]
        head = (rf"\textbf{{topo{n}}}" + (f" (RR family {info[n][0]}, pentagon {info[n][1]})" if n in info else "")
                + ("" if present is None else f", sector with {len(lines)} of 8 lines")
                + ("" if n <= 77 else r" \textcolor{red}{(not an independent family!)}") + r"\\[2pt]")
        if len(loop) < 2:
            data.append({"family": n, "lines": lines, "loop": loop, "note": "fewer than two loop lines (scaleless)"})
            blocks.append(r"\begin{minipage}[t]{0.48\textwidth}" + head + "fewer than two loop lines: scaleless, zero"
                          + prop_table(loop, [], rr, [], absent) + r"\end{minipage}")
            continue
        loop_lines, groups = loop_groups(loop)
        amp, conj, rest = assign(rr, groups)
        data.append({"family": n, "lines": lines, "loop": loop_lines,
                     "loop_groups": [sorted(G) for G in groups], "amplitude_trees": sorted(amp),
                     "conjugate": conj, "irreducible_numerators": rest, "absent": absent})
        blocks.append(r"\begin{minipage}[t]{0.48\textwidth}\centering\resizebox{0.9\linewidth}{!}{"
                      + tikz(loop_lines, groups, amp, conj) + r"}\\[2mm]" + head
                      + prop_table(loop_lines, sorted(amp), conj, rest, absent) + r"\end{minipage}")
    legend = (r"\textbf{Propagators} (DD numbers, all legs incoming): " + "; ".join(
        f"{dd} = ${mom(dd)}$" for dd in range(5, 30)) + ".")
    doc = [r"\documentclass[10pt]{article}", r"\usepackage[a4paper,margin=1.4cm]{geometry}", r"\usepackage{xcolor}",
           r"\usepackage[compat=1.1.0]{tikz-feynman}", r"\usetikzlibrary{arrows.meta}", r"\tikzfeynmanset{warn luatex=false}",
           r"\begin{document}", rf"\section*{{{title}}}",
           r"One-loop amplitude (left) $\times$ tree conjugate (right) for $p_1 p_2 \to V(q)\, r_1 r_2$, glued along the "
           r"cut (dashed): $r_1, r_2$ (blue), $q$ (red). The loop lines (green) are the propagators $(k_1+S)^2$ of the "
           r"family present in the drawing; the legs entering the loop between two of them meet at one loop vertex, "
           r"through a tree when an RR propagator of the family separates them. The rapidity condition "
           r"$-q\cdot p_1 + u\, q\cdot p_2 = 0$ is not a line: the $q$ line is drawn wavy up to the cut ($q^2 = m^2$) and "
           r"as a double line after it. Arrows: momentum flow with all legs incoming ($p_1+p_2+r_1+r_2+q=0$, $k_1$ "
           r"incoming); the conjugate is the mirror image. " + legend + r"\par\medskip"]
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
    rrr.SMOOTH = "--straight" not in argv
    rrr.ARROWS = "--no-arrows" not in argv
    rrr.MOMLABELS = "--momentum-labels" in argv
    if "--sectors" in argv or "--top-sectors" in argv:
        order = int_order()
        if "--sectors" in argv:
            items = read_sectors(argv[argv.index("--sectors") + 1], order)
        else:
            items = top_sectors(argv[argv.index("--top-sectors") + 1], order)
        render(items, "sectors_rrv", "RRV top sectors as cut diagrams")
        return
    sel = [int(a) for a in argv if a.isdigit()] or list(range(1, 78))
    render([(n, None) for n in sel], "families_rrv", "RRV integral families as cut diagrams")


if __name__ == "__main__":
    main(sys.argv[1:])
