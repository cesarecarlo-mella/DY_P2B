off statistics;
#-
#include all_header.h
#include ../../../process_header.h
#include invariants.h





#include ../../../tmp/squared_diagrams/vv/vv_diag_'ind1'_'ind2'.inc
#include ../../../tmp/squared_diagrams/vv/vv_diag_'ind3'_'ind4'.inc

l sum= [interf'ind1'vs'ind2']+[interf'ind3'vs'ind4'];
.sort


Drop;
NDrop sum;
.sort



b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
.sort
b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
.sort
#write <../../../tmp/squared_diagrams/vv/vv_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'vs'loopind2']=%e" vv
#write <../../../tmp/squared_diagrams/aa/aa_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'vs'loopind2']=%e" aa
#write <../../../tmp/squared_diagrams/va/va_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'vs'loopind2']=%e" va
#write <../../../tmp/squared_diagrams/av/av_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'vs'loopind2']=%e" av
.end
