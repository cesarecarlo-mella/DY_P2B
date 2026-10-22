#-
off statistics;
#include all_header.h
#include process_header.h

#include tmp/toreduce.inc
.sort

#include external/reduction.inc
.sort



b INT,Nc,pi_, gs,i_, gv, ga, cga, cgv, Num, Den;
.sort
Collect Num;
id Num(n1?) = Ratio(n1,1);
id Den(n1?) = Ratio(1,n1);
.sort
Polyratfun Ratio;
.sort
Polyratfun;
.sort

id Ratio(n1?, n2?) = Num(n1) * Den(n2);

factarg Num;
factarg Den;

chainout Num;
chainout Den;
.sort


.sort
repeat id Den(n1?number_) = 1/n1;
repeat id Den(n1?symbol_) = 1/n1;
repeat id Num(n1?number_) = n1;
repeat id Num(n1?symbol_) = n1;
.sort

#opendictionary mth
#add pi_: "Pi"
#add i_: "I"
#add Z: "Zeta"
*#add d_: "Metric"
#closedictionary
#usedictionary mth


format Mathematica;
b INT,Nc,pi_, gs,i_,m2, Num, Den;
#write <tmp/reduced.m> "reduced = (%E);" toreduce 
.sort

.end