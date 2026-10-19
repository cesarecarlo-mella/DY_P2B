
off statistics;
#-
#include all_header.h
#include ../../process_header.h
#include invariants.h
* numerators of the families as a table ISP(family, scalar product), FAMDIR/isp_table.py
#include 'FAMDIR'/fams/isp_table.inc
* family of a set of propagators as tables FAM<m>(k1,...,km), FAMDIR/fammatch_table.py
#include 'FAMDIR'/fams/fammatch_table.inc
cf PropSet;

* Code_LO (Born q qb -> V; cut D1, D2 = q^2 - m2, rapidity; no emission). Kinematics q = -p1-p2, p1.p2 = s12/2
* written inline (invariants.h kin3point sets p1.p2 = m2/2; here s12 = m2/z as in R, RR, RRR).
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

#message I contracted with projector and sorted now. ('time_' s)
#if 'DEBUG' > 0
#write <../../tmp/squared_contracted/'COUPL'/HLcontracted'PROJ'_'WHICH'.ff> "id HLcontracted = %e" HLcontracted;
#endif

* Kinematics. Propagators: q eliminated inside the arguments, overall sign of the momentum dropped (Prop = 1/k^2),
* which gives the same form as in FAMDIR/fams/dens.inc and the partial-fraction identities.
argument Prop;
id q=-p1-p2;
id p1.p2 = s12/2;
endargument;
id q=-p1-p2;
id p1.p2 = s12/2;
#call onshell
#call onshellRadiation
.sort
Factarg Prop;
id Prop(-1,?x) = Prop(?x);
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
if ( count(Prop,1) > 0 ) exit "contractPj: propagator not in dens.inc";
if ( match(Den(cut,?a)) ) exit "contractPj: cut denominator not in dens.inc";
id Den(2)=1/2;
.sort

#message match to families ('time_' s)
* one family topo1 = the 2 cut propagators: the regular propagators are constants on the cut and were
* replaced by FAMDIR/partial_fraction (old Code: tmp/partial_fraction, prop_substitutions of family PL)
if ( count(Prop,1) != 0 ) exit "contractPj: propagator left";
multiply TOPO(1);
id 1/D1 = 1/DD1;
id 1/D2 = 1/DD2;
.sort
#do k=1,2
if ( count(D'k',1) != 0 ) exit "contractPj: D'k' left";
#enddo
.sort

#message ISP ('time_' s)
* scalar products in the DD's of the term's family (table lookup, one scalar product per module): FAMDIR/isp_table.py
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
#do k=2,2
#redefine DDLIST "'DDLIST',DD'k'"
#enddo
b TOPO,[Nc^2-1],INT,'DDLIST',gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc, NfV;
.sort
#write <../../tmp/squared_contracted/'COUPL'/HLcontracted'PROJ'_'WHICH'_matched.ff> "l  HLcontracted = %e" HLcontracted;
#endif

#message reconstruct ints ('time_' s)
#include 'FAMDIR'/fams/reconstruct.inc
.sort
if ( count(TOPO,1) != 0 ) exit "contractPj: TOPO left after reconstruct.inc";
#do k=1,2
if ( count(DD'k',1) != 0 ) exit "contractPj: DD'k' left after reconstruct.inc";
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
