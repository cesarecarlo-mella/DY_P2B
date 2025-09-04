off statistics;
#-
#include all_header.h
#include process_header.h
#include invariants.h
#include tmp/Htensor.inc





#message contract with leptonic tensor
#include external/LeptonicCurrents/L'PROJ'.inc
l HLcontracted = Had*L'PROJ';
.sort
id Prop(v?) = Den(v.v);
id Prop(cut,v?) = Den(cut,v.v);
id Prop(cut, v?, m2?) = Den(cut, v.v, m2);
.sort

#call kin4point
#call onshell
#call onshellRadiation
.sort


Drop;
Ndrop HLcontracted;
.sort



#message collect denominators
l DenCollector = HLcontracted*tag;
b Den, tag;
.sort
Collect Num;
id tag*Num(?x) = 1;
repeat;
id Den(?x)*Den(?y) = Den(?x,tag, ?y);
endrepeat;
.sort
b Den, tag;
P DenCollector;
.sort
.end
