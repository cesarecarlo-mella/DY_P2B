#-
#include all_header.h
#include process_header.h

#do n = 1,'NDIAG'
g [diag'n'] = diag'n';
#enddo

#include tmp/mom2words_out.'NLOOP'.inc

b Nc, Nf, NfZ, NfG, NfGZ;
.sort

#do n = 1,'NDIAG'
l L'LAYERNAME'diag'n' = [diag'n']['LAYER'];
#enddo

.sort

#message colour layer 'LAYERNAME' separated out in all 'NDIAG' diagrams

#do n = 1,'NDIAG'
#write <tmp/layers/'LAYERNAME'/partial_amp.inc> "id L'LAYERNAME'diag'n' = %e" L'LAYERNAME'diag'n';
#enddo
.end
#+