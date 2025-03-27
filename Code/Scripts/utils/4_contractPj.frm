
off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h
#include tmp/Htensor.inc





#message contract with leptonic tensor
#include external/LeptonicCurrents/L'PROJ'.inc
l HLcontracted = Had*L'PROJ';
.sort

id eps(?x) = e_(?x);
.sort
contract;
.sort


#call kin4point
#call onshell
#call onshellRadiation
.sort

Drop;
Ndrop HLcontracted;
.sort


argument Prop;
#call kin4point;
#call onshell;
endargument;
.sort

#message identify sectors
id Prop(cut,?x) = Prop(?x);
id Den(cut,?x) = Den(?x);





#message partialfraction
#include ./tmp/partial_fraction/partialfraction.inc
#message prop identification
#include ./tmp/prop_substitutions/PL.inc
#message ISP
#include ./tmp/ISP/PL.inc
.sort

.sort
id 1/<D1^n1?>/.../<D3^n3?> = INT(PL,n1,...,n3);

#message rational simplification
b sqrtzu, sqrtziu,INT, gs, cgv, gv, cga, ga, Nc,Num,Den;
.sort
#include ratfun.h
.sort




b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <tmp/unreduced'PROJ'.ff> "id HLcontracted = %e" HLcontracted;


id [Nc^2-1] = (Nc^2-1);
.sort
format mathematica;
b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <tmp/unreduced'PROJ'.m> " HLcontracted = (%E)" HLcontracted;
.end

