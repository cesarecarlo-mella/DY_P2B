
off statistics;
#-
#include all_header.h
#include ../../process_header.h
#include invariants.h
* numerators of the families as a table ISP(family, scalar product), FAMDIR/isp_table.py
#include 'FAMDIR'/fams/isp_table.inc
* RV: loop part -> family and k1 shift, loop scalar products of the families (FAMDIR/rv_families.py)
cf PropSet, RVT, LSHIFT;
#include 'FAMDIR'/fams/rv_match_table.inc
#include 'FAMDIR'/fams/rv_isp_table.inc
* RVV 1L x 1L: the conjugate loop k2 (FAMDIR/rvv_families.py)
cf PropSet2, RVTA, RVTB;
#include 'FAMDIR'/fams/rvv_isp_table2.inc

* Code_RVV_1L1L, 1L x 1L (amplitude loop k1, conjugate loop k2, one emission r1; cut D1..D3 = r1^2, q^2 - m2, rapidity;
* the loop-free regular propagators are constants on the cut, everything is fixed by z, u; D4..D11 = (k1 + S)^2,
* D12..D19 = (k2 + S)^2, D20 = (k1 + k2)^2; families = box in k1 x box in k2 x (k1 + k2)^2, rvv_families.py).
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

#message match the two loops to RV box families ('time_' s)
* 1L x 1L: the amplitude loop k1 and the conjugate loop k2 are matched separately with the RV tables (codes >= 100 of
* fams/rvv_loopcodes.inc: k1 in PropSet, k2 in PropSet2); family of k1 -> RVTA, of k2 -> RVTB (FAMDIR/rvv_families.py)
multiply PropSet*PropSet2;
#include 'FAMDIR'/fams/rvv_loopcodes.inc
* k1: sorted set of its loop propagators (PropSet) -> RVT(box family)*LSHIFT(shift), or 0 for a scaleless loop
#define PSARGS "n1?"
#define TBARGS "n1"
#do m=1,4
id PropSet('PSARGS') = RVM'm'('TBARGS');
#redefine PSARGS "'PSARGS',n{'m'+1}?"
#redefine TBARGS "'TBARGS',n{'m'+1}"
#enddo
.sort
if ( count(PropSet,1) != 0 ) exit "contractPj: term with no k1 propagator or more than 4";
if ( count(RVM1,1,RVM2,1,RVM3,1,RVM4,1) != 0 )
    exit "contractPj: k1 loop part not in fams/rv_match_table.inc (rerun collect_dens, rv_families.py)";
if ( count(RVT,1) != 1 ) exit "contractPj: term without exactly one RVT (k1)";
* k1 -> s k1 + c of the family
#include 'FAMDIR'/fams/rv_shifts.inc
id RVT(n?) = RVTA(n);
.sort
* k2: sorted set of its loop propagators (PropSet2) -> RVT(box family)*LSHIFT(shift), or 0 for a scaleless loop
#define PSARGS "n1?"
#define TBARGS "n1"
#do m=1,4
id PropSet2('PSARGS') = RVM'm'('TBARGS');
#redefine PSARGS "'PSARGS',n{'m'+1}?"
#redefine TBARGS "'TBARGS',n{'m'+1}"
#enddo
.sort
if ( count(PropSet2,1) != 0 ) exit "contractPj: term with no k2 propagator or more than 4";
if ( count(RVM1,1,RVM2,1,RVM3,1,RVM4,1) != 0 )
    exit "contractPj: k2 loop part not in fams/rv_match_table.inc (rerun collect_dens, rv_families.py)";
if ( count(RVT,1) != 1 ) exit "contractPj: term without exactly one RVT (k2)";
* k2 -> s k2 + c of the family
#include 'FAMDIR'/fams/rvv_shifts2.inc
id RVT(n?) = RVTB(n);
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
#include 'FAMDIR'/fams/rv_loopdens.inc
#include 'FAMDIR'/fams/rvv_loopdens2.inc
.sort
if ( count(Prop,1) > 0 ) exit "contractPj: propagator not in dens.inc / rv_loopdens.inc / rvv_loopdens2.inc";
#do k=4,19
id D'k'^n? = DD'k'^n;
#enddo
id 1/D1 = 1/DD1;
id 1/D2 = 1/DD2;
id 1/D3 = 1/DD3;
.sort

#message ISP ('time_' s)
* loop scalar products: k1.k2 -> (k1+k2)^2 = DD20, k1.x and k2.x in the box DD's of their families, then p1.r1,
* p2.r1 (constants on the cut, topo1 of Code_R: isp_table.inc)
#include 'FAMDIR'/fams/rvv_isp_apply.inc
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
#do k=2,20
#redefine DDLIST "'DDLIST',DD'k'"
#enddo
b RVTA,RVTB,TOPO,[Nc^2-1],INT,'DDLIST',gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc, NfV;
.sort
#write <../../tmp/squared_contracted/'COUPL'/HLcontracted'PROJ'_'WHICH'_matched.ff> "l  HLcontracted = %e" HLcontracted;
#endif

#message reconstruct ints ('time_' s)
#include 'FAMDIR'/fams/rvv_reconstruct.inc
.sort
if ( count(TOPO,1,RVTA,1,RVTB,1) != 0 ) exit "contractPj: TOPO/RVTA/RVTB left after rvv_reconstruct.inc";
#do k=1,20
if ( count(DD'k',1) != 0 ) exit "contractPj: DD'k' left after rvv_reconstruct.inc";
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
