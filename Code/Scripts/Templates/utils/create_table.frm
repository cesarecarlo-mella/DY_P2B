#-
#include all_header.h
#include ./process_header.h

TableBase "'TABLEFILE'" create;
#message Create table script: Writing a TableBase into 'TABLEFILE'

Table,sparse,NewINT('NEWINTNO');
#include 'REDUCTIONFILE'
.sort
#message Create table script: Identities from 'REDUCTIONFILE'

TableBase "'TABLEFILE'" addto NewINT;
.end
#+