#!/usr/bin/env python3
"""RV integral families and the step-05 matching files, from the propagator sets of the step-04 output.

    python3 Families/rv_families.py [Families/rv/sets_union.txt]

Input: the union of <P>_LO/tmp/den/sets.txt (Scripts/tools/collect_dens.py) of all channels, one line per set:
"<k1-free props> | <k1 props>   # channels". The k1-free regular propagators (p1+r1)^2, (p2+r1)^2 are constants on
the cut (partial_fraction/partialfraction_1.inc), so only the k1 propagators decide the family.

Family = D1..D3 cuts (r1^2, q^2 - m2, rapidity; positions 1-3, = topo1 of Code_R) and a one-loop box in k1
(positions 4-7): legs q, a, b, c (all incoming, q = -p1-p2-r1), propagators k1, k1+a, k1+a+b, k1+a+b+c. The 4 box
propagators are independent in k1.k1, k1.p1, k1.p2, k1.r1: no irreducible numerator. Global numbering of the
denominators: D1..D3 as in Code_R, D4..D11 = (k1 + S)^2 for the 8 subsets S of {p1, p2, r1}, D(4 + mask), mask bits
p1 = 1, p2 = 2, r1 = 4. Families: greedy cover over the 3 box orderings (legs after q, up to reflection); every loop
part of the data must lie in one box after k1 -> +-k1 + c.

Output (fams/): rv_loopcodes.inc, rv_match_table.inc, rv_shifts.inc, rv_loopdens.inc, rv_isp_table.inc,
rv_isp_apply.inc, rv_reconstruct.inc; rv_families.txt (this folder).
Mathematica (this folder): integralfamilies_r.rv.m ({families as lists of DD[n], DD[n] -> Den[...]} in the FORM
momenta p1, p2, r1, k1, all incoming), rv_topsectors.m ({topoN, {{sector ID, t}, ...}}).
check_rv_families.wl checks them (wolframscript -file Families/check_rv_families.wl).
"""
import collections
import itertools
import os
import re
import sys
from fractions import Fraction

HERE = os.path.dirname(os.path.abspath(__file__))
SETS = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "rv", "sets_union.txt")
FAMS = os.path.join(HERE, "fams")
LEGS = ["p1", "p2", "r1"]
MASK = {"p1": 1, "p2": 2, "r1": 4}
NCUT = 3


# ------------------------------------------------------------------ momenta (basis p1, p2, r1; q eliminated)
def vec(s):
    """'k1+p1-r1' -> (k1 coefficient, (p1, p2, r1) coefficients)"""
    s = s.replace(" ", "").replace("-", "+-")
    k, v = 0, [0, 0, 0]
    for t in filter(None, s.split("+")):
        sg = -1 if t.startswith("-") else 1
        t = t.lstrip("-")
        if t == "k1":
            k += sg
        elif t == "q":
            v = [x - sg for x in v]
        else:
            v[LEGS.index(t)] += sg
    return k, tuple(v)


def text(v, k=0):
    """momentum as FORM text, k1 first"""
    out = ""
    for c, n in [(k, "k1")] + list(zip(v, LEGS)):
        if c:
            out += ("+" if c > 0 else "-") + (f"{abs(c)}*" if abs(c) != 1 else "") + n
    return out.lstrip("+") or "0"


add = lambda a, b: tuple(x + y for x, y in zip(a, b))
neg = lambda a: tuple(-x for x in a)
ZERO = (0, 0, 0)
LEGV = {"p1": (1, 0, 0), "p2": (0, 1, 0), "r1": (0, 0, 1)}

# ------------------------------------------------------------------ boxes
ORD = []                                                         # legs after q, one per reflection class
for perm in itertools.permutations(LEGS):
    if perm[::-1] not in ORD:
        ORD.append(perm)


def offsets(legs):
    out, c = [ZERO], ZERO
    for l in legs:
        c = add(c, LEGV[l])
        out.append(c)
    return out                                                   # P0..P3, P3 = p1+p2+r1 = -q


def find_shift(L, legs):
    """loop part L (offsets P of the propagators k1+P) inside the box: (s, c) with s*P + c in the offsets for all P,
    i.e. k1 -> s*k1 + s*c; None if it does not fit"""
    O = set(offsets(legs))
    L = sorted(L)
    for s in (1, -1):
        sp = [p if s == 1 else neg(p) for p in L]
        for m in sorted(O):
            c = add(m, neg(sp[0]))
            if all(add(x, c) in O for x in sp):
                return s, c
    return None


LIGHT = {v for v in LEGV.values()} | {neg(v) for v in LEGV.values()}


def scaleless(L):
    L = sorted(L)
    return len(L) < 2 or (len(L) == 2 and add(L[1], neg(L[0])) in LIGHT)


# ------------------------------------------------------------------ data
rows = []
for line in open(SETS):
    body = line.split("#")[0]
    rr, lp = body.split("|")
    lstr = tuple(sorted(re.findall(r"Prop\(([^)]*)\)", lp)))
    lvec = []
    for a in lstr:
        k, v = vec(a)
        assert k == 1, a                                         # normalised: k1 with coefficient +1
        lvec.append(v)
    rrp = [x for x in re.findall(r"Prop\(([^)]*)\)", rr) if not x.startswith("cut")]
    assert all(x in ("p1+r1", "p2+r1") for x in rrp), rrp       # constants on the cut (partialfraction_1.inc)
    rows.append((lstr, tuple(lvec)))
LOOPS = {lstr: lvec for lstr, lvec in rows}
items = {lstr for lstr, lvec in rows if not scaleless(lvec)}
print(f"{len(rows)} sets, {len(LOOPS)} loop parts ({sum(scaleless(v) for v in LOOPS.values())} scaleless)")

# ------------------------------------------------------------------ cover
cov = {legs: {it for it in items if find_shift(LOOPS[it], legs) is not None} for legs in ORD}
left, FAMILIES = set(items), []
while left:
    best = max(ORD, key=lambda p: len(cov[p] & left))
    if not cov[best] & left:
        sys.exit(f"{len(left)} loop parts cannot be covered")
    FAMILIES.append(best)
    left -= cov[best]


def loopd(legs):
    return [4 + sum(MASK[l] for l, b in zip(LEGS, P) if b) for P in offsets(legs)]


# ------------------------------------------------------------------ matching table
CODE = {s: 100 + i for i, s in enumerate(sorted({x for l in LOOPS for x in l}, key=lambda s: (len(s), s)))}
SHIFTS, table = {}, {}
for lstr, L in sorted(LOOPS.items()):
    lc = tuple(sorted(CODE[x] for x in lstr))
    if scaleless(L):
        table[lc] = "0"
        continue
    for fi, legs in enumerate(FAMILIES, 1):
        sh = find_shift(L, legs)
        if sh is not None:
            SHIFTS.setdefault(sh, len(SHIFTS) + 1)
            table[lc] = f"RVT({fi})*LSHIFT({SHIFTS[sh]})"
            break
print(f"{len(FAMILIES)} families (box orderings q-{', q-'.join('-'.join(f) for f in FAMILIES)}); {len(table)} table "
      f"entries, {len(SHIFTS)} shifts; all {len(items)} loop parts in the table")


# ------------------------------------------------------------------ loop ISP: k1.k1, k1.p1, k1.p2, k1.r1
def sp_text(a, b):
    if {a, b} == {"p1", "p2"}:
        return "1/2*m2*Den(z)"                                   # p1.p2 = s12/2 = m2/(2z)
    return f"{a}.{b}"


def square(P):
    """P^2 for an offset P (subset sum of distinct massless legs): sum 2 x.y; p1+p2+r1 -> m2 (cut)"""
    ls = [l for l, b in zip(LEGS, P) if b]
    assert all(b in (0, 1) for b in P), P
    if len(ls) == 3:
        return {"m2": Fraction(1)}
    return {sp_text(a, b): Fraction(2) for a, b in itertools.combinations(ls, 2)}


def lin(terms):
    out = ""
    for k, c in terms.items():
        if c == 0:
            continue
        out += ("+" if c > 0 else "-") + (f"{abs(c)}*" if abs(c) != 1 else "") + k
    return out.lstrip("+") or "0"


def loop_isp(legs):
    P, D = offsets(legs), loopd(legs)
    kP = []                                                      # k1.P_i = (D_i - D_0 - P_i^2)/2
    for i in range(4):
        t = collections.Counter()
        if i:
            t[f"DD{D[i]}"] += Fraction(1, 2)
            t[f"DD{D[0]}"] -= Fraction(1, 2)
            for k, c in square(P[i]).items():
                t[k] -= c / 2
        kP.append(t)
    res = {"k1": {f"DD{D[0]}": Fraction(1)}}
    for i, l in enumerate(legs, 1):                              # k1.leg_i = k1.P_i - k1.P_{i-1}
        t = collections.Counter(kP[i])
        for k, c in kP[i - 1].items():
            t[k] -= c
        res[l] = t
    return [lin(res[x]) for x in ("k1", "p1", "p2", "r1")]


# ------------------------------------------------------------------ write
def w(name, s):
    with open(os.path.join(FAMS, name), "w") as fh:
        fh.write(s)


HDR = "* generated by Families/rv_families.py (RV families: cuts D1..D3, loop D4..D11)\n"
w("rv_loopcodes.inc", HDR + "* loop propagators as they come out of step 04 (after the kinematics) -> codes in PropSet\n" +
  "".join(f"if ( match(Prop({s})) ) id PropSet(?a) = PropSet(?a,{c});\n" for s, c in sorted(CODE.items(), key=lambda x: x[1])))
nmax = max(len(k) for k in table)
w("rv_match_table.inc", HDR + "* sorted set of loop codes -> RVT(family)*LSHIFT(shift) (0: scaleless loop)\n" +
  "".join(f"Table sparse, RVM{m}({m});\n" for m in range(1, nmax + 1)) +
  "".join(f"Fill RVM{len(k)}({','.join(map(str, k))}) = {v};\n" for k, v in sorted(table.items())))
w("rv_shifts.inc", HDR + "* k1 -> s*k1 + s*c of the matched family\n" +
  "".join(f"if ( match(LSHIFT({i})) ) multiply replace_(k1, {text(neg(c) if s < 0 else c, s)});\n"
          for (s, c), i in sorted(SHIFTS.items(), key=lambda x: x[1])) + "id LSHIFT(n?) = 1;\n")
w("rv_loopdens.inc", HDR + "".join(
    f"id Prop({text(tuple(1 if MASK[l] & m else 0 for l in LEGS), 1)}) = 1/D{4 + m};\n" for m in range(8)))
isp = HDR + "* LISP(f, j): j = 1..4 -> k1.k1, k1.p1, k1.p2, k1.r1 of family f in its DD's\nTable sparse, LISP(2);\n"
for fi, legs in enumerate(FAMILIES, 1):
    for j, e in enumerate(loop_isp(legs), 1):
        isp += f"Fill LISP({fi},{j}) = {e};\n"
w("rv_isp_table.inc", isp)
app = HDR + "* loop scalar products (one per module), then TOPO(1) for p1.r1, p2.r1 (fams/isp_apply.inc)\n"
for j, s in enumerate(("k1.k1", "k1.p1", "k1.p2", "k1.r1"), 1):
    app += f"id {s}^n1?*RVT(n?) = RVT(n)*LISP(n,{j})^n1;\n.sort\n"
app += ("if ( count(k1.k1,1,k1.p1,1,k1.p2,1,k1.r1,1) != 0 ) exit \"contractPj: k1 scalar product left\";\n"
        "multiply TOPO(1);\n.sort\n")
w("rv_isp_apply.inc", app)
rec = HDR
for fi, legs in enumerate(FAMILIES, 1):
    ds = [f"DD{d}" for d in loopd(legs)]
    pat = "/DD1/DD2/DD3/" + "/".join(f"{d}^n{i}?" for i, d in enumerate(ds, 1))
    rec += f"id RVT({fi})*TOPO(1){pat} = INT(topo{fi},1,1,1,{','.join(f'n{i}' for i in range(1, 5))});\n"
w("rv_reconstruct.inc", rec)
with open(os.path.join(HERE, "rv_families.txt"), "w") as fh:
    fh.write("# RV families (rv_families.py): number, box legs after q, propagators D1..D7\n")
    for fi, legs in enumerate(FAMILIES, 1):
        fh.write(f"topo{fi:<3d} q-{'-'.join(legs)}  D{[1, 2, 3] + loopd(legs)}\n")

# ------------------------------------------------------------------ Mathematica
DDTXT = {1: "Den[r1]", 2: "Den[p1+p2+r1, m2]", 3: "Den[-sp[q, p1] + u*sp[q, p2]]"}
for m in range(8):
    DDTXT[4 + m] = f"Den[{text(tuple(1 if MASK[l] & m else 0 for l in LEGS), 1)}]"
with open(os.path.join(HERE, "integralfamilies_r.rv.m"), "w") as fh:
    fh.write("(* generated by Families/rv_families.py. {families, definitions}: entry N of families = topoN, its 7\n"
             "   propagators in the global numbering DD[1..11] of the FORM code (INT(topoN, n1, ..., n7), n_k = power of\n"
             "   propagator k). Momenta as in FORM: p1, p2, r1, k1 all incoming, q = -p1-p2-r1;\n"
             "   Den[k] = 1/k^2, Den[k, m2] = 1/(k^2 - m2), DD[3] = 1/(-q.p1 + u q.p2) (linear, the rapidity constraint). *)\n{\n{\n")
    fh.write(",\n".join(" {" + ", ".join(f"DD[{d}]" for d in [1, 2, 3] + loopd(legs)) + "}" for legs in FAMILIES)
             + "\n},\n{\n")
    fh.write(",\n".join(f" DD[{d}] -> {DDTXT[d]}" for d in range(1, 12)) + "\n}\n}\n")

# top sectors: every loop part -> its family and its propagators there (after the k1 shift)
SHINV = {i: sc for sc, i in SHIFTS.items()}
SECT = collections.defaultdict(set)
for lstr in items:
    fi, si = map(int, re.match(r"RVT\((\d+)\)\*LSHIFT\((\d+)\)", table[tuple(sorted(CODE[x] for x in lstr))]).groups())
    s, c = SHINV[si]
    dl = []
    for P in LOOPS[lstr]:                                        # k1 + P -> s (k1 + c + s P)
        Q = add(c, P if s == 1 else neg(P))
        assert all(b in (0, 1) for b in Q), Q
        dl.append(4 + sum(MASK[l] for l, b in zip(LEGS, Q) if b))
    fp = [1, 2, 3] + loopd(FAMILIES[fi - 1])
    SECT[fi].add(frozenset(fp.index(d) + 1 for d in [1, 2, 3] + dl))
sid = lambda s: sum(1 << (k - 1) for k in s)
TOPS = {fi: sorted((s for s in SECT[fi] if not any(s < t for t in SECT[fi])), key=lambda s: (-len(s), sorted(s)))
        for fi in range(1, len(FAMILIES) + 1)}
with open(os.path.join(HERE, "rv_topsectors.m"), "w") as fh:
    fh.write("(* generated by Families/rv_families.py: top sectors of the RV families, from the collected sets of all\n"
             "   channels. {topoN, {{sector ID, t}, ...}}: sector ID = sum of 2^(k-1) over its propagators k (order of\n"
             "   integralfamilies_r.rv.m), t = number of propagators *)\n{\n")
    fh.write(",\n".join(f" {{topo{fi}, {{" + ", ".join(f"{{{sid(s)}, {len(s)}}}" for s in TOPS[fi]) + "}}"
                        for fi in range(1, len(FAMILIES) + 1)) + "\n}\n")
print(f"top sectors: {', '.join(f'topo{fi}: ' + ' '.join(str(sid(s)) for s in TOPS[fi]) for fi in TOPS)}")
print("written fams/rv_*.inc, rv_families.txt, integralfamilies_r.rv.m, rv_topsectors.m")
