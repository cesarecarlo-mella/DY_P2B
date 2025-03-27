off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h
#include tmp/Htensor.inc

.sort

#include external/decayAmpSquared/decay.inc
*#include external/decayAmpSquared/VectorDecay.inc


.sort
id d=4;
.sort

L contr = Had*decayAmpsSquared;
.sort
contract;
.sort
id k2 = -p1-p2-k1;
.sort
id p1.p2 = s12/2;
id p1.p1 = 0;
id p2.p2 = 0;
id k1.k1 = 0;
id k1.p1 = s13/2;
id k1.p2 = s23/2;
id d = 4;
.sort
P;

format Mathematica;
b gs, cgv, gv, cga, ga, Nc,Den;
.sort
#write <tmp/unpolarised_moduloSquare_todecay.m> "AA = (%E);"  contr
.end
