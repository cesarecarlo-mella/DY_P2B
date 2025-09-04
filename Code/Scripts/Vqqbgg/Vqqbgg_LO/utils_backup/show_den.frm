off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h



#include tmp/squared_diagrams/vv/vv_diag_'loopind1'_'loopind2'.inc
.sort
id Prop(v?) = Den(v);
id Prop(cut,v?) = Den(cut,v);
id Prop(cut, v?, m2?) = Den(cut, v, m2);
.sort


Drop;
Ndrop [interf'loopind1'_'loopind2'];
.sort


#message collect denominators
l DenCollector = [interf'loopind1'_'loopind2']*tag;
b Den, tag;
.sort
Collect Num;
id tag*Num(?x) = 1;
repeat;
id Den(?x)*Den(?y) = Den(?x,tag, ?y);
endrepeat;
.sort
b Den, tag;
format mathematica;
b Den,tag;
.sort
#write <./tmp/den/den_'loopind1'_'loopind2'.m> " Den'loopind1'vs'loopind2' = {(%E)};" DenCollector
.end
