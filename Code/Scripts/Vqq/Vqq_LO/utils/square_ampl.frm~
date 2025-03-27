off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h

#include ../Vqq_LO/tmp/CVqq_colour_out.0.dat
#include ./tmp/Vqq_colour_out.1.dat



#message square at NLO
l interf =ampl1L*Campl0L;
.sort
Drop;
NDrop interf;

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

#call onshell
#call subinvariants3point
#call kin3point



.sort
#write <tmp/Htensor.inc> "L Had=%e" interf
.end
