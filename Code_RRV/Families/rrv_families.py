#!/usr/bin/env python3
"""RRV integral families and the step-05 matching files, from the propagator sets of the step-04 output.

    python3 Families/rrv_families.py [Families/rrv/sets_union.txt]

Input: the union of <P>_LO/tmp/den/sets.txt (Scripts/tools/collect_dens.py) of all channels, one line per set:
"<k1-free props> | <k1 props>   # channels". RR machinery (this folder, = Code_RR/Families): partial_fraction/,
fams/dens.inc, fams/fammatch.inc, fams/isp_table.inc.

Family = D1..D4 cuts (r1^2, r2^2, q^2 - m2, rapidity; positions 1-4), the 3 regular propagators of an RR family
(positions 5-7), a one-loop pentagon in k1 (positions 8-12): legs q, a, b, c, d (all incoming, q = -p1-p2-r1-r2),
propagators k1, k1+a, k1+a+b, k1+a+b+c, k1+a+b+c+d. Global numbering of the denominators: D1..D13 as in RR,
D14..D29 = (k1 + S)^2 for the 16 subsets S of {p1, p2, r1, r2}, D(14 + mask), mask bits p1 = 1, p2 = 2, r1 = 4, r2 = 8.

Choice: every (partial-fraction term, loop part) of the data must lie in one family (RR set within the family's RR
propagators, loop part within the pentagon after k1 -> +-k1 + c). Families = greedy cover over (independent RR
family, pentagon ordering), each item allowed directly or through r1 <-> r2. The r1 <-> r2 images of the chosen
families are added as dependent families (numbered after the independent ones), mapped back at the INT level
(fams/symm_loop_crossings.inc: same indices, the crossed family's propagators are the images of its partner's).

Output (fams/): rrv_loopcodes.inc, rrv_match_table.inc, rrv_shifts.inc, rrv_loopdens.inc, rrv_isp_table.inc,
rrv_isp_apply.inc, rrv_reconstruct.inc, symm_loop_crossings.inc; rrv_families.txt (this folder).
Mathematica (this folder, format of integralfamilies.rr.m: sp[a,b] = a.b, p1, p2 incoming, p1^2 = p2^2 = 0,
s12 = m2/z, p4 = -r1, p5 = -r2, p6 = -k1): integralfamilies.rrv.m (entry N = topoN, its 12 propagators D1..D12, the
power n_k of INT(topoN, n1, ..., n12) is on propagator k), denominators.rrv.m (global D1..D29 of the FORM code),
relabelling_momenta.rrv.m ({A, rule, B}: family A with the rule applied is family B, propagator by propagator).
check_rrv_families.wl checks them (wolframscript -file Families/check_rrv_families.wl).
"""
import collections
import glob
import itertools
import os
import re
import sys
from fractions import Fraction

HERE = os.path.dirname(os.path.abspath(__file__))
SETS = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, "rrv", "sets_union.txt")
FAMS = os.path.join(HERE, "fams")
LEGS = ["p1", "p2", "r1", "r2"]
MASK = {"p1": 1, "p2": 2, "r1": 4, "r2": 8}
SWAP_D = {1: 2, 2: 1, 5: 7, 7: 5, 6: 8, 8: 6, 12: 13, 13: 12}          # r1 <-> r2 on D1..D13
INDEP_RR = set(range(1, 35)) | {45}


# ------------------------------------------------------------------ momenta (basis p1, p2, r1, r2; q eliminated)
def vec(s):
    """'k1+p1-r2' -> (k1 coefficient, (p1, p2, r1, r2) coefficients)"""
    s = s.replace(" ", "").replace("-", "+-")
    k, v = 0, [0, 0, 0, 0]
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
swapv = lambda a: (a[0], a[1], a[3], a[2])
ZERO = (0, 0, 0, 0)
LEGV = {"p1": (1, 0, 0, 0), "p2": (0, 1, 0, 0), "r1": (0, 0, 1, 0), "r2": (0, 0, 0, 1)}


def canon_rr(s):
    """RR propagator momentum, sign dropped, terms in the order p1, p2, r1, r2"""
    k, v = vec(s)
    assert k == 0, s
    if next(x for x in v if x) < 0:
        v = neg(v)
    return text(v)


# ------------------------------------------------------------------ RR machinery
def read_pf():
    out = []
    n = len(glob.glob(os.path.join(HERE, "partial_fraction", "partialfraction_*.inc")))
    for i in range(1, n + 1):
        t = open(os.path.join(HERE, "partial_fraction", f"partialfraction_{i}.inc")).read()
        ids = re.findall(r"^id\s+(.*?)\s*=\s*(.*?);\s*$", t, re.M | re.S)
        assert len(ids) == 1, i
        lhs = frozenset(canon_rr(x) for x in re.findall(r"Prop\(([^)]*)\)", ids[0][0]))
        rhs, depth, st, r = [], 0, 0, ids[0][1].replace(" ", "").replace("\n", "")
        for j, c in enumerate(r):
            depth += (c == "(") - (c == ")")
            if c in "+-" and depth == 0 and j > st and r[j - 1] not in "^*/(,":
                rhs.append(r[st:j])
                st = j
        rhs.append(r[st:])
        out.append((lhs, [frozenset(canon_rr(x) for x in re.findall(r"Prop\(([^)]*)\)", t)) for t in rhs]))
    return out


PF = read_pf()


def pf(S):
    """final propagator sets of a term, as FORM's partial-fraction module does it (outer repeat over the files
    1..NPF, each file a repeat of its one identity; the children of a split stay in the inner repeat)"""
    def step(S, i, matched):
        if i == len(PF):
            return step(S, 0, False) if matched else {S}
        lhs, rhs = PF[i]
        if lhs <= S:
            out = set()
            for t in rhs:
                out |= step((S - lhs) | t, i, True)
            return out
        return step(S, i + 1, matched)
    return step(frozenset(S), 0, False)


DEN = {}
for m in re.finditer(r"id Prop\(([^,)]*)\) = 1/D(\d+);", open(os.path.join(FAMS, "dens.inc")).read()):
    DEN[canon_rr(m.group(1))] = int(m.group(2))
RRSET = {}                                                       # RR family -> its regular D's, in order
for m in re.finditer(r"^id (.*?) = TOPO\((\d+)\)", open(os.path.join(FAMS, "fammatch.inc")).read(), re.M):
    ds = [int(x) for x in re.findall(r"D(\d+)\^", m.group(1))]
    if len(ds) == 3:
        RRSET.setdefault(int(m.group(2)), tuple(ds))
BYSET = {frozenset(v): f for f, v in RRSET.items()}

# ------------------------------------------------------------------ pentagons
ORD = []                                                         # legs after q, one per reflection class
for perm in itertools.permutations(LEGS):
    if perm[::-1] not in ORD:
        ORD.append(perm)


def offsets(legs):
    out, c = [ZERO], ZERO
    for l in legs:
        c = add(c, LEGV[l])
        out.append(c)
    return out                                                   # P0..P4, P4 = p1+p2+r1+r2


def find_shift(L, legs):
    """loop part L (offsets P of the propagators k1+P) inside the pentagon: (s, c) with s*P + c in the offsets for
    all P, i.e. k1 -> s*k1 + s*c; None if it does not fit"""
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
    rrp = frozenset(canon_rr(x) for x in re.findall(r"Prop\(([^)]*)\)", rr) if not x.startswith("cut"))
    rows.append((rrp, lstr, tuple(lvec)))
LOOPS = {}                                                       # loop part (strings) -> offsets
for _, lstr, lvec in rows:
    LOOPS[lstr] = lvec
items = set()                                                    # (RR D-set after PF, loop strings)
for rrp, lstr, lvec in rows:
    if scaleless(lvec):
        continue
    for S in pf(rrp):
        items.add((frozenset(DEN[x] for x in S), lstr))
print(f"{len(rows)} sets, {len(LOOPS)} loop parts ({sum(scaleless(v) for v in LOOPS.values())} scaleless), "
      f"{len(items)} (partial-fraction term, loop part) items")


# ------------------------------------------------------------------ cover
def swap_item(D, lstr):
    return frozenset(SWAP_D.get(d, d) for d in D), tuple(sorted(set(swapv(v) for v in LOOPS[lstr])))


def covers(fam, D, L):
    F, legs = fam
    return D <= set(RRSET[F]) and find_shift(L, legs) is not None


pairs = [(F, legs) for F in sorted(RRSET) if F in INDEP_RR for legs in ORD]
cov = {}
for p in pairs:
    cov[p] = {it for it in items if covers(p, it[0], LOOPS[it[1]]) or covers(p, *swap_item(*it))}
left, chosen = set(items), []
while left:
    best = max(pairs, key=lambda p: len(cov[p] & left))
    if not cov[best] & left:
        sys.exit(f"{len(left)} items cannot be covered")
    chosen.append(best)
    left -= cov[best]

# families: chosen (independent) + their r1 <-> r2 images
FAMILIES = []                                                    # dicts: rr (F), rrd (D's in order), legs, cuts
for F, legs in chosen:
    FAMILIES.append(dict(rr=F, rrd=RRSET[F], legs=legs, cuts=(1, 2, 3, 4), partner=None))
NIND = len(FAMILIES)
for i, f in enumerate(FAMILIES[:NIND]):
    rrd = tuple(SWAP_D.get(d, d) for d in f["rrd"])
    F2 = BYSET.get(frozenset(rrd))
    if F2 is None:
        sys.exit(f"r1<->r2 image of RR family {f['rr']} {f['rrd']} is not an RR family")
    legs = tuple({"r1": "r2", "r2": "r1"}.get(l, l) for l in f["legs"])
    FAMILIES.append(dict(rr=F2, rrd=rrd, legs=legs, cuts=(2, 1, 3, 4), partner=i + 1))


def loopd(legs):
    return [14 + sum(MASK[l] for l, b in zip(LEGS, P) if b) for P in offsets(legs)]


# ------------------------------------------------------------------ matching table
CODE = {s: 100 + i for i, s in enumerate(sorted({x for l in LOOPS for x in l}, key=lambda s: (len(s), s)))}
SHIFTS, table = {}, {}


def shift_id(s, c):
    key = (s, c)
    if key not in SHIFTS:
        SHIFTS[key] = len(SHIFTS) + 1
    return SHIFTS[key]


for lstr, L in sorted(LOOPS.items()):
    lc = tuple(sorted(CODE[x] for x in lstr))
    if scaleless(L):
        for n in range(0, 4):
            for R in itertools.combinations(range(5, 14), n):
                table[R + lc] = "0"
        continue
    for fi, f in enumerate(FAMILIES, 1):
        sh = find_shift(L, f["legs"])
        if sh is None:
            continue
        for n in range(0, 4):
            for R in itertools.combinations(sorted(f["rrd"]), n):
                key = R + lc
                if key not in table:
                    table[key] = f"RRVT({fi})*LSHIFT({shift_id(*sh)})"
miss = [it for it in items if tuple(sorted(it[0])) + tuple(sorted(CODE[x] for x in it[1])) not in table]
if miss:
    sys.exit(f"{len(miss)} data items not in the table, e.g. {miss[:3]}")
print(f"{NIND} independent families + {len(FAMILIES) - NIND} r1<->r2 images; {len(table)} table entries, "
      f"{len(SHIFTS)} shifts; all {len(items)} data items in the table")


# ------------------------------------------------------------------ loop ISP: k1.k1, k1.p1, k1.p2, k1.r1, k1.r2
def sp_text(a, b):
    if {a, b} == {"p1", "p2"}:
        return "1/2*m2*Den(z)"                                   # p1.p2 = s12/2 = m2/(2z)
    return f"{a}.{b}"


def square(P):
    """P^2 for an offset P (subset sum of distinct massless legs): sum 2 x.y; p1+p2+r1+r2 -> m2 (cut)"""
    ls = [l for l, b in zip(LEGS, P) if b]
    assert all(b in (0, 1) for b in P), P
    if len(ls) == 4:
        return {"m2": Fraction(1)}
    return {sp_text(a, b): Fraction(2) for a, b in itertools.combinations(ls, 2)}


def lin(terms):
    out = ""
    for k, c in terms.items():
        if c == 0:
            continue
        cs = ("+" if c > 0 else "-") + (f"{abs(c)}*" if abs(c) != 1 else "")
        out += cs + k
    return out.lstrip("+") or "0"


def loop_isp(f):
    P = offsets(f["legs"])
    D = loopd(f["legs"])
    kP = []                                                      # k1.P_i = (D_i - D_0 - P_i^2)/2
    for i in range(5):
        t = collections.Counter()
        if i:
            t[f"DD{D[i]}"] += Fraction(1, 2)
            t[f"DD{D[0]}"] -= Fraction(1, 2)
            for k, c in square(P[i]).items():
                t[k] -= c / 2
        kP.append(t)
    res = {"k1": {f"DD{D[0]}": Fraction(1)}}
    for i, l in enumerate(f["legs"], 1):                         # k1.leg_i = k1.P_i - k1.P_{i-1}
        t = collections.Counter(kP[i])
        for k, c in kP[i - 1].items():
            t[k] -= c
        res[l] = t
    return [lin(res[x]) for x in ("k1", "p1", "p2", "r1", "r2")]


# ------------------------------------------------------------------ write
def w(name, s):
    with open(os.path.join(FAMS, name), "w") as fh:
        fh.write(s)


HDR = "* generated by Families/rrv_families.py (RRV families: cuts D1..D4, RR D5..D13, loop D14..D29)\n"
w("rrv_loopcodes.inc", HDR + "* loop propagators as they come out of step 04 (after the kinematics) -> codes in PropSet\n" +
  "".join(f"if ( match(Prop({s})) ) id PropSet(?a) = PropSet(?a,{c});\n" for s, c in sorted(CODE.items(), key=lambda x: x[1])))
nmax = max(len(k) for k in table)
w("rrv_match_table.inc", HDR + "* sorted set (RR D's, loop codes) -> RRVT(family)*LSHIFT(shift) (0: scaleless loop)\n" +
  "".join(f"Table sparse, RRVM{m}({m});\n" for m in range(1, nmax + 1)) +
  "".join(f"Fill RRVM{len(k)}({','.join(map(str, k))}) = {v};\n" for k, v in sorted(table.items())))
w("rrv_shifts.inc", HDR + "* k1 -> s*k1 + s*c of the matched family\n" +
  "".join(f"if ( match(LSHIFT({i})) ) multiply replace_(k1, {text(neg(c) if s < 0 else c, s)});\n"
          for (s, c), i in sorted(SHIFTS.items(), key=lambda x: x[1])) + "id LSHIFT(n?) = 1;\n")
w("rrv_loopdens.inc", HDR + "".join(
    f"id Prop({text(tuple(1 if MASK[l] & m else 0 for l in LEGS), 1)}) = 1/D{14 + m};\n" for m in range(16)))
isp = HDR + "* LISP(f, j): j = 1..5 -> k1.k1, k1.p1, k1.p2, k1.r1, k1.r2 of family f in its DD's (then RR ISP via RRF(f))\n"
isp += "Table sparse, LISP(2);\nTable sparse, RRF(1);\n"
for fi, f in enumerate(FAMILIES, 1):
    for j, e in enumerate(loop_isp(f), 1):
        isp += f"Fill LISP({fi},{j}) = {e};\n"
    isp += f"Fill RRF({fi}) = {f['rr']};\n"
w("rrv_isp_table.inc", isp)
app = HDR + "* loop scalar products (one per module), then the RR family tag for the RR ISP (fams/isp_apply.inc)\n"
for j, s in enumerate(("k1.k1", "k1.p1", "k1.p2", "k1.r1", "k1.r2"), 1):
    app += f"id {s}^n1?*RRVT(n?) = RRVT(n)*LISP(n,{j})^n1;\n.sort\n"
app += ("if ( count(k1.k1,1,k1.p1,1,k1.p2,1,k1.r1,1,k1.r2,1) != 0 ) exit \"contractPj: k1 scalar product left\";\n"
        "id RRVT(n?) = RRVT(n)*TOPO(RRF(n));\n.sort\n")
w("rrv_isp_apply.inc", app)
rec = HDR
for fi, f in enumerate(FAMILIES, 1):
    ds = [f"DD{d}" for d in list(f["cuts"]) + list(f["rrd"]) + loopd(f["legs"])]
    pat = "/".join(ds[:4]) + "/" + "/".join(f"{d}^n{i}?" for i, d in enumerate(ds[4:], 1))
    rec += f"id RRVT({fi})*TOPO({f['rr']})/{pat} = INT(topo{fi},1,1,1,1,{','.join(f'n{i}' for i in range(1, 9))});\n"
w("rrv_reconstruct.inc", rec)
w("symm_loop_crossings.inc", HDR + "* r1 <-> r2 images -> their partners (same indices)\n" + "".join(
    f"id INT(topo{fi},1,1,1,1,{','.join(f'n{i}?' for i in range(1, 9))}) = INT(topo{f['partner']},1,1,1,1,"
    f"{','.join(f'n{i}' for i in range(1, 9))});\n" for fi, f in enumerate(FAMILIES, 1) if f["partner"]))
with open(os.path.join(HERE, "rrv_families.txt"), "w") as fh:
    fh.write("# RRV families (rrv_families.py): number, RR family, pentagon legs after q, propagators D1..D12\n")
    for fi, f in enumerate(FAMILIES, 1):
        P = offsets(f["legs"])
        ds = list(f["cuts"]) + list(f["rrd"]) + loopd(f["legs"])
        fh.write(f"topo{fi:<4d} RR {f['rr']:2d}  q-{'-'.join(f['legs'])}  D{ds}"
                 + (f"  = r1<->r2 image of topo{f['partner']}" if f["partner"] else "") + "\n")


# ------------------------------------------------------------------ Mathematica (sp[a, b], p4 = -r1, p5 = -r2, p6 = -k1)
MB = ["p1", "p2", "p4", "p5", "p6"]


def mvec(k, v):
    """FORM momentum (k1 coefficient, (p1, p2, r1, r2)) -> coefficients of p1, p2, p4, p5, p6"""
    return (v[0], v[1], -v[2], -v[3], -k)


def mdot(a, b):
    """a.b as {monomial: coefficient}; p1^2 = p2^2 = 0, p1.p2 = m2/(2 z)"""
    out = collections.Counter()
    for i, j in itertools.product(range(5), repeat=2):
        c = Fraction(a[i] * b[j])
        if not c:
            continue
        x, y = sorted((i, j))
        if (x, y) in ((0, 0), (1, 1)):
            continue
        out["m2/z" if (x, y) == (0, 1) else f"sp[{MB[x]}, {MB[y]}]"] += c / 2 if (x, y) == (0, 1) else c
    return out


def mexpr(terms):
    out = ""
    for k, c in sorted(terms.items(), key=lambda x: (not x[0].startswith("m2"), x[0])):
        if c == 0:
            continue
        cs = ("+ " if c > 0 else "- ") + (f"{abs(c)}*" if abs(c) != 1 else "")
        out += " " + cs + k
    out = out.strip()
    return (out[2:] if out.startswith("+ ") else "-" + out[2:]) if out else "0"


QV = mvec(0, (-1, -1, -1, -1))                                   # q = -p1-p2-r1-r2 (FORM, all incoming)
P1V, P2V = mvec(0, (1, 0, 0, 0)), mvec(0, (0, 1, 0, 0))
MD = {1: mexpr(mdot(mvec(0, LEGV["r1"]), mvec(0, LEGV["r1"]))),
      2: mexpr(mdot(mvec(0, LEGV["r2"]), mvec(0, LEGV["r2"])))}
t3 = mdot(QV, QV)
t3["m2"] -= 1
MD[3] = mexpr(t3)
t4 = collections.Counter({k: -c for k, c in mdot(QV, P1V).items()})
for k, c in mdot(QV, P2V).items():
    t4["u*" + k] += c
MD[4] = mexpr(t4).replace("u*m2/z", "m2*u/z")
for s, d in DEN.items():
    if d > 4:
        MD[d] = mexpr(mdot(*[mvec(*vec(s))] * 2))
for m in range(16):
    P = mvec(1, tuple(1 if MASK[l] & m else 0 for l in LEGS))
    MD[14 + m] = mexpr(mdot(P, P))
assert sorted(MD) == list(range(1, 30)), sorted(MD)
MHDR = ("(* generated by Families/rrv_families.py. sp[a,b] = a.b, p1, p2 incoming, p1^2 = p2^2 = 0, s12 = m2/z,\n"
        "   p4 = -r1, p5 = -r2, p6 = -k1 (FORM momenta r1, r2, k1). *)\n")
with open(os.path.join(HERE, "denominators.rrv.m"), "w") as fh:
    fh.write(MHDR + "(* den[n] = global denominator Dn of the FORM code (Families/fams/dens.inc, rrv_loopdens.inc) *)\n{\n"
             + ",\n".join(f" den[{d}] -> {MD[d]}" for d in range(1, 30)) + "\n}\n")
with open(os.path.join(HERE, "integralfamilies.rrv.m"), "w") as fh:
    fh.write(MHDR + "(* entry N = topoN: propagators 1-4 cut, 5-7 of an RR family, 8-12 the k1 pentagon;"
             " INT(topoN, n1, ..., n12), n_k = power of propagator k *)\n{\n")
    fh.write(",\n".join(" {" + ", ".join(MD[d] for d in list(f["cuts"]) + list(f["rrd"]) + loopd(f["legs"])) + "}"
                         for f in FAMILIES) + "\n}\n")
with open(os.path.join(HERE, "relabelling_momenta.rrv.m"), "w") as fh:
    fh.write(MHDR + "(* {A, rule, B}: propagator k of family A with the rule applied = propagator k of family B"
             " (INT[topoA, n1, ..., n12] = INT[topoB, n1, ..., n12]) *)\n{\n")
    fh.write(",\n".join(f" {{{fi}, {{p4 -> p5, p5 -> p4}}, {f['partner']}}}"
                         for fi, f in enumerate(FAMILIES, 1) if f["partner"]) + "\n}\n")
print("written fams/rrv_*.inc, fams/symm_loop_crossings.inc, rrv_families.txt, *.rrv.m")
