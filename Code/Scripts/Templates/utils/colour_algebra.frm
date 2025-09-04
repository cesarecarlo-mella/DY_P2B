#-
#include all_header.h
#include process_header.h

#if 'NLOOP' > 0
#do n = 1,'NDIAG'
g [diag'n'] = diag'n'*DiaMatch('n');
#enddo
#else
#do n = 1,'NDIAG'
g [diag'n'] = diag'n'*Sector(TREE, 1);
#enddo
#endif

#include ./external/'PROC'.'NLOOP'.inc
#message loaded QGRAF diagram
 
#if 'NLOOP' > 0 
#include ./external/'PROC'.'NLOOP'.shifts.inc
#endif

.sort

*Changes based on NLOOP
#if 'NLOOP' == 1
id Shift(k1?, p1?, []) = replace_(k1,p1);
#elseif 'NLOOP' == 2
id Shift(k1?, p1?, [], k2?, p2?, []) = replace_(k1,p1,k2,p2);
#elseif 'NLOOP' == 3
id Shift(k1?, p1?, [], k2?, p2?, [], k3?, p3?, []) = replace_(k1,p1,k2,p2,k3,p3);
#endif
.sort

#message applied Reduze shifts
multiply replace_(q, -p1-p2-p3);
.sort
 
#include parser.h

b Sector;
.sort

#do n = 1,'NDIAG'
#write <tmp/'PROC'_parsed.'NLOOP'.h> "id diag'n' = %e" [diag'n']
#enddo
#message parsed diagrams, written output in tmp/


#include separate_colour.h
#message inserted colour Feynman rules
#include color.h


#call  coloralgebra
.sort
#include spinlines.h
b Sector, i_, gs, gem, lambda, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGZ;
.sort
#do n = 1,'NDIAG'
#write <tmp/colour_out.'NLOOP'.dat> "diag'n' = %e" [diag'n']
#enddo
#message performed colour algebra and written output in tmp/

#include showlayers.h
.end
#+
