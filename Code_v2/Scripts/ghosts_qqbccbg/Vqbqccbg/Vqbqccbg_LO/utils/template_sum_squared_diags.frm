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
#include ./tmp/squared_contracted/&coupl/unreduced&proj_'cycle'.ff
id add  = add + [HLcontracted_&proj_'cycle'];
b d_,e_,Nc, gs,[Nc^2-1] ga, cga, gv, cgv, INT, Num, Den;
.sort
#message 'cycle'
#enddo

id add = 0;
.sort
Drop;
NDrop sum;


#message include loop symmetries
#include ./tmp/fams/symm_loop_crossings.inc
.sort

#message rational simplification
b sqrtzu, sqrtziu,INT, [Nc^2-1],gs, cgv, gv, cga, ga, Nc,Num,Den,e_, Nf, NfV;
.sort
#include ratfun.h
.sort



#message printing the final contracted projected result

b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <./tmp/unreduced/vv/unreduced&proj.ff> "l [unreduced_&proj] = %e" sum;
id [Nc^2-1] = (Nc^2-1);
.sort
format mathematica;
b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <./tmp/unreduced/vv/unreduced&proj.m> " unreduced&proj= (%E)" sum;
.end

