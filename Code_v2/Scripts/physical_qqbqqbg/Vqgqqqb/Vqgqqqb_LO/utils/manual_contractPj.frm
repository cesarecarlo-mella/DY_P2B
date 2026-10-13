
off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h



#include tmp/unreduced/vv/HLcontracted1_matched.m


id Den(2)=1/2;
.sort
*b TOPO,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,DD12,DD13,DD14,DD15,DD16,DD17,DD18,DD19,DD20,DD21,DD22,DD23,gs, cgv, gv, cga, ga, Nc, NfV;
*.sort


#message reconstruct ints
#include ./tmp/fams/reconstruct.inc
.sort

b TOPO,[Nc^2-1],INT,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,DD1,DD2,DD3,DD4,DD5,DD6,DD7,DD8,DD9,DD10,DD11,DD12,DD13,DD14,DD15,DD16,DD17,DD18,DD19,DD20,DD21,DD22,DD23,gs, cgv, gv, cga, ga, Nc, NfV;
.sort
#write <tmp/unreduced/vv/unreduced'PROJ'_reconstructed.ff> "id HLcontracted = %e" HLcontracted;

#message rational simplification
b sqrtzu, sqrtziu,INT, [Nc^2-1],gs, cgv, gv, cga, ga, Nc,Num,Den,e_, Nf, NfV;
.sort
#include ratfun.h
.sort


b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <tmp/unreduced/vv/unreduced'PROJ'.ff> "id HLcontracted = %e" HLcontracted;
id [Nc^2-1] = (Nc^2-1);
.sort
format mathematica;
b sqrtzu, sqrtziu,Sector,INT, gs, cgv, gv, cga, ga, Nc;
.sort
#write <tmp/unreduced/vv/unreduced'PROJ'.m> " HLcontracted = (%E)" HLcontracted;
.end

