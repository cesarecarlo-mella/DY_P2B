#-
#include 'REDUCTIONLOCAL'


#include set_m2_to_1.h
id INT(PL?,?x,[],?n1) = INT(PL, ?n1);
.sort
#include ../../../Mathematica/MasterIntegrals/'NLOOP'L/IBPtoBasis.inc
.sort

b Den,Num, BASISLC;
.sort
#include ratfun.h
.sort

*WRITE TO FILE INSTEAD
b BASISLC;
print+s;
.end 
#+