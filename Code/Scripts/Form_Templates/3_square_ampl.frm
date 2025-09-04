off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h
#include ./tmp/CVqqg_colour_out.0.dat
#include ./tmp/Vqqg_colour_out.0.dat





#message square
l interf =ampl0L*Campl0L;
.sort
Drop;
NDrop interf;
.sort
#message combine spinlines
id SpinC(1,p2,?x, p1)*Spin(1,p1, ?y, p2) = g_(1,p1,?x, p2, ?y);
id Spin(1,p1,?x, p2)*SpinC(1,p2, ?y, p1) = g_(1,p1,?x, p2, ?y);
.sort


#message do again color algebra for external color structures
#message color again
#include color.h
#call coloralgebra
.sort

#message traces and contractions
id eps(?x) = e_(?x);
.sort


tracen,1;
#call onshell
#call onshellRadiation
.sort
contract;
.sort
#call onshell
#call onshellRadiation
.sort

#message now include feynman rules
#include feynman_rules.h
#call kin4point
#call onshellRadiation
#call onshell
.sort

#message generated Hadronic tensor

b d_,e_,Nc, gs,Prop, Den, ga, cga, gv, cgv;
.sort
#write <tmp/Htensor.inc> "L Had=%e" interf
.end

