off statistics;
#-
#include all_header.h
#include ./process_header.h
#include invariants.h


s add;
l sum = add ;
.sort
P sum;
.sort

#do cycle = {6_7,4_7,2_5,2_2,2_8,8_6,5_6,7_4,1_3,2_6,5_8,1_4,2_4,3_3,8_4,1_1,3_2,3_1,3_7,2_1,4_1,6_3,1_8,3_5,3_6,1_7,2_3,5_7,8_7,6_1,7_6,3_4,2_7,7_8,1_5,7_5,7_2,7_7,4_8,8_5,4_5,4_3,8_8,6_4,4_2,5_2,3_8,7_3,5_3,8_3,5_1,6_6,5_4,8_1,5_5,4_4,6_8,1_6,8_2,6_2,1_2,6_5,4_6,7_1}
#include ./tmp/squared_diagrams/aa/aa_diag_'cycle'.inc
id add  = add + [interf'cycle'];
argument Prop;
#call kin5point
endargument;
.sort
id Prop(-p2 - r1 - r2)=Prop(p2 + r1 +r2);
id Prop(-p2-r1) = Prop(p2+r1);
id Prop(-p2-r2) = Prop(p2+r2);
id Prop(-r1-r2) = Prop(r1+r2);
.sort
b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
.sort
#message 'cycle'
#enddo

id add = 0;
.sort
Drop;
NDrop sum;
b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
.sort
#write <./tmp/Htensor/aa/Htensor.inc> "l Htensor = %e" sum
.end
