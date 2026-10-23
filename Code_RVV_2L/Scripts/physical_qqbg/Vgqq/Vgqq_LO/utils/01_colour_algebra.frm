off statistics;
#-
#include all_header.h
#include process_header.h

#message Including diagrams

#if 'NLOOP' > 0
#do n = 1,'NDIAG'
g [diag'n'] = diag'n';
#enddo
#else
#do n = 1,'NDIAG'
g [diag'n'] = diag'n';
#enddo
#endif


#include ./external/'PROC'.'NLOOP'.inc
#message loaded QGRAF diagram
.sort
#if 'NLOOP' == 2
* two-loop set: per diagram the loop-momentum shift onto its family (PL, NPL and crossings) and the family tag
* L2F(f) (Reduze find_diagram_shifts, checked: Families/rvv2l_shifts.py -> external/PROC.2L_shifts.inc)
#include ./external/'PROC'.2L_shifts.inc
.sort
#endif


#message include parser: manipulating QGRAF output
#include parser.h


#do n = 1,'NDIAG'
#write <tmp/'PROC'_parsed.'NLOOP'.h> "id diag'n' = %e" [diag'n']
#enddo
#message parsed diagrams, written output in tmp/




#include separate_colour.h
#message inserted colour Feynman rules
#include color.h
#call coloralgebra
*P;
*.end
.sort
#message done color algebra


#do n = 1,'NDIAG'
g diagN'n' = [diag'n'];
.sort
#enddo



*#if 'NDIAG' == 1
*g 'PROC'ampl = [diag1];
*#elseif 'NDIAG' == 2
*g 'PROC'ampl = [diag1]+[diag2];
*#elseif 'NDIAG' > 2
*g 'PROC'ampl = diagN1 + ... + diagN'NDIAG';
*g 'PROC'ampl = diagN1;
*#endif
*.sort

#message building spinlines
#include spinlines.h
.sort
id Spin(1,?x, p2?) = Spin(1,?x)*Spin(1,p2);
.sort
repeat;
id Spin(1,?x, nu?)*Spin(1,?p2) = Spin(1,?x)*Spin(1,nu,?p2);
endrepeat;
id Spin(1) = 1;
.sort


id Spin(2,?x, p2?) = Spin(2,?x)*Spin(2,p2);
.sort
repeat;
id Spin(2,?x, nu?)*Spin(2,?p2) = Spin(2,?x)*Spin(2,nu,?p2);
endrepeat;
id Spin(2) = 1;
.sort

* closed quark loop of the one-loop amplitude (spinlines.h): the same moves, which also split the momentum sums
* (e.g. k1-r1-r2) into single vectors, as g_ in step 04 needs; the order is kept
id Spin(3,?x, nu?) = Spin(3,?x)*Spin(3,nu);
.sort
repeat;
id Spin(3,?x, nu?)*Spin(3,?p2) = Spin(3,?x)*Spin(3,nu,?p2);
endrepeat;
id Spin(3) = 1;
.sort
* second closed quark loop (two-loop amplitudes), the same
id Spin(4,?x, nu?) = Spin(4,?x)*Spin(4,nu);
.sort
repeat;
id Spin(4,?x, nu?)*Spin(4,?p2) = Spin(4,?x)*Spin(4,nu,?p2);
endrepeat;
id Spin(4) = 1;
.sort




#do loopind=1,'NDIAG'
b Spin, d_, pQuark, pgluon,T;
.sort
b Spin, d_, pQuark, pgluon,T;
#write <tmp/parsed_diagrams/diag'loopind'_'PROC'_colour_out.'NLOOP'.dat> "l [diag'loopind'] = %e " [diag'loopind']
.sort
#enddo

#message performed colour algebra and built spinlines and  written output in tmp/parsed_diag
#message show now color layers
#include showlayers.h

.end





#+
