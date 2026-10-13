off statistics;
#-
#include all_header.h
#include ../../../process_header.h
#include invariants.h




#message square
#include ../../../tmp/parsed_diagrams/groups/sum_'loopind'_'PROC'_'NLOOP'.dat
#include ../../../tmp/parsed_diagrams/groups/Csum_'loopind2'_'PROC'_'NLOOP'.dat


l interf = (diagsum'loopind')*(Cdiagsum'loopind2');
.sort
Drop;
NDrop interf;


#if 'ONLYVECTOR' > 0
id ga(?x) = 0;
#endif




.sort
#message combine spinlines
id Spin(1,p1?,?x, p2?)*SpinC(1,p2?, ?y, p1?) = g_(1,p1,?x, p2, ?y);
id Spin(1,p1?,?x, p2?)*Spin(2,?z)*SpinC(1,p2?, ?y, p1?) = g_(1,p1,?x, p2, ?y)*Spin(2,?z);
id Spin(2,p1?,?x, r1?)*SpinC(2,r1?, ?y, p1?) = g_(2,p1,?x, r1, ?y);
id Spin(1,p1?,?x, p2?)*Spin(2,?z)*SpinC(1,p2?, ?y, p3?) = Spin(1,p1,?x, p2, ?y,p3)*Spin(2,?z);
id Spin(1,p1?,?x, p2?)*Spin(2,p2?,?y, p3?)*SpinC(2,p3?,?z, p1?)= g_(1,p1,?x, p2, ?y,p3,?z);
.sort


* probably want to change this
#if 'LC' > 0
id Nc^-1=0;
id Nc^-3 =0;
#endif


#message do again color algebra for external color structures
#message color again
#include color.h
#call coloralgebra
.sort


* probably want	to change this
s NC4;
s colfake;
#if 'LC' > 0
multiply colfake;
id Nc^4*colfake = NC4;
id colfake = 0;
#endif
id NC4 = Nc^4;
.sort


b gs,Nc,[Nc^2-1], pol,ga,gv,cga,cgv,eps,pQuark,g_;
.sort




#message traces and contractions
id eps(?x) = e_(?x);
.sort

#message doing traces now 

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
******* UPDATE THIS!!! ******
#call kin6point
#call onshellRadiation
#call onshell
.sort

#message generated Hadronic tensor

id NfExt = Nf;
id NfVExt = NfV;
.sort

b cga,ga,cgv,gv;
.sort
l aa = interf[ga(ti)*cga(tj)];
l vv = interf[gv(ti)*cgv(tj)];
l va = interf[gv(ti)*cga(tj)];
l av = interf[ga(ti)*cgv(tj)];
b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv, Nf, NfV;
.sort

b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv, Nf, NfV;
.sort
#write <../../../tmp/squared_diagrams/vv/vv_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" vv
#write <../../../tmp/squared_diagrams/aa/aa_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" aa
#write <../../../tmp/squared_diagrams/va/va_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" va
#write <../../../tmp/squared_diagrams/av/av_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" av
.end




*b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
*.sort
*#write <tmp/Htensor.inc> "L Had=%e" interf
*.end

