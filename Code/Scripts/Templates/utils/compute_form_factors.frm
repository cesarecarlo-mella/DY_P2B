#-
#include all_header.h
#include process_header.h


l expr = L'LAYER''SECTOR';
#message  sector 'SECTOR', layer 'LAYER': Starting script
#include tmp/layers/'LAYER'/sector_separated/'FAMILY'/'SECTOR'.'NLOOP'.sect
.sort
*b Sector, i_, gs, lambda, eq, T, f, s, pol, Nc, Nf, NfZ, pol;
*#write <tmp/sector_separated_spinlines/'LAYER'/'SECTOR'_spinlines_out.2.dat> "id L'LAYER''SECTOR' = %e" expr;
*.sort
#message  sector 'SECTOR', layer 'LAYER': Inserting Feynman rules
#include feynman_rules.h
.sort
#if 'NLOOP' > 0
#include tmp/prop_substitutions/'FAMILY'.inc
.sort
#endif
id Prop(p1?) = Den(p1.p1);
.sort
argument Den;
#include tmp/words2moms/complete.inc
endargument;
.sort

#include invariants.h
argument Den;
#call subinvariants
endargument;


b Sector, i_, gs, lambda, eq, T, f, s, Nc, Nf, NfZ, Den,D1,...,D15,G;
.sort
#write <tmp/layers/'LAYER'/after_feynrules/'FAMILY'/'SECTOR'_feynrules_out.'NLOOP'.dat> "id L'LAYER''SECTOR' = %e" expr;


*this simplifies a little
#include pol_sum.h
#call gaugechoice'PROC'
.sort

#do ii = 1, 'NPROJ'
g FF'ii' = proj'ii'*expr;
#include projectors/'PROC'/proj.inc
.sort
#enddo

Drop;
NDrop FF1,...,FF'NPROJ';
.sort

id G(?x) = g_(?x);
.sort
#message  sector 'SECTOR', layer 'LAYER': Tracing
tracen,1;
tracen,2;
tracen,3;
tracen,4;
tracen,5;
contract;

.sort
#message  sector 'SECTOR', layer 'LAYER': Inserting polarisation sum
#call polsum'PROC'
.sort

#call onshell
antibracket Sector,C, T, f, i_, gs, lambda, eq, Den, D1, ..., D'NPROP';
.sort
keep brackets;
#message sector 'SECTOR', layer 'LAYER': Substituting words with momenta
#include tmp/words2moms/minus_signs.inc
.sort
#include tmp/words2moms/EXT.inc
.sort
#include tmp/words2moms/'FAMILY'.inc

b Sector,C, T, f, i_, gs, lambda, eq, Den, D1, ..., D'NPROP',p1,p2,p3;
.sort 
keep brackets;
#message  sector 'SECTOR', layer 'LAYER': Substituting Mandelstam invariants
#call subinvariants
b Sector,C, T, f, i_, lambda, gs, eq, Den, D1,...,D'NPROP',k1,k2,k3;
.sort 
#message  sector 'SECTOR', layer 'LAYER': Inserting relations for ISPs
keep brackets;
#include tmp/ISP/'FAMILY'.inc

.sort
id Sector(PL?,x?)/<D1^n1?>/.../<D'NPROP'^n'NPROP'?> = INT(PL,n1,...,n'NPROP');
.sort

#if 'NLOOP' == 0
id INT(?x) = 1;
#else
#call reconstruction
#endif

b INT;
.sort 
keep brackets;
#message  sector 'SECTOR', layer 'LAYER': Killing zero sectors
#include tmp/zeros/zeros'FAMILY'.inc
.sort
id INT('FAMILY',n1?,[],?x) = INT('FAMILY',?x);


b Sector, T,lambda,s, f, i_, d_, e_,gs,eq,INT,C,Den,Num;
.sort
#message  sector 'SECTOR', layer 'LAYER': Simplifying with Polyratfun
#include ratfun.h
.sort

#include mathdictionary.h

#do ii = 1, 'NPROJ'
b Sector, T,lambda,gs,s, f, i_,INT,Num,Den,eq, gA, e_;
.sort
#if 'NLOOP' > 0
#write <tmp/layers/'LAYER'/form_factors/FF'ii'/L'LAYER''SECTOR'.ff> "id L'LAYER''SECTOR' = %e" FF'ii';
#else
#write <tmp/layers/'LAYER'/ampl/FF'ii'/S1.ff> "id S1 = %e" FF'ii';
#endif
*#usedictionary mth
*format mathematica;
*#write <tmp/layers/'LAYER'/form_factors/FF'ii'/L'LAYER''SECTOR'.ff> "%e" FF'ii';
*#endif
#enddo
#message  sector 'SECTOR', layer 'LAYER': Ending script
.end
#+