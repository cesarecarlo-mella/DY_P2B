"""Numerical check of step 05 (RVV 2L x tree) for one piece of one group pair.

    python3 check05_2l.py <channel dir (<P>_LO)> <piece> <i_j> <PROJ> <Families dir> [seed] [workdir]
    then:  form check.frm   (in workdir; FORMPATH = Code_RVV_2L/FORMroutines)

Before = step-04 piece contracted with L<PROJ> (the same first lines as contractPj): loop propagators named by
l2_dens.inc, the loop-free ones (p1+r1)^2 = 2 p1.r1, (p2+r1)^2 = 2 p2.r1, (p1+p2)^2 = s12; cut propagators (power 1
on both sides) divided out.
After = step-05 result, INT(topoN, 1,1,1, n1..n9) -> prod D_k^-n_k with the family's D's (l2_reconstruct.inc).
Both at a random rational point: z, u, d, m2 = 1, s12 = m2/z, p1.r1, p2.r1 from the cut (as isp_table.inc), and random
values of the 9 loop scalar products k1.k1, k2.k2, k1.k2, k1.p1, k1.p2, k1.r1, k2.p1, k2.p2, k2.r1. Valid pointwise
because step 05 does not shift loop momenta in 2L x tree (the shift is in step 01, before step 04).
FORM prints ~~~IDENTICAL or ~~~DIFFERENT. Exact rational arithmetic.
"""
import os
import random
import re
import sys
from fractions import Fraction as F

CH, COUPL, WHICH, PROJ, FAM = sys.argv[1:6]
seed = int(sys.argv[6]) if len(sys.argv) > 6 else 1
workdir = sys.argv[7] if len(sys.argv) > 7 else "."
CH, FAM = os.path.abspath(CH), os.path.abspath(FAM)
random.seed(seed)
rnd = lambda: F(random.randint(-97, 97) or 1, random.randint(1, 31))
u, z, dval = rnd(), rnd(), rnd()
m2 = F(1)
s12 = m2 / z
sp = {"p1.p2": s12 / 2, "p1.r1": m2 * (u * z - 1) / (2 * z * (1 + u)), "p2.r1": m2 * (z - u) / (2 * z * (1 + u))}
for k in ["k1.k1", "k2.k2", "k1.k2", "k1.p1", "k1.p2", "k1.r1", "k2.p1", "k2.p2", "k2.r1"]:
    sp[k] = rnd()
V = ["k1", "k2", "p1", "p2", "r1"]


def dot(a, b):
    if a == b and a in ("p1", "p2", "r1"):
        return F(0)
    key = f"{a}.{b}" if f"{a}.{b}" in sp else f"{b}.{a}"
    return sp[key]


def sq(mom):
    v = {x: 0 for x in V}
    for m in re.finditer(r"([+-]?)(?:(\d+)\*)?(k1|k2|p1|p2|r1)", mom.replace(" ", "")):
        v[m.group(3)] += (-1 if m.group(1) == "-" else 1) * int(m.group(2) or 1)
    return sum(v[a] * v[b] * dot(a, b) for a in V for b in V if v[a] and v[b])


dens = {}
for line in open(f"{FAM}/fams/l2_dens.inc"):
    m = re.match(r"id Prop\(([^()]+)\) = 1/D(\d+);", line.strip())
    if m:
        dens[int(m.group(2))] = sq(m.group(1))
dmax = max(dens)
fam = {}
for line in open(f"{FAM}/fams/l2_reconstruct.inc"):
    m = re.match(r"id L2F\((\d+)\)\*TOPO\(1\)/DD1/DD2/DD3/(.*) = INT\(topo\d+,", line)
    if m:
        fam[int(m.group(1))] = [int(x) for x in re.findall(r"DD(\d+)\^", m.group(2))]

NUM = [f"id u^n? = ({u})^n;", f"id z^n? = ({z})^n;", f"id d^n? = ({dval})^n;", "id m2^n? = 1;",
       f"id s12^n? = ({s12})^n;", "id Nc^n? = 3^n;", "id [Nc^2-1]^n? = 8^n;", "id Nf^n? = 5^n;", "id NfV^n? = 7^n;",
       "id sqrtzu^n? = (5/7)^n;", "id sqrtziu^n? = (11/13)^n;", "id tag^n? = (17/19)^n;"]
L = ["off statistics;", "#include all_header.h", "#include invariants.h", f"s vD4,...,vD{dmax};",
     f"#include {CH}/tmp/squared_diagrams/{COUPL}/{COUPL}_{WHICH}.inc",
     f"#include {CH}/external/LeptonicCurrents/L{PROJ}.inc",
     f"l Before = [interf{WHICH}]*L{PROJ};",
     f"#include {CH}/tmp/squared_contracted/{COUPL}/unreduced{PROJ}_{WHICH}.ff",
     ".sort", f"Drop [interf{WHICH}], L{PROJ};",
     f"l After = [HLcontracted_{PROJ}_{WHICH}];", ".sort", f"Drop [HLcontracted_{PROJ}_{WHICH}];",
     "id eps(?x) = e_(?x);", ".sort", "contract;", ".sort",
     "if ( expression(Before) );", "argument Prop;", "#call kin4point", "endargument;",
     "#call kin4point", "#call onshell", "#call onshellRadiation", "endif;", ".sort",
     "if ( expression(Before) );", "Factarg Prop;", "id Prop(-1,?x) = Prop(?x);", "id Prop(v?,-1,1) = Prop(v);",
     "id Prop(cut,?a) = 1;", "id Den(cut,?a) = 1;", "id 1/D1 = 1;", "id 1/D2 = 1;", "id 1/D3 = 1;", "endif;", ".sort",
     "if ( expression(Before) );"]
L += [l.strip() for l in open(f"{FAM}/fams/l2_dens.inc") if l.startswith("id Prop(")]
L += ["id Prop(p1+p2) = 1/s12;", "id Prop(p1+r1) = 1/(2*p1.r1);", "id Prop(p2+r1) = 1/(2*p2.r1);", "endif;", ".sort",
      "if ( count(Prop,1) > 0 ) exit \"check05_2l: Prop left in Before\";", ".sort"]
L += [f"id D{k}^n? = vD{k}^n;" for k in range(4, dmax + 1)]
L += ["if ( expression(After) );"]
for n, ks in sorted(fam.items()):
    args = ",".join(f"n{i}?" for i in range(1, 10))
    L.append(f"id INT(topo{n},1,1,1,{args}) = " + "*".join(f"vD{k}^(-n{i})" for i, k in enumerate(ks, 1)) + ";")
L += ["endif;", ".sort", "if ( count(INT,1) > 0 ) exit \"check05_2l: INT with cut indices != 1\";"]
L += [f"id vD{k}^n? = ({dens[k]})^n;" for k in range(4, dmax + 1)]
L += ["id L2F(?a) = 1;"] + [f"id {k}^n? = ({v})^n;" for k, v in sp.items()]
L += NUM + ["argument Num, Den;"] + NUM + ["endargument;", ".sort",
            "id Den(x?number_) = 1/x;", "id Num(x?number_) = x;", ".sort",
            "if ( count(Num,1,Den,1,u,1,z,1,m2,1,s12,1,d,1,Nc,1,L2F,1) != 0 ) exit \"check05_2l: not fully numerical\";",
            ".sort", "l Diff = Before - After;", ".sort",
            "#if termsin(Diff) > 0", "#message ~~~DIFFERENT", "#else", "#message ~~~IDENTICAL", "#endif",
            "b gs;", "print +s Before, After, Diff;", ".end"]
with open(os.path.join(workdir, "check.frm"), "w") as f:
    f.write("\n".join(L) + "\n")
print(f"point (seed {seed}): d={dval} u={u} z={z}")
