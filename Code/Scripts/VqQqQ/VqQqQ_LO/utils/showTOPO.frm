
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

Factarg Prop;
id Prop(-1,?x) = Prop(?x); 
.sort

.sort
id Prop(p1+p2) = z/m2;
id Prop(p1+p2) = z/m2;
.sort
repeat;
id s12^(n1?) = (m2)^n1*Den(z^(n1));
id s12 = m2*Den(z);
endrepeat;
.sort



#include tmp/partial_fraction_id/partialfraction_extra_1.inc
#include tmp/partial_fraction_id/partialfraction_extra_2.inc
#do i=1,49
repeat;
#include tmp/partial_fraction_id/partialfraction_'i'.inc
endrepeat;
#enddo
id Den(2)=1/2;
id Den(2)=1/2;
.sort


#message recognize all dens
.sort
#include ./tmp/fams/dens.inc
.sort

#message match to families
#include ./tmp/fams/fammatch.inc
.sort


id gs = 1;
id Num(?x) =1;
id Nc = 3;
id Nc^-1 =1;
id Den(?x) = 1;
id d =3/2;
id m2=1;
id m2^-1=1;
id z = 1/2;
id D1^-1=1;
id D2^-1=1;
id D3^-1=1;
id D4^-1=1;
*id DD5^-1=1;
*id DD6^-1=1;
*id DD7^-1=1;
*id DD8^-1=1;
*id DD9^-1=1;
*id DD10^-1=1;
*id DD11^-1=1;
*id DD12^-1=1;
*id DD13^-1=1;
b TOPO, DD5,DD6,DD7,DD8,DD9,DD10,DD11,DD12,DD13;
.sort
Collect Num;
id Num(?x) = 1;
id Den(?x)=1;
print HLcontracted;
.sort
.end


