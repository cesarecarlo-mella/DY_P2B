
off statistics;
#-
#include all_header.h
#include ../../process_header.h
#include invariants.h



#include ../../tmp/squared_diagrams/vv/vv_'WHICH'.inc

#message contract with leptonic tensor
#include ../../external/LeptonicCurrents/L'PROJ'.inc
l HLcontracted = [interf'WHICH']*L'PROJ';
.sort

id eps(?x) = e_(?x);
.sort
contract;
.sort

#message I contracted with projector and sorted now.

.sort
#write <../../tmp/squared_contracted/vv/HLcontracted'PROJ'_'WHICH'.ff> "id HLcontracted = %e" HLcontracted;

argument Prop;
#call kin6point
endargument;
.sort
id Prop(-p2 - r1 - r2)=Prop(p2 + r1 +r2);
id Prop(-p2 - r1 - r2 - r3)=Prop(p2 + r1 +r2+r3);
id Prop(-p2-r1) = Prop(p2+r1);
id Prop(-p2-r2) = Prop(p2+r2);
id Prop(-r1-r2) = Prop(r1+r2);
#call kin6point
#call onshell
#call onshellRadiation
.sort
Drop;
Ndrop HLcontracted;
.sort

Factarg Prop;
id Prop(-1,?x) = Prop(?x); 
.sort

.sort
id Prop(p1+p2) = Num(z)/m2;
.sort
repeat;
id s12^(n1?) = (m2)^n1*Den(z^(n1));
id s12 = m2*Den(z);
endrepeat;
.sort

#message Kinematics and sort again. Next: partial fraction


*#include tmp/partial_fraction_id/partialfraction_extra_1.inc
#do i=1,270
repeat;
#include ../../tmp/partial_fraction_id/partialfraction_'i'.inc
endrepeat;
#enddo
id Den(2)=1/2;
.sort


#message Done with partial fraction. Next: recognize all dens
.sort
#include ../../tmp/fams/dens.inc
.sort
id Den(2)=1/2;
.sort
#message match to families
#include ../../tmp/fams/fammatch.inc
.sort


.sort
#message ISP
#do i=1,284
repeat;
#include ../../tmp/fams/fams'i'.inc
id 1/D1 = 1/DD1;
id 1/D2= 1/DD2;
id 1/D3= 1/DD3;
id 1/D4= 1/DD4;
id 1/D5 = 1/DD5;
endrepeat;
#enddo
.sort


id m2 =1;
argument Num, Den;
id m2=1;
endargument;
.sort
id Den(2) = 1/2;
id Den(2*z) = 1/2*Den(z);
id Num(2*u*z) = 2*Num(u*z);
.sort


b TOPO,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,DD12,DD13,DD14,DD15,DD16,DD17,DD18,DD19,DD20,DD21,DD22,DD23,gs, cgv, gv, cga, ga, Nc, NfV;
.sort
#write <../../tmp/squared_contracted/vv/HLcontracted'PROJ'_'WHICH'_matched.ff> "l  HLcontracted = %e" HLcontracted;

#message reconstruct ints
#include ../../tmp/fams/reconstruct.inc
.sort
*b INT,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,gs, cgv, gv, cga, ga, Nc;
*P;
*.end


#message rational simplification
b sqrtzu, sqrtziu,INT, [Nc^2-1],gs, cgv, gv, cga, ga, Nc,Num,Den,e_, Nf, NfV;
.sort
#include ratfun.h
.sort


#message printing the final contracted projected result

b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <../../tmp/squared_contracted/vv/unreduced'PROJ'_'WHICH'.ff> "l [HLcontracted_'PROJ'_'WHICH'] = %e" HLcontracted;
id [Nc^2-1] = (Nc^2-1);
.sort
.end