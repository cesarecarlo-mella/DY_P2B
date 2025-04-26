off statistics;
#-
#include all_header.h
#include ../../../process_header.h
#include invariants.h




#message square
#include ../../../tmp/parsed_diagrams/diag'loopind'_'PROC'_colour_out.'NLOOP'.dat
#include ../../../tmp/parsed_diagrams/Cdiag'loopind2'_'PROC'_colour_out.'NLOOP'.dat


l interf = [diag'loopind']*[Cdiag'loopind2'];
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


b gs,[Nc^2-1], pol,ga,gv,cga,cgv,eps,pQuark,g_;
.sort




#message traces and contractions
id eps(?x) = e_(?x);
.sort

b Spin, pol, pQuark, pgluon, [Nc^2-1],gs, ga, gv,cgv,cga,e_;
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
#call kin5point
#call onshellRadiation
#call onshell
.sort

#message generated Hadronic tensor



b cga,ga,cgv,gv;
.sort
l aa = interf[ga(ti)*cga(tj)];
l vv = interf[gv(ti)*cgv(tj)];
l va = interf[gv(ti)*cga(tj)];
l av = interf[ga(ti)*cgv(tj)];
b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
.sort

b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
.sort
#write <../../../tmp/squared_diagrams/vv/vv_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" vv
#write <../../../tmp/squared_diagrams/aa/aa_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" aa
#write <../../../tmp/squared_diagrams/va/va_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" va
#write <../../../tmp/squared_diagrams/av/av_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" av
.end




*b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
*.sort
*#write <tmp/Htensor.inc> "L Had=%e" interf
*.end

