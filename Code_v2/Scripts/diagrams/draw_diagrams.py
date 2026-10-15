#!/usr/bin/env python3
"""One representative Feynman diagram per channel -> diagrams.pdf (TikZ-Feynman, pdflatex; layout by graphviz dot).

    python3 draw_diagrams.py [channel ...]        (needs the QGRAF outputs <P>_LO/external/<P>.0.inc)

Representative: the first QGRAF diagram with only 3-point vertices and V on the q line (else the first one).
QGRAF has all legs incoming: p1, p2 are the initial state; a final-state particle is the conjugate of the QGRAF
field at r1, r2, r3 (e.g. Qbar[r1] = outgoing quark). Fermion (and ghost) arrows follow the fermion flow:
at a vertex v3(Qbar(a),X,Quark(b)) the flow enters along b and leaves along a (same for Ghost / ghost).
"""
import csv
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SCRIPTS = os.path.dirname(HERE)
FERMION_IN = {"Quark", "Quark2", "ghost"}          # flow enters the vertex along this slot
FERMION_OUT = {"Qbar", "Qbar2", "Ghost"}           # flow leaves the vertex along this slot
STYLE = {"Quark": "fermion", "Qbar": "fermion", "Quark2": "fermion, blue!70!black",
         "Qbar2": "fermion, blue!70!black", "ghost": "ghost, with arrow=0.5", "Ghost": "ghost, with arrow=0.5",
         "gluon": "gluon", "V": "boson, red!70!black"}
NAME_IN = {"Quark": "q", r"Qbar": r"\bar q", "Quark2": "Q", "Qbar2": r"\bar Q", "gluon": "g",
           "ghost": "c", "Ghost": r"\bar c", "V": "V"}
CONJ = {"Quark": "Qbar", "Qbar": "Quark", "Quark2": "Qbar2", "Qbar2": "Quark2", "ghost": "Ghost", "Ghost": "ghost",
        "gluon": "gluon", "V": "V"}
LEGS = {-1: "p_1", -3: "p_2", -5: "q", -7: "r_1", -9: "r_2", -11: "r_3"}


def parse(path):
    text = open(path).read()
    diags = []
    for m in re.finditer(r"id diag(\d+) = \(([^)]*)\)\*(.*?);", text, re.S):
        body = m.group(3)
        props = re.findall(r"prop\((\w+)\((-?\d+),(-?\d+),([^)]*)\)\)", body)
        verts = [re.findall(r"(\w+)\((-?\d+),", vb) for vb in re.findall(r"v\d\(((?:\w+\([^()]*\),?)+)\)", body)]
        diags.append({"n": int(m.group(1)), "props": props, "verts": verts})
    return diags


def representative(diags):
    for d in diags:
        if all(len(v) == 3 for v in d["verts"]):
            vv = [v for v in d["verts"] if any(f == "V" for f, _ in v)][0]
            if any(f in ("Quark", "Qbar") for f, _ in vv):
                return d
    return diags[0]


def edges(d, ext_fields):
    """-> list of (a, b, field, flow) with nodes 'v<k>' (vertices) or 'e<leg>' (external); flow: a -> b or None"""
    where = {}                                            # field index -> (vertex, slot field)
    for k, v in enumerate(d["verts"]):
        for f, idx in v:
            where.setdefault(int(idx), []).append((f"v{k}", f))
    out = []
    for leg, f in ext_fields.items():                     # external legs (negative indices)
        (vtx, slot), = where[leg]
        if slot in FERMION_IN:
            out.append((f"e{-leg}", vtx, slot, True))
        elif slot in FERMION_OUT:
            out.append((vtx, f"e{-leg}", slot, True))
        else:
            out.append((f"e{-leg}", vtx, slot, False))
    for f, i, j, mom in d["props"]:                        # prop(F(i,j)): F at end i, its dual at end j
        (vi, si), = where[int(i)]
        (vj, sj), = where[int(j)]
        if si in FERMION_IN:                              # flow from the vertex with the dual slot to the one with F
            out.append((vj, vi, f, True))
        elif si in FERMION_OUT:
            out.append((vi, vj, f, True))
        else:
            out.append((vi, vj, f, False))
    return out


def layout(edge_list, initial, final):
    """positions (cm) from graphviz dot, left to right, initial legs left, final legs right"""
    # orient edges for the layering: from the end nearer to the initial legs
    adj = {}
    for a, b, *_ in edge_list:
        adj.setdefault(a, set()).add(b)
        adj.setdefault(b, set()).add(a)
    dist, front = {n: 0 for n in initial}, list(initial)
    while front:
        nxt = []
        for n in front:
            for m in adj[n]:
                if m not in dist:
                    dist[m] = dist[n] + 1
                    nxt.append(m)
        front = nxt
    lines = ["digraph G {", "rankdir=LR; nodesep=0.5; ranksep=0.7;",
             "{rank=min; " + " ".join(initial) + ";}", "{rank=max; " + " ".join(final) + ";}"]
    for a, b, *_ in edge_list:
        x, y = (a, b) if dist.get(a, 0) <= dist.get(b, 0) else (b, a)
        lines.append(f"{x} -> {y};")
    lines.append("}")
    out = subprocess.run(["dot", "-Tplain"], input="\n".join(lines), capture_output=True, text=True, check=True).stdout
    pos = {}
    for line in out.splitlines():
        p = line.split()
        if p and p[0] == "node":
            pos[p[1]] = (float(p[2]) * 1.15, float(p[3]) * 1.15)
    return pos


def tikz(chan, d, fields):
    ext = {int(k): f for k, f in fields.items()}
    el = edges(d, ext)
    initial, final = ["e1", "e3"], ["e5", "e7", "e9", "e11"]
    pos = layout(el, initial, final)
    L = [r"\begin{tikzpicture}[baseline=(current bounding box.center)]", r"\begin{feynman}"]
    for n, (x, y) in pos.items():
        if n.startswith("e"):
            leg = -int(n[1:])
            f = ext[leg]
            phys = f if leg in (-1, -3, -5) else CONJ[f]
            L.append(rf"\vertex ({n}) at ({x:.2f},{y:.2f}) {{\small ${NAME_IN[phys]}({LEGS[leg]})$}};")
        else:
            L.append(rf"\vertex[dot] ({n}) at ({x:.2f},{y:.2f}) {{}};")
    L.append(r"\diagram* {")
    for a, b, f, flow in el:
        L.append(f"({a}) -- [{STYLE[f]}] ({b}),")
    L += ["};", r"\end{feynman}", r"\end{tikzpicture}"]
    return "\n".join(L)


def process(fields):
    ini = " ".join(NAME_IN[fields[k]] for k in ("-1", "-3"))
    fin = " ".join(NAME_IN[CONJ[fields[k]]] for k in ("-7", "-9", "-11"))
    return f"${ini} \\to V\\, {fin}$"


def main(names):
    rows = list(csv.DictReader(open(os.path.join(SCRIPTS, "channels.csv"))))
    if names:
        rows = [r for r in rows if r["name"] in names]
    blocks, group = [], None
    for r in rows:
        P = r["name"]
        inc = os.path.join(SCRIPTS, r["group"], P, P + "_LO", "external", f"{P}.0.inc")
        if not os.path.exists(inc):
            print(f"{P}: no QGRAF output, skipped")
            continue
        diags = parse(inc)
        d = representative(diags)
        fields = dict(zip(("-1", "-3", "-5", "-7", "-9", "-11"),
                          re.findall(r"(\w+)\[[^]]*\]", r["in"])))
        if r["group"] != group:
            group = r["group"]
            blocks.append(rf"\section*{{\texttt{{{group.replace('_', chr(92) + '_')}}}}}")
        cap = (rf"\textbf{{{P}}}: {process(fields)}\\ {{\footnotesize diagram {d['n']} of {len(diags)}"
               + (", p1$\\leftrightarrow$p2 partner " + r["p1p2_partner"] if r["p1p2_partner"] != "symmetric" else
                  ", p1$\\leftrightarrow$p2 symmetric") + "}")
        blocks.append(r"\begin{minipage}[t]{0.48\textwidth}\centering\resizebox{0.95\linewidth}{!}{" + tikz(P, d, fields)
                      + r"}\\[2mm]" + cap + r"\end{minipage}\hfill")
    doc = [r"\documentclass[10pt]{article}", r"\usepackage[a4paper,margin=1.5cm]{geometry}",
           r"\usepackage[compat=1.1.0]{tikz-feynman}", r"\tikzfeynmanset{warn luatex=false, every vertex={font=\small}}", r"\begin{document}",
           r"\section*{Triple-real channels: one representative diagram each}",
           r"QGRAF diagrams (all legs incoming); initial state $p_1, p_2$ on the left, $V$ and the final state "
           r"$r_1, r_2, r_3$ on the right (final-state particles = conjugates of the QGRAF fields). Representative: "
           r"first diagram with only 3-point vertices and $V$ on the $q$ line. Black: $q$, blue: $Q$, "
           r"dotted: ghosts, curly: gluons, wavy: $V$. Arrows: fermion flow.\par\medskip"]
    k = 0
    for b in blocks:
        if b.startswith("\\section"):
            doc.append(("\n\n" if k % 2 else "") + b)
            k = 0
            continue
        doc.append(b + ("\n\n\\bigskip\n" if k % 2 else "%"))
        k += 1
    doc.append(r"\end{document}")
    tex = os.path.join(HERE, "diagrams.tex")
    open(tex, "w").write("\n".join(doc))
    r = subprocess.run(["pdflatex", "-interaction=nonstopmode", "diagrams.tex"], cwd=HERE, capture_output=True, text=True)
    if r.returncode != 0 or not os.path.exists(os.path.join(HERE, "diagrams.pdf")):
        print(r.stdout[-3000:])
        sys.exit("pdflatex failed")
    print(f"{HERE}/diagrams.pdf: {sum(1 for b in blocks if b.startswith(chr(92) + 'begin{minipage'))} channels")


if __name__ == "__main__":
    main(sys.argv[1:])
