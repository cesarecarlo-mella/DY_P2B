off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h



#include tmp/squared_diagrams/vv/vv_'loopind1'_'loopind2'.inc
.sort
id Prop(v?) = Den(v);
id Prop(cut,v?) = Den(cut,v);
id Prop(cut, v?, m2?) = Den(cut, v, m2);
.sort
*id Nc=0;
id Nc^-1=1;
id gs=1;
id d=3;
.sort

Drop;
Ndrop [interf'loopind1'_'loopind2'];
.sort
*P;
*.end



#message collect denominators
l DenCollector = [interf'loopind1'_'loopind2']*tag;
b Den, tag;
.sort
Collect Num;
Drop;
Ndrop DenCollector;

id tag*Num(?x) = 1;
repeat;
id Den(?x)*Den(?y) = Den(?x,tag, ?y);
endrepeat;
.sort
b Den, tag;
format mathematica;

P;
b Den,tag;
.sort
#write <./tmp/den/den_'loopind1'_'loopind2'.m> " Den'loopind1'vs'loopind2' = {(%E)};" DenCollector
.end
