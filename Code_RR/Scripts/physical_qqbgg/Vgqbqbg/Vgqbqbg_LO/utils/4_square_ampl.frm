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
id Ga(?x) = 0;
#endif

* SKIPAA (default 1): aa = vv and a2a2 = v2v2 (axial x axial on the same quark line equals vector x vector); the
* intermediate aa traces (Larin scheme) are very expensive, so by default these pieces are not computed (written as 0;
* take them from vv / v2v2 when combining). -d SKIPAA=0 computes them. The mixed aa2, a2a are always computed.
#ifndef 'SKIPAA'
#define SKIPAA "1"
#endif
#if 'SKIPAA' > 0
id ga(ti)*cga(tj) = 0;
id Ga(ti)*cGa(tj) = 0;
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




* Feynman rules (propagators, vertices, polarisation sums) before the traces: the d_ from the polarisation
* sums and gluon propagators then contract indices inside the traces (much faster than tracing with open indices)
#message now include feynman rules
#include feynman_rules.h
if ( count(pol,1) > 0 ) exit "4_square_ampl.frm: external leg without a polarisation/cut rule in feynman_rules.h";
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

******* UPDATE THIS!!! ******
#call kin5point
#call onshellRadiation
#call onshell
.sort

#message generated Hadronic tensor

id NfExt = Nf;
id NfVExt = NfV;
.sort

* Split by couplings: amplitude gv, ga (V on the q line) or Gv, Ga (V on the Q2 line), times
* conjugate cgv, cga or cGv, cGa. Name = amplitude coupling + conjugate coupling, v a v2 a2 (v2, a2 = Gv, Ga).
* All 16 are written (0 when the combination does not occur, e.g. v2.. without a Q2 line).
* Expressions are called X<name> (aa2 etc. are colour indices in all_header.h); files keep <name>.
b gv, ga, Gv, Ga, cgv, cga, cGv, cGa;
.sort
l Xvv = interf[gv(ti)*cgv(tj)];
l Xva = interf[gv(ti)*cga(tj)];
l Xvv2 = interf[gv(ti)*cGv(tj)];
l Xva2 = interf[gv(ti)*cGa(tj)];
l Xav = interf[ga(ti)*cgv(tj)];
l Xaa = interf[ga(ti)*cga(tj)];
l Xav2 = interf[ga(ti)*cGv(tj)];
l Xaa2 = interf[ga(ti)*cGa(tj)];
l Xv2v = interf[Gv(ti)*cgv(tj)];
l Xv2a = interf[Gv(ti)*cga(tj)];
l Xv2v2 = interf[Gv(ti)*cGv(tj)];
l Xv2a2 = interf[Gv(ti)*cGa(tj)];
l Xa2v = interf[Ga(ti)*cgv(tj)];
l Xa2a = interf[Ga(ti)*cga(tj)];
l Xa2v2 = interf[Ga(ti)*cGv(tj)];
l Xa2a2 = interf[Ga(ti)*cGa(tj)];
.sort
* completeness: the 16 pieces times their couplings give back interf exactly
l check = interf
   - gv(ti)*cgv(tj)*Xvv
   - gv(ti)*cga(tj)*Xva
   - gv(ti)*cGv(tj)*Xvv2
   - gv(ti)*cGa(tj)*Xva2
   - ga(ti)*cgv(tj)*Xav
   - ga(ti)*cga(tj)*Xaa
   - ga(ti)*cGv(tj)*Xav2
   - ga(ti)*cGa(tj)*Xaa2
   - Gv(ti)*cgv(tj)*Xv2v
   - Gv(ti)*cga(tj)*Xv2a
   - Gv(ti)*cGv(tj)*Xv2v2
   - Gv(ti)*cGa(tj)*Xv2a2
   - Ga(ti)*cgv(tj)*Xa2v
   - Ga(ti)*cga(tj)*Xa2a
   - Ga(ti)*cGv(tj)*Xa2v2
   - Ga(ti)*cGa(tj)*Xa2a2
;
.sort
#if termsin(check) > 0
#message ERROR: terms of interf with an unexpected coupling structure (see check)
print check;
.sort
#terminate
#endif
Drop interf, check;
b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv, Gv, Ga, cGv, cGa, Nf, NfV;
.sort
#write <../../../tmp/squared_diagrams/vv/vv_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xvv
#write <../../../tmp/squared_diagrams/va/va_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xva
#write <../../../tmp/squared_diagrams/vv2/vv2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xvv2
#write <../../../tmp/squared_diagrams/va2/va2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xva2
#write <../../../tmp/squared_diagrams/av/av_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xav
#write <../../../tmp/squared_diagrams/aa/aa_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xaa
#write <../../../tmp/squared_diagrams/av2/av2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xav2
#write <../../../tmp/squared_diagrams/aa2/aa2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xaa2
#write <../../../tmp/squared_diagrams/v2v/v2v_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xv2v
#write <../../../tmp/squared_diagrams/v2a/v2a_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xv2a
#write <../../../tmp/squared_diagrams/v2v2/v2v2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xv2v2
#write <../../../tmp/squared_diagrams/v2a2/v2a2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xv2a2
#write <../../../tmp/squared_diagrams/a2v/a2v_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xa2v
#write <../../../tmp/squared_diagrams/a2a/a2a_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xa2a
#write <../../../tmp/squared_diagrams/a2v2/a2v2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xa2v2
#write <../../../tmp/squared_diagrams/a2a2/a2a2_'loopind'_'loopind2'.inc> "l [interf'loopind'_'loopind2']=%e" Xa2a2
.end




*b d_,e_,Nc, gs,[Nc^2-1],Prop, Den, ga, cga, gv, cgv;
*.sort
*#write <tmp/Htensor.inc> "L Had=%e" interf
*.end

