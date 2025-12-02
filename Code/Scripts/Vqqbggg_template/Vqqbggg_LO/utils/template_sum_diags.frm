off statistics;
#-
#include all_header.h
#include ../../process_header.h
#include invariants.h


s add;
l sum = add ;
.sort
P sum;
.sort

#do cycle = {&toreplace}
#include ../../tmp/parsed_diagrams/diag'cycle'_'PROC'_colour_out.0.dat
id add  = add + [diag'cycle'];
b d_,e_,Nc, gs,[Nc^2-1],vggg, vgggg, Spin, T,  ga, cga, gv, cgv;
.sort
#message 'cycle'
#enddo

id add = 0;
.sort
Drop;
NDrop sum;
b d_,e_,Nc, gs,[Nc^2-1],vggg, vgggg, Spin, T,  ga, cga, gv, cgv;
.sort
#write <../../tmp/parsed_diagrams/groups/sum_&group_'PROC'_'NLOOP'.dat> "l diagsum&group = %e" sum
.end
