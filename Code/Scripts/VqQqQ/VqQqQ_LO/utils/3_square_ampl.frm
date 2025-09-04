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
id Spin(1,p1?,?x, p2?)*Spin(2,?z)*SpinC(1,p2?, ?y, p1?) = g_(1,p1,?x, p2, ?y)*Spin(2,?z);
id Spin(2,p1?,?x, r1?)*SpinC(2,r1?, ?y, p1?) = g_(2,p1,?x, r1, ?y);
id Spin(1,p1?,?x, p2?)*Spin(2,?z)*SpinC(1,p2?, ?y, p3?) = Spin(1,p1,?x, p2, ?y,p3)*Spin(2,?z);
id Spin(1,p1?,?x, p2?)*Spin(2,p2?,?y, p3?)*SpinC(2,p3?,?z, p1?)= g_(1,p1,?x, p2, ?y,p3,?z);
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
#message trace 1 done

b Spin, pol, pQuark, pgluon, [Nc^2-1],gs, ga, gv,cgv,cga,e_;
.sort
tracen,2;
#call onshell
#call onshellRadiation
.sort
contract;
.sort
#call onshell
#call onshellRadiation
.sort

#message trace 2 done

*b Spin, pol, pQuark, pgluon, [Nc^2-1],gs, ga, gv,cgv,cga,e_;
*P;
*.end

#message now include feynman rules
#include feynman_rules.h
#call kin5point
#call onshellRadiation
#call onshell
.sort

#message generated Hadronic tensor

b cga,ga,cgv,gv,Ga, Gv, cGv, cGa;
.sort
** axials
l aa = interf[ga(ti)*cga(tj)];
l aA = interf[ga(ti)*cGa(tj)];
l Aa = interf[Ga(ti)*cga(tj)];
l AA = interf[Ga(ti)*cGa(tj)];

l vv = interf[gv(ti)*cgv(tj)];
l vV = interf[gv(ti)*cGv(tj)];
l Vv = interf[Gv(ti)*cgv(tj)];
l VV = interf[Gv(ti)*cGv(tj)];

*mixed va
l va = interf[gv(ti)*cga(tj)];
l vA = interf[gv(ti)*cGa(tj)];
l Va = interf[Gv(ti)*cga(tj)];
l VA = interf[Gv(ti)*cGa(tj)];

*mixed av
l av = interf[ga(ti)*cgv(tj)];
l aV = interf[ga(ti)*cGv(tj)];
l Av = interf[Ga(ti)*cgv(tj)];
l AV = interf[Ga(ti)*cGv(tj)];

#message split contribution  vector axial 

b d_,e_,Nc, gs,[Nc^2-1],Prop, Den,Nf, NfV;
.sort
#write <../../../tmp/squared_diagrams/vv/vv_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" vv
#write <../../../tmp/squared_diagrams/vV/vV_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" vV
#write <../../../tmp/squared_diagrams/Vv/Vv_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Vv
#write <../../../tmp/squared_diagrams/VV/VV_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" VV
#write <../../../tmp/squared_diagrams/aa/aa_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" aa
#write <../../../tmp/squared_diagrams/aA/aA_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" aA
#write <../../../tmp/squared_diagrams/Aa/Aa_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Aa
#write <../../../tmp/squared_diagrams/AA/AA_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" AA
#write <../../../tmp/squared_diagrams/va/va_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" va
#write <../../../tmp/squared_diagrams/vA/vA_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" vA
#write <../../../tmp/squared_diagrams/Va/Va_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Va
#write <../../../tmp/squared_diagrams/VA/VA_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" VA
#write <../../../tmp/squared_diagrams/av/av_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" av
#write <../../../tmp/squared_diagrams/aV/aV_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" aV
#write <../../../tmp/squared_diagrams/Av/Av_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Av
#write <../../../tmp/squared_diagrams/AV/AV_diag_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" AV

.end

