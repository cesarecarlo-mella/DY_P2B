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

#do cycle = {&toreplace}
#include ./tmp/squared_diagrams/vv/vv_diag_'cycle'.inc
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
#write <./tmp/Htensor/vv/Htensor.inc> "l Htensor = %e" sum
.end
