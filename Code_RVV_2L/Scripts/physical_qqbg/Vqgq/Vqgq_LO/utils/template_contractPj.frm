
off statistics;
#-
#include all_header.h
#include ../../process_header.h
#include invariants.h
* numerators of the families as a table ISP(family, scalar product), FAMDIR/isp_table.py
#include 'FAMDIR'/fams/isp_table.inc
* RVV 2L x tree: loop scalar products of the 12 two-loop families (FAMDIR/rvv2l_families.py)
#include 'FAMDIR'/fams/l2_isp_table.inc

* Code_RVV_2L (two loops k1, k2 x tree, one emission r1; cut D1..D3 = r1^2, q^2 - m2, rapidity; the loop-free
* regular propagators are constants on the cut, everything is fixed by z, u; loop D4..'L2DMAX' = the propagators
* of the families PL, NPL and crossings, rvv2l_families.py; the family of each term is its tag L2F(f)).
* Step 05, one job: piece COUPL (vv, va, ..., a2a2) of the group pair WHICH (= i_j) of step 04, contracted with the
* leptonic projector L'PROJ', then partial fractions, families and integrals.
* Defines (from utils/05_run_contractPj.py): COUPL, WHICH, PROJ, FAMDIR (Code_v2/Families), NPF (partial-fraction
* sets), DEBUG (> 0: also write the intermediate expressions).

#include ../../tmp/squared_diagrams/'COUPL'/'COUPL'_'WHICH'.inc

#message contract with leptonic tensor ('time_' s)
#include ../../external/LeptonicCurrents/L'PROJ'.inc
l HLcontracted = [interf'WHICH']*L'PROJ';
.sort
Drop;
NDrop HLcontracted;

id eps(?x) = e_(?x);
.sort
contract;
.sort
if ( count(e_,1) != 0 ) exit "contractPj: Levi-Civita left after the contraction";

#message I contracted with projector and sorted now. ('time_' s)
#if 'DEBUG' > 0
#write <../../tmp/squared_contracted/'COUPL'/HLcontracted'PROJ'_'WHICH'.ff> "id HLcontracted = %e" HLcontracted;
#endif

* Kinematics. Propagators: q eliminated inside the arguments, overall sign of the momentum dropped (Prop = 1/k^2),
* which gives the same form as in FAMDIR/fams/dens.inc and the partial-fraction identities.
argument Prop;
#call kin4point
endargument;
#call kin4point
#call onshell
#call onshellRadiation
.sort
Factarg Prop;
id Prop(-1,?x) = Prop(?x);
* a single momentum: Factarg gives Prop(-k1) -> Prop(k1,-1,1)
id Prop(v?,-1,1) = Prop(v);
.sort
* s-channel gluon (q qb -> g* -> Q Qb ...): constant propagator 1/s12 = z/m2 (not a family propagator)
id Prop(p1+p2) = Num(z)/m2;

repeat;
id s12^(n1?) = (m2)^n1*Den(z^(n1));
id s12 = m2*Den(z);
endrepeat;
.sort

#message Kinematics and sort again. Next: partial fraction ('time_' s)
* One repeat around all sets: an identity can recreate the pattern of an earlier one. Each identity removes one of
* the distinct propagators of a term (the zero-constant ones square the highest DD), so this terminates.
repeat;
#do i=1,'NPF'
#include 'FAMDIR'/partial_fraction/partialfraction_'i'.inc
#enddo
endrepeat;
id Den(2)=1/2;
.sort

#message Done with partial fraction. Next: recognize all dens ('time_' s)
#include 'FAMDIR'/fams/dens.inc
.sort
if ( match(Den(cut,?a)) ) exit "contractPj: cut denominator not in dens.inc";
id Den(2)=1/2;
.sort

#message families of the two-loop diagrams ('time_' s)
* every term carries the family tag L2F(f) of its two-loop diagram, which was shifted onto family f in step 01
* (Families/rvv2l_shifts.py, Reduze find_diagram_shifts): no matching here; the kinematics again (signs inside Prop)
if ( count(L2F,1) != 1 ) exit "contractPj: term without exactly one family tag L2F";
.sort
#call kin4point
#call onshell
#call onshellRadiation
Factarg Prop;
id Prop(-1,?x) = Prop(?x);
id Prop(v?,-1,1) = Prop(v);
repeat;
id s12^(n1?) = (m2)^n1*Den(z^(n1));
id s12 = m2*Den(z);
endrepeat;
.sort
#include 'FAMDIR'/fams/l2_dens.inc
.sort
if ( count(Prop,1) > 0 ) exit "contractPj: propagator not in dens.inc / l2_dens.inc";
#do k=4,'L2DMAX'
id D'k'^n? = DD'k'^n;
#enddo
id 1/D1 = 1/DD1;
id 1/D2 = 1/DD2;
id 1/D3 = 1/DD3;
.sort

#message ISP ('time_' s)
* loop scalar products (k1.x, k2.x, k1.k2) in the DD's of the family L2F(f), then p1.r1, p2.r1 (constants on the
* cut, topo1 of Code_R: isp_table.inc)
#include 'FAMDIR'/fams/l2_isp_apply.inc
#include 'FAMDIR'/fams/isp_apply.inc

id m2^n? = 1;
argument Num, Den;
id m2^n? = 1;
endargument;
.sort
id Den(2) = 1/2;
id Den(2*z) = 1/2*Den(z);
id Num(2*u*z) = 2*Num(u*z);
.sort

#if 'DEBUG' > 0
#define DDLIST "DD1"
#do k=2,'L2DMAX'
#redefine DDLIST "'DDLIST',DD'k'"
#enddo
b L2F,TOPO,[Nc^2-1],INT,'DDLIST',gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc, NfV;
.sort
#write <../../tmp/squared_contracted/'COUPL'/HLcontracted'PROJ'_'WHICH'_matched.ff> "l  HLcontracted = %e" HLcontracted;
#endif

#message reconstruct ints ('time_' s)
#include 'FAMDIR'/fams/l2_reconstruct.inc
.sort
if ( count(TOPO,1,L2F,1) != 0 ) exit "contractPj: TOPO/L2F left after l2_reconstruct.inc";
#do k=1,'L2DMAX'
if ( count(DD'k',1) != 0 ) exit "contractPj: DD'k' left after l2_reconstruct.inc";
#enddo
.sort

#message rational simplification ('time_' s)
b sqrtzu, sqrtziu,INT, [Nc^2-1],gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc,Num,Den,e_, Nf, NfV;
.sort
#include ratfun.h
.sort

#message printing the final contracted projected result ('time_' s)
b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc;
.sort
#write <../../tmp/squared_contracted/'COUPL'/unreduced'PROJ'_'WHICH'.ff> "l [HLcontracted_'PROJ'_'WHICH'] = %e" HLcontracted;
.end
