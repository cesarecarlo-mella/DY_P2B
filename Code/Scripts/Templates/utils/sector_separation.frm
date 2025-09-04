#-
#include all_header.h
#include ./process_header.h


g ampl = L'LAYER'diag1 + ... + L'LAYER'diag'NDIAG';
.sort


#include ./tmp/layers/'LAYER'/partial_amp.inc
.sort

id Sector(x1?, x2?, x3?) = Sector(x1,x3);
.sort

#include tmp/sector_list/'FAMILY'.'NLOOP'.inc
.sort
.end 
#+