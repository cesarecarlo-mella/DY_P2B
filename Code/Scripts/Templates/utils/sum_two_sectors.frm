#-
***usage
* tform -w4 -d 'JOBID'=81 -d 'PROJ'=1 -d 'EXP1'=tmp77 -d 'EXP2'=tmp78 \\
*-d 'FILE1'=tmp/08tmp/tmp77.ff -d 'FILE2'=tmp/08tmp/tmp78.ff -d 'OUTFILE'=tmp08tmp/tmp81.ff \\
*-d 'MUSTSHIFT'=1 -d 'POLYRATFUN'=1 -d 'SHIFTFILE'=external/shifted.inc -d 'OUTID'=tmp81
*-M sum_two_sectors.frm

#include all_header.h
#include process_header.h


g FF'PROJ' = 'EXP1' + 'EXP2';
#include 'FILE1'
#include 'FILE2'
#message Job 'JOBID': File 'FILE1' included
#message Job 'JOBID': File 'FILE2' included
.sort


#if 'MUSTSHIFT' == 1
b Tr, f, i_, gs, eq, lambda, INT, T, f, s;
.sort
keep brackets;
#message Job 'JOBID': Including shifts from 'SHIFTFILE'
#include 'SHIFTFILE'
.sort
#message Job 'JOBID': Done including shifts
id INT(PL?, n1?, n2?, n3?, n4?, [], ?x) = INT(PL,?x);
.sort
#endif


#if 'POLYRATFUN' == 1
#message Job 'JOBID': Starting polyratfun
b INT,Tr, f, Den,i_, gs, lambda, Num,s, Ratio,T,e_,d_,eq;
.sort
#include ratfun.h
.sort
#message Job 'JOBID': Finished polyratfun
#endif


b Tr, f, i_, gs, eq, lambda, INT, T, gA, e_;
.sort
#write <'OUTFILE'> "id 'OUTID' = %e" FF'PROJ';
#message Job 'JOBID': Result written to 'OUTFILE'
.end


