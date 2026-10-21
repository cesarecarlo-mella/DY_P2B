#!/usr/bin/env python3
"""Drop the QGRAF diagrams with a closed Quark2 loop and renumber the others (diag1, diag2, ...).

    python3 drop_quark2_loops.py <QGRAF output, e.g. external/Vqqbgg.1.inc>

QGRAF generates every closed quark loop twice, as a Quark and as a Quark2 loop. The closed Quark loop is kept and
stands for any light flavour (spinlines.h: factor Nf, or the couplings gvPS, gaPS if V is on it). A closed Quark2
loop = a set of Quark2 propagators and vertices connected along the fermion flow with no external leg (QGRAF numbers
external fields negatively). The flavour is lost after parser.h / separate_colour.h, so this is done on the QGRAF
output. Rewrites the file; the QGRAF original is kept as <file>.qgraf. Prints kept / dropped.
"""
import collections
import re
import sys

path = sys.argv[1]
txt = open(path).read()
diag = re.compile(r"id diag(\d+) = .*?;", re.S)
blocks = list(diag.finditer(txt))
if not blocks:
    sys.exit(f"{path}: no diagrams")


def closed_quark2_loop(body):
    parent = {}

    def find(x):
        while parent.setdefault(x, x) != x:
            x = parent[x]
        return x

    for a, b in re.findall(r"prop\(Quark2\((-?\d+),(-?\d+),", body):
        parent[find(a)] = find(b)
    for v in re.findall(r"v\d\((.*?)\)\*?\s*(?=v\d\(|;|$)", body.replace("\n", " ")):
        ends = re.findall(r"(?:Qbar2|Quark2)\((-?\d+),", v)
        if len(ends) == 2:
            parent[find(ends[0])] = find(ends[1])
    comps = collections.defaultdict(set)
    for x in list(parent):
        comps[find(x)].add(x)
    return any(all(int(i) > 0 for i in c) for c in comps.values())


keep = [m.group(0) for m in blocks if not closed_quark2_loop(m.group(0))]
head, tail = txt[:blocks[0].start()], txt[blocks[-1].end():]
out = head + "\n".join(re.sub(r"^id diag\d+ =", f"id diag{k} =", b) for k, b in enumerate(keep, 1)) + tail
open(path + ".qgraf", "w").write(txt)
open(path, "w").write(out)
print(f"{path}: kept {len(keep)}, dropped {len(blocks) - len(keep)} (closed Quark2 loop)")
