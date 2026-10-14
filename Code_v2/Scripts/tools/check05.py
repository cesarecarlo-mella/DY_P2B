"""Numerical check of step 05 for one piece of one group pair.

    python3 check05.py <channel dir (<P>_LO)> <piece> <i_j> <PROJ> <Families dir> [seed] [workdir]
    then:  form check.frm   (in workdir; needs FORMPATH = Code_v2/FORMroutines)

Before = step-04 piece contracted with L<PROJ> (same first lines as contractPj), propagators named by dens.inc only,
After  = step-05 result, INT(topoN, 1,1,1,1,1, n...) -> prod DD_k^-n_k with the family's DD's (from reconstruct.inc),
both evaluated at a random rational point ON the cut surface (r_i^2 = 0, q^2 = m2 = 1, -q.p1 + u q.p2 = 0; the cut
propagators appear with power 1 on both sides and are divided out; d, u, z, Nc (= 3), [Nc^2-1] (= 8), sqrtzu, sqrtziu,
tag numerical). FORM prints ~~~IDENTICAL or ~~~DIFFERENT, and the exact values of Before and After (only gs and the
couplings stay symbolic). Exact rational arithmetic, no rounding.
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
sp = {k: rnd() for k in ["r1.r2", "r1.r3", "p1.r1", "p1.r2", "p2.r1", "p2.r2", "p1.r3"]}
# rapidity: -q.p1 + u q.p2 = 0 with q = -(p1+p2+R):  (p1.p2 + p1.R) - u (p1.p2 + p2.R) = 0  -> p2.r3
p1R = sp["p1.r1"] + sp["p1.r2"] + sp["p1.r3"]
p2R = (s12 / 2 + p1R) / u - s12 / 2
sp["p2.r3"] = p2R - sp["p2.r1"] - sp["p2.r2"]
# q^2 = s12 + 2 (p1+p2).R + 2 (r1.r2 + r1.r3 + r2.r3) = m2  -> r2.r3
sp["r2.r3"] = (m2 - s12 - 2 * (p1R + p2R)) / 2 - sp["r1.r2"] - sp["r1.r3"]


def dot(a, b):
    if a > b:
        a, b = b, a
    if a == b:
        return F(0)
    if (a, b) == ("p1", "p2"):
        return s12 / 2
    return sp[f"{a}.{b}"]


def sq(mom):
    vs = mom.replace(" ", "").split("+")
    return sum(dot(a, b) for a in vs for b in vs)


dens = {}          # numerical D_k, k = 6..29, from dens.inc
for line in open(f"{FAM}/fams/dens.inc"):
    m = re.match(r"id Prop\(([^,()]+)\) = 1/D(\d+);", line.strip())
    if m:
        dens[int(m.group(2))] = sq(m.group(1))
assert sorted(dens) == list(range(6, 30)), sorted(dens)
fam = {}           # family -> its 7 regular DD's in INT order, from reconstruct.inc
for line in open(f"{FAM}/fams/reconstruct.inc"):
    m = re.match(r"id TOPO\((\d+)\)/DD1/DD2/DD3/DD4/DD5/(.*) = INT\(topo\d+,", line)
    if m:
        fam[int(m.group(1))] = [int(x) for x in re.findall(r"DD(\d+)\^", m.group(2))]

NUM = [f"id u^n? = ({u})^n;", f"id z^n? = ({z})^n;", f"id d^n? = ({dval})^n;", "id m2^n? = 1;",
       f"id s12^n? = ({s12})^n;", "id Nc^n? = 3^n;", "id [Nc^2-1]^n? = 8^n;", "id sqrtzu^n? = (5/7)^n;",
       "id sqrtziu^n? = (11/13)^n;", "id tag^n? = (17/19)^n;"]
L = ["off statistics;", "#include all_header.h", "#include invariants.h", "s vD6,...,vD29;",
     f"#include {CH}/tmp/squared_diagrams/{COUPL}/{COUPL}_{WHICH}.inc",
     f"#include {CH}/external/LeptonicCurrents/L{PROJ}.inc",
     f"l Before = [interf{WHICH}]*L{PROJ};",
     f"#include {CH}/tmp/squared_contracted/{COUPL}/unreduced{PROJ}_{WHICH}.ff",
     ".sort", f"Drop [interf{WHICH}], L{PROJ};",
     f"l After = [HLcontracted_{PROJ}_{WHICH}];", ".sort", f"Drop [HLcontracted_{PROJ}_{WHICH}];",
     "id eps(?x) = e_(?x);", ".sort", "contract;", ".sort",
     "if ( expression(Before) );", "argument Prop;", "#call kin6point", "endargument;",
     "#call kin6point", "#call onshell", "#call onshellRadiation", "endif;", ".sort",
     "if ( expression(Before) );", "Factarg Prop;", "id Prop(-1,?x) = Prop(?x);",
     "id Prop(cut,?a) = 1;", "id Den(cut,?a) = 1;", "endif;", ".sort",
     "if ( expression(Before) );"]
L += [l.strip() for l in open(f"{FAM}/fams/dens.inc") if l.startswith("id Prop(") and "cut" not in l]
L += ["id Prop(p1+p2) = 1/s12;", "endif;", ".sort",
      "if ( count(Prop,1) > 0 ) exit \"check05: Prop left in Before\";"]
L += [f"id D{k}^n? = vD{k}^n;" for k in range(6, 30)]
L += ["if ( expression(After) );"]
for n, ks in sorted(fam.items()):
    args = ",".join(f"n{i}?" for i in range(1, 8))
    L.append(f"id INT(topo{n},1,1,1,1,1,{args}) = " + "*".join(f"vD{k}^(-n{i})" for i, k in enumerate(ks, 1)) + ";")
L += ["endif;", ".sort", "if ( count(INT,1) > 0 ) exit \"check05: INT with cut indices != 1\";"]
L += [f"id vD{k}^n? = ({dens[k]})^n;" for k in range(6, 30)]
L += [f"id {k} = {v};" for k, v in sp.items()]
L += NUM + ["argument Num, Den;"] + NUM + ["endargument;", ".sort",
            "id Den(x?number_) = 1/x;", "id Num(x?number_) = x;", ".sort",
            "if ( count(Num,1,Den,1,u,1,z,1,m2,1,s12,1,d,1,Nc,1) != 0 ) exit \"check05: not fully numerical\";",
            ".sort", "l Diff = Before - After;", ".sort",
            "#if termsin(Diff) > 0", "#message DIFFERENT", "#else", "#message IDENTICAL", "#endif",
            "b gs, gv, cgv, ga, cga, Gv, cGv, Ga, cGa;", "print +s Before, After, Diff;", ".end"]
with open(os.path.join(workdir, "check.frm"), "w") as f:
    f.write("\n".join(L) + "\n")
print(f"point (seed {seed}): d={dval} u={u} z={z} " + " ".join(f"{k}={v}" for k, v in sp.items()))
