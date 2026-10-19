off statistics;
#-
#include all_header.h
#include ./process_header.h
#include invariants.h

* Step 06 (written by utils/06_run_sum_contracted.py): sum of piece &coupl, projector L&proj, over the group pairs,
* then the families mapped to the independent ones.

s add;
l sum = add ;
.sort

#do cycle = {&toreplace}
#include ./tmp/squared_contracted/&coupl/unreduced&proj_'cycle'.ff
id add  = add + [HLcontracted_&proj_'cycle'];
b d_,e_,Nc, gs,[Nc^2-1], ga, cga, gv, cgv, Ga, cGa, Gv, cGv, INT, Num, Den;
.sort
Drop [HLcontracted_&proj_'cycle'];
#message 'cycle'
#enddo

id add = 0;
.sort
Drop;
NDrop sum;


#message include loop symmetries
#include &famdir/fams/symm_loop_crossings.inc
.sort
* only the independent families may be left: the dependent ones are the left-hand sides of symm_loop_crossings.inc
Set deptopo: &depset;
if ( match(INT(topo?deptopo,?a)) ) exit "sum_squared_diags: dependent family left after symm_loop_crossings.inc";
.sort

#message rational simplification
b sqrtzu, sqrtziu,INT, [Nc^2-1],gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc,Num,Den,e_, Nf, NfV;
.sort
#include ratfun.h
.sort


#message printing the final contracted projected result

b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc;
.sort
#write <./tmp/unreduced/&coupl/unreduced&proj.ff> "l [unreduced_&proj] = %e" sum;
id [Nc^2-1] = (Nc^2-1);
.sort
format mathematica;
b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, cGv, Gv, cGa, Ga, Nc;
.sort
#write <./tmp/unreduced/&coupl/unreduced&proj.m> " unreduced&proj= (%E)" sum;
.end
