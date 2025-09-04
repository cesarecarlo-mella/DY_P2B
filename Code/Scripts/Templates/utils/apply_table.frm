#-
#include all_header.h
#include process_header.h


TableBase "'TABLEFILE'" open;
TableBase "'TABLEFILE'" load NewINT;

L exp=S1;
.sort

#include tmp/layers/'LAYER'/'FOLDER'/FF'FF'/S1TBase.ff
#message Apply table script: Starting substitutions in 'LAYER'/'FOLDER'/FF'FF'/S1TBase.ff

#do i = 1,1
TestUse NewINT;
.sort
TableBase "'TABLEFILE'" use;
Apply;
if ( count(tbl_,1) ) Redefine i "0";
.sort
#enddo
#message Apply table script: Finished substitutions in 'LAYER'/'FOLDER'/FF'FF'/S1TBase.ff

id INT(PL?, x1?, x2?, x3?, x4?, [], ?x) = INT(PL, ?x);
id NewINT(?x) = INT(?x);
.sort

#if 'KIRA' == 1
#message Apply table script: Substituting m2=1 for KIRA
#include set_m2_to_1.h
#endif

b CMetric,gem,T,lambda,s, f, i_, gs,eq,INT,Den,Num, BASISLC;
.sort
#if 'POLYRATFUN' == 1
#message Apply table script: Simplifying with Polyratfun
#include ratfun.h
#endif
.sort

*Write FORM style
b T,lambda,s,f,gs,eq,INT,Den,Num, BASISLC;
.sort
#write <tmp/layers/'LAYER'/'FOLDER'/FF'FF'/S1_reduced_FORM.ff> "id S1 = %e" exp;

*Write Mathematica style
.sort
#include mathdictionary.h

format mathematica;
b T,lambda,s,f,gs,eq,INT,Den,Num, BASISLC;
.sort
#write <tmp/layers/'LAYER'/'FOLDER'/FF'FF'/S1_reduced_MMA.ff> "FF['FF']['LAYER'] = %e" exp;
#message Apply table script: Finished reduction insertion for FF'FF' and layer 'LAYER'
.end
#+