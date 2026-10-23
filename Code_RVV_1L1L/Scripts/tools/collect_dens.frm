off statistics;
#-
* Distinct propagator sets of one step-04 piece (COUPL, WHICH = i_j), printed as the bracket names in Prop, Den.
* Same kinematics as step 05 (template_contractPj.frm; kin4point: one emission): q eliminated in the arguments, overall sign dropped.
* Run from <P>_LO/:  form -d COUPL=vv -d WHICH=1_1 collect_dens.frm
#include all_header.h
#include process_header.h
#include invariants.h
#include tmp/squared_diagrams/'COUPL'/'COUPL'_'WHICH'.inc
.sort
argument Prop;
#call kin4point
endargument;
.sort
Factarg Prop;
id Prop(-1,?x) = Prop(?x);
* a single momentum: Factarg gives Prop(-k1) -> Prop(k1,-1,1)
id Prop(v?,-1,1) = Prop(v);
id Prop(p1+p2) = 1;
.sort
b Prop, Den;
print[];
.end
