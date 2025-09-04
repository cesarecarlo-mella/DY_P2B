
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


*use this to check whether families have been matched
*id TOPO(n1?{1,2,3,4,5,6,7,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34})=0;
*id TOPO(n1?{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34})=0;
*P;
*.sort
*.end




.sort
#message ISP
#do i=1,39
repeat;
#include ./tmp/fams/fams'i'.inc
id 1/D1 = 1/DD1;
id 1/D2=1/DD2;
id 1/D3=1/DD3;
id 1/D4=1/DD4;
endrepeat;
#enddo
.sort


b TOPO,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,gs, cgv, gv, cga, ga, Nc, NfV;
*P;
*.end
.sort

#message reconstruct ints
#include ./tmp/fams/reconstruct.inc
.sort
*b INT,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,gs, cgv, gv, cga, ga, Nc;
*P;
*.end


#message rational simplification
b sqrtzu, sqrtziu,INT, [Nc^2-1],gs, cgv, gv, cga, ga, Nc,Num,Den,e_, Nf, NfV;
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

