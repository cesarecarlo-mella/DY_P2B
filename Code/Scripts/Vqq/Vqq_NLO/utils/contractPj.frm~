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


#call kin3point
#call onshell
#call subinvariants3point
.sort

Drop;
Ndrop HLcontracted;
.sort




id Prop(-k1) = Prop(k1)*Sector(PL,7);
id Prop(-k1+p1) = Prop(k1-p1);
id Prop( - k1 - p2)= Prop(k1+p2);
.sort



#include tmp/prop_substitutions/PL.inc
#include tmp/ISP/PL.inc
.sort


id Sector(PL?,x?)/<D1^n1?>/.../<D'NPROP'^n'NPROP'?> = INT(PL,n1,...,n'NPROP');
.sort




b tag,i_,sqrtzu, sqrtziu, Sector,INT, gs, cgv, gv, cga, ga;
.sort
#write <tmp/unreduced'PROJ'.ff> "id HLcontracted = %e" HLcontracted
.end




