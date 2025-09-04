off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h

#message Load the unintegrated Hadronic tensor 
#include tmp/Htensor.inc
#message Load the unintegrated Leptonic tensor
#include external/decayAmpSquared/decay.inc
#message Load the projectors L1 and L6
#include external/LeptonicCurrents/L1.inc
#include external/LeptonicCurrents/L6.inc

.sort
id eps(?x) = e_(?x);
.sort



s q2,s34,s23,s14,s15,s24;
.sort
id d=4;

id Prop(p1+r1) = 1/s13;
id Prop(p1+p2) = 1/s12;
id Prop(cut,r1) = 1;
id Prop(cut,-q,m2) = 1;
id Prop(q+p1) = 1/(s23);
id Den(cut, - q.p1 + q.p2*u)=2/(s12+s23);
id p1.r1 = s13/2;
id p2.r1 = s23/2;
.sort



#message Build the amplitude modulo square
L contr = Had*decayAmpsSquared;
.sort
contract;
.sort
id k2 = -p1-p2-r1-k1;
.sort
id p1.p1 =0;
id p2.p2 =0;
id r1.r1=0;
id k1.k1=0;
id p1.p2 = s12/2;
id p1.r1 = s13/2;
id p2.r1 = s23/2;
id k1.r1 = -(s12+s13+s23+s14+s24)/2;
id k1.p2 = s24/2;
id k1.p1 = s14/2;
id d=4;
.sort
b gs,Nc,ga,cga,gv,cgv;

.sort
id [Nc^2-1] = Nc*Nc-1;
.sort


L contrL1 = Had*L1;
.sort
contract;
.sort
id q=-p1-p2-r1;
id p1.p1 =0;
id p2.p2 =0;
id r1.r1=0;
id p1.p2 = s12/2;
id p1.r1 = s13/2;
id p2.r1 = s23/2;
id d=4;
.sort
b gs,Nc,ga,cga,gv,cgv;

.sort
id [Nc^2-1] = Nc*Nc-1;
.sort


L contrL6 = Had*L6;
.sort
argument eps;
id q = -p1-p2-r1;
endargument;
.sort
contract;
.sort
id q = -p1-p2-r1;
id p1.p1 =0;
id p2.p2 =0;
id r1.r1=0;
id p1.p2 = s12/2;
id p1.r1 = s13/2;
id p2.r1 = s23/2;
id d=4;
.sort
b gs,Nc,ga,cga,gv,cgv;

.sort
id [Nc^2-1] = Nc*Nc-1;
.sort




format Mathematica;
b gs, cgv, gv, cga, ga, Nc,Den;
.sort
#write <tmp/unpolarised_FullModuloSquare.m> "AA = (%E);"  contr
#write <tmp/unpolarised_ModuloSquare_L1.m> "AA = (%E);"  contrL1
#write <tmp/unpolarised_ModuloSquare_L6.m> "AA = (%E);"  contrL6
.end
