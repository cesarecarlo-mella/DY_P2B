
off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h



#include tmp/Htensor/aa/Htensor.inc




#message contract with leptonic tensor
#include external/LeptonicCurrents/L'PROJ'.inc
l HLcontracted = Htensor*L'PROJ';
.sort

id eps(?x) = e_(?x);
.sort
contract;
.sort



#call kin5point
#call onshell
#call onshellRadiation
.sort
Drop;
Ndrop HLcontracted;
.sort

.sort
repeat;
id s12^(n1?) = (m2)^n1*Den(z^(n1));
id s12 = m2*Den(z);
endrepeat;
.sort

.sort

repeat;
#include tmp/partial_fraction_id/partialfraction_1.inc
#include tmp/partial_fraction_id/partialfraction_2.inc
#include tmp/partial_fraction_id/partialfraction_3.inc
#include tmp/partial_fraction_id/partialfraction_4.inc
#include tmp/partial_fraction_id/partialfraction_5.inc
#include tmp/partial_fraction_id/partialfraction_6.inc
#include tmp/partial_fraction_id/partialfraction_7.inc
#include tmp/partial_fraction_id/partialfraction_8.inc
#include tmp/partial_fraction_id/partialfraction_9.inc
#include tmp/partial_fraction_id/partialfraction_10.inc
#include tmp/partial_fraction_id/partialfraction_11.inc
#include tmp/partial_fraction_id/partialfraction_13.inc
#include tmp/partial_fraction_id/partialfraction_14.inc
#include tmp/partial_fraction_id/partialfraction_15.inc
#include tmp/partial_fraction_id/partialfraction_16.inc
#include tmp/partial_fraction_id/partialfraction_17.inc
endrepeat;

#message recognize all dens
.sort
#include ./tmp/fams/dens.inc
.sort

#message match to families
#include ./tmp/fams/fammatch.inc
.sort




*id TOPO(n1?{1,2,3,4,5,6,7,8,9,11,12,13,14})=0;

.sort
#message ISP
repeat;
#include ./tmp/fams/fams1.inc
#include ./tmp/fams/fams2.inc
#include ./tmp/fams/fams3.inc
#include ./tmp/fams/fams4.inc
#include ./tmp/fams/fams5.inc
#include ./tmp/fams/fams6.inc
#include ./tmp/fams/fams7.inc
#include ./tmp/fams/fams8.inc
#include ./tmp/fams/fams9.inc
#include ./tmp/fams/fams10.inc
#include ./tmp/fams/fams11.inc
#include ./tmp/fams/fams12.inc
#include ./tmp/fams/fams13.inc
#include ./tmp/fams/fams14.inc
id 1/D1 = 1/DD1;
id 1/D2=1/DD2;
id 1/D3=1/DD3;
id 1/D4=1/DD4;
endrepeat;
.sort


*b TOPO,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,gs, cgv, gv, cga, ga, Nc;
*P;
*.end
*.sort

#message reconstruct ints
#include ./tmp/fams/reconstruct.inc
.sort
*b INT,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,gs, cgv, gv, cga, ga, Nc;
*P;
*.end


#message rational simplification
b sqrtzu, sqrtziu,INT, [Nc^2-1],gs, cgv, gv, cga, ga, Nc,Num,Den,e_;
P;
.end

.sort
#include ratfun.h
.sort



b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <tmp/unreduced/aa/unreduced'PROJ'.ff> "id HLcontracted = %e" HLcontracted;
id [Nc^2-1] = (Nc^2-1);
.sort
format mathematica;
b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <tmp/unreduced/aa/unreduced'PROJ'.m> " HLcontracted = (%E)" HLcontracted;
.end

