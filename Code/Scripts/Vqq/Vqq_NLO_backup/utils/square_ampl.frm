off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h
#include ../Vqq_LO/tmp/Vqq_colour_out.0.dat
#include ../Vqq_LO/tmp/CVqq_colour_out.0.dat
#include ./tmp/CVqq_colour_out.1.dat
#include ./tmp/Vqq_colour_out.1.dat



#message square at NLO
l interf =ampl1L*Campl0L;
.sort
id SpinC(1,p2,?x, p1)*Spin(1,p1, ?y, p2) = g_(1,p1,?x, p2, ?y);
id Spin(1,p1,?x, p2)*SpinC(1,p2, ?y, p1) = g_(1,p1,?x, p2, ?y);
.sort



id eps(?x) = e_(?x);
tracen,1;
contract;
.sort
#call onshell
.sort
#include feynman_rules.h
#call onshell
.sort
#message contract with leptonic tensor
#include external/LeptonicCurrents/L1_4.inc
l trace = interf*L1;
.sort
#call onshell
#call subinvariants3point
#call kin3point
#call onshell
.sort

id Prop(-k1) = Prop(k1)*Sector(PL,7);
id Prop(-k1+p1) = Prop(k1-p1);
id Prop( - k1 - p2)= Prop(k1+p2);
.sort

#include tmp/prop_substitutions/PL.inc
#include tmp/ISP/PL.inc
.sort
.sort
id Sector(PL?,x?)/<D1^n1?>/.../<D'NPROP'^n'NPROP'?> = INT(PL,n1,...,n'NPROP');
.sort


b pi_,i_,gs,INT, gv, cgv,ga, cga,d_;
.sort
b pi_,i_,gs,INT, gv, cgv,ga, cga,d_;
#write <tmp/toreduce.inc> "L toreduce =%e" trace
.end

