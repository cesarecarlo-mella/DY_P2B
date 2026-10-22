
off statistics;
#-
#include all_header.h
#include ../../process_header.h
#include invariants.h
* numerators of the families as a table ISP(family, scalar product), FAMDIR/isp_table.py
#include 'FAMDIR'/fams/isp_table.inc
* RRV: (RR set, loop part) -> family and k1 shift, loop scalar products of the families (FAMDIR/rrv_families.py)
cf PropSet, RRVT, LSHIFT;
#include 'FAMDIR'/fams/rrv_match_table.inc
#include 'FAMDIR'/fams/rrv_isp_table.inc

* Code_RRV (one loop k1, two emissions r1, r2; cut D1..D4, RR D5..D13, loop D14..D29). Step 05, one job: piece COUPL (vv, va, ..., a2a2) of the group pair WHICH (= i_j) of step 04, contracted with the
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
#call kin5point
endargument;
#call kin5point
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

#message match to RRV families ('time_' s)
* sorted set of the k1-free propagators (D5..D13) and of the loop propagators (codes >= 100, as they come out of
* step 04) -> RRVT(family)*LSHIFT(shift), or 0 for a scaleless loop (FAMDIR/rrv_families.py)
multiply PropSet;
#do k=5,13
if ( count(D'k',1) != 0 ) id PropSet(?a) = PropSet(?a,'k');
#enddo
#include 'FAMDIR'/fams/rrv_loopcodes.inc
#define PSARGS "n1?"
#define TBARGS "n1"
#do m=1,8
id PropSet('PSARGS') = RRVM'm'('TBARGS');
#redefine PSARGS "'PSARGS',n{'m'+1}?"
#redefine TBARGS "'TBARGS',n{'m'+1}"
#enddo
.sort
if ( count(PropSet,1) != 0 ) exit "contractPj: term with no loop propagator or more than 8 propagators";
if ( count(RRVM1,1,RRVM2,1,RRVM3,1,RRVM4,1,RRVM5,1,RRVM6,1,RRVM7,1,RRVM8,1) != 0 )
    exit "contractPj: (RR set, loop part) not in fams/rrv_match_table.inc (rerun collect_dens, rrv_families.py)";
if ( count(RRVT,1) != 1 ) exit "contractPj: term without exactly one RRVT";
* k1 -> s k1 + c of the family, then the kinematics again (new p1.p2, signs inside Prop)
#include 'FAMDIR'/fams/rrv_shifts.inc
.sort
#call kin5point
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
#include 'FAMDIR'/fams/rrv_loopdens.inc
.sort
if ( count(Prop,1) > 0 ) exit "contractPj: propagator not in dens.inc / rrv_loopdens.inc";
#do k=5,29
id D'k'^n? = DD'k'^n;
#enddo
id 1/D1 = 1/DD1;
id 1/D2 = 1/DD2;
id 1/D3 = 1/DD3;
id 1/D4 = 1/DD4;
.sort

#message ISP ('time_' s)
* scalar products in the DD's of the term's family (table lookup, one scalar product per module): FAMDIR/isp_table.py
* loop scalar products (k1.x) in the pentagon DD's, then the RR ones in the DD's of the family's RR part
#include 'FAMDIR'/fams/rrv_isp_apply.inc
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
#do k=2,29
#redefine DDLIST "'DDLIST',DD'k'"
#enddo
b RRVT,TOPO,[Nc^2-1],INT,'DDLIST',gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc, NfV;
.sort
#write <../../tmp/squared_contracted/'COUPL'/HLcontracted'PROJ'_'WHICH'_matched.ff> "l  HLcontracted = %e" HLcontracted;
#endif

#message reconstruct ints ('time_' s)
#include 'FAMDIR'/fams/rrv_reconstruct.inc
.sort
if ( count(TOPO,1,RRVT,1) != 0 ) exit "contractPj: TOPO/RRVT left after rrv_reconstruct.inc";
#do k=1,29
if ( count(DD'k',1) != 0 ) exit "contractPj: DD'k' left after rrv_reconstruct.inc";
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
