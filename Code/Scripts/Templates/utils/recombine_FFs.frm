#-
#include all_header.h
#include process_header.h

#do i=1,'NPROJ'
l FF'i' =
#do j=1,'NPROJ'
+C('i','j')*T'j'
#enddo
;
#enddo
.sort

#include projectors/'PROC'/proj_coeff.inc
#message Recombine FFs in layer 'LAYER': Including projector coefficients from projectors/'PROC'/proj_coeff.inc
.sort

#do i=1,'NPROJ'
#include tmp/layers/'LAYER'/'DESTINATION'/FF'i'/'FILENAME'
#enddo
#message Recombine FFs in layer 'LAYER': Including form factors from tmp/layers/'LAYER'/'DESTINATION'

b gem,Tr, f, Den,i_, gs, lambda, Num,s, Ratio,T,eq,Sector,INT,C,Den,Num;
.sort
#if 'POLYRATFUN' == 1
#message Recombine FFs in layer 'LAYER': Simplifying with Polyratfun
#include ratfun.h
#endif
.sort


#do i=1,'NPROJ'
#if 'NLOOP' > 0
#opendictionary mth
#add pi_: "Pi"
#add i_: "I"
#add Z: "Zeta"
#closedictionary mth
#usedictionary mth
#closedictionary mth
format mathematica;
b T,lambda,s,f,gs,eq,INT,Den,Num, BASISLC,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13;
.sort
#write <tmp/layers/'LAYER'/'DESTINATION'/FF'i'/'FILENAME'> "(%E)" FF'i';
#else
#opendictionary mth
#add pi_: "Pi"
#add i_: "I"
#add Z: "Zeta"
#closedictionary mth
#usedictionary mth
#closedictionary mth
format mathematica;
b T,lambda,s,f,gs,eq,INT,Den,Num, BASISLC;
.sort
#write <tmp/layers/'LAYER'/'DESTINATION'/FF'i'/'FILENAME'> "%e" FF'i';
#endif
#enddo
#message Recombine FFs in layer 'LAYER': Finished recombining form factors
.end
#+
