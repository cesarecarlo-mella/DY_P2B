off statistics;
#-
#include all_header.h
#include process_header.h



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




*Changes based on NLOOP
*#if 'NLOOP' == 1
*id Shift(k1?, p1?, []) = replace_(k1,p1);
*#elseif 'NLOOP' == 2
*id Shift(k1?, p1?, [], k2?, p2?, []) = replace_(k1,p1,k2,p2);
*#elseif 'NLOOP' == 3
*id Shift(k1?, p1?, [], k2?, p2?, [], k3?, p3?, []) = replace_(k1,p1,k2,p2,k3,p3);
*#endif
*.sort

*#message applied Reduze shifts
*multiply replace_(q, -p1-p2);
*.sort


#include parser.h


#do n = 1,'NDIAG'
#write <tmp/'PROC'_parsed.'NLOOP'.h> "id diag'n' = %e" [diag'n']
#enddo
#message parsed diagrams, written output in tmp/



#include separate_colour.h
#message inserted colour Feynman rules
#include color.h
#call  coloralgebra
.sort




#if 'NDIAG' == 1
g 'PROC'ampl = [diag1];
#elseif 'NDIAG' > 1
g 'PROC'ampl = [diag1] + ... + [diag'NDIAG'];
#endif
.sort



#message building spinlines
#include spinlines.h
.sort



id Spin(1,?x, p2) = Spin(1,?x)*Spin(1,p2);
.sort
repeat;
id Spin(1,?x, nu?)*Spin(1,?p2) = Spin(1,?x)*Spin(1,nu,?p2);
endrepeat;
id Spin(1) = 1;
.sort




b Spin, d_, pQuark, pgluon;
.sort
b Spin, d_, pQuark, pgluon;
#write <tmp/'PROC'_colour_out.'NLOOP'.dat> "l ampl'NLOOP'L = %e" 'PROC'ampl
#message performed colour algebra and written output in tmp/
.sort
#include showlayers.h
.end
#+
