off statistics;
#-
#include all_header.h
#include process_header.h


#message include diagrams
#do loopind=1,{&ngroups}
#include ./tmp/parsed_diagrams/groups/sum_'loopind'_'PROC'_'NLOOP'.dat
#enddo
.sort

*already included once, do not include again. Distinguish between external and internal Nf. Internal Nf gets squared!
id NfExt =1 ;
id NfVExt =1;
.sort

#message include output of colour_algebra and compute complex conjugated


* Complex conjugate of the colour factors: transpose every T exactly once, ((T^a)_{xy})* = (T^a)_{yx}, then give the
* conjugate's internal quark colour indices new names (i -> ii, j -> jj); the external ones (i99 ... i89) are shared
* with the amplitude. (The former 100 x 100 loop transposed a T with two external indices twice, i.e. not at all.)
id T(a1?, i1?, i2?) = T(a1, i2, i1);
.sort
multiply replace_(i1,ii1, j1,jj1
#do k = 2,88
, i'k',ii'k', j'k',jj'k'
#enddo
);

id a200 = aa200;
id a110 = aa110;
id a103 = aa103;
id a102 = aa102;
id a101 = aa101;
id a100 = aa100;

#do jj = 1,100
id a'jj' = aa'jj';
#enddo
.sort

id aa99 = a99;
id aa97 = a97;
id aa95 = a95;
id aa93 = a93;
id aa91 = a91;
id aa89 = a89;
.sort



argument Spin, eps, pgluon, pQuark, pol, vggg, vgggg, vGGg, pghost;
#do counter = 1,20
id mu'counter'= nu'counter';
#enddo
id mu99 = nu99;
id mu97 = nu97;
id mu95 = nu95;
id mu93 = nu93;
id mu91 = nu91;
id mu89 = nu89;
id rho1 =omega1;
id rho2 =omega2;
id rho3 =omega3;
id rho4 =omega4;
id rho5 =omega5;
id gluon(mu99,v?,a99) = gluon(nu99,v,a99);
id gluon(mu97,v?,a97) = gluon(nu97,v,a97);
id V(mu95,q) = CutV(nu95, q);
id gluon(mu93,r1,a93) = Cutgluon(nu93,r1,a93);
id gluon(mu89,r3,a89) = Cutgluon(nu89,r3,a89);
id gluon(mu91,r2,a91) = Cutgluon(nu91,r2,a91);
id Qbar(93,r1,i93?) = CutQbar(93,r1,i93);
id Qbar(91,r2,i91?) = CutQbar(91,r2,i91);
id Quark(93,r1,i93?) = CutQuark(93,r1,i93);
id Quark(91,r2,i91?) = CutQuark(91,r2,i91);
id Qbar2(93,r1,i93?) = CutQbar2(93,r1,i93);
id Qbar2(91,r2,i91?) = CutQbar2(91,r2,i91);
id Quark2(93,r1,i93?) = CutQuark2(93,r1,i93);
id Quark2(91,r2,i91?) = CutQuark2(91,r2,i91);
id Qbar(89,r3,i89?) = CutQbar(89,r3,i89);
id Quark(89,r3,i89?) = CutQuark(89,r3,i89);
id Qbar2(89,r3,i89?) = CutQbar2(89,r3,i89);
id Quark2(89,r3,i89?) = CutQuark2(89,r3,i89);
* final-state ghosts (after parser.h: ghost(p,a), no node number)
id ghost(r1,a93) = Cutghost(r1,a93);
id ghost(r2,a91) = Cutghost(r2,a91);
id ghost(r3,a89) = Cutghost(r3,a89);
id Ghost(r1,a93) = CutGhost(r1,a93);
id Ghost(r2,a91) = CutGhost(r2,a91);
id Ghost(r3,a89) = CutGhost(r3,a89);
endargument;
.sort



*complex conjugate of couplings
id gv(ti) = cgv(tj);
id ga(ti) = cga(tj);
id Gv(ti) = cGv(tj);
id Ga(ti) = cGa(tj);
id Vline(n1?) = cVline(n1);
.sort

#message revert spins
id Spin(1,?x, p2?) = Spin(1,?x)*SpinC(1,p2);
.sort
repeat;
id Spin(1,?x, nu?)*SpinC(1,?p2) = Spin(1,?x)*SpinC(1,?p2, nu);
endrepeat;
id Spin(1) =1;
.sort


#message revert spins 2
id Spin(2,?x, p2?) = Spin(2,?x)*SpinC(2,p2);
.sort
repeat;
id Spin(2,?x, nu?)*SpinC(2,?p2) = Spin(2,?x)*SpinC(2,?p2, nu);
endrepeat;
id Spin(2) =1;
.sort

id eps(?x) = - eps(?x);
id i_ = -i_;
.sort

* 1L x 1L: the conjugate is a one-loop amplitude. Its loop momentum is k2 (the amplitude keeps k1); its closed
* quark loop, the trace Spin(3,...), becomes SpinC(3, reversed arguments): Tr(g1...gn)^* = Tr(gn...g1) (the
* Larin eps changed sign above, with i_); V on that loop gets the conjugate couplings cgvPS, cgaPS.
multiply replace_(k1,k2);
id Spin(3,?x) = SpinC(3,reverse_(?x));
id gvPS(ti) = cgvPS(tj);
id gaPS(ti) = cgaPS(tj);
.sort

* Spin sums of final-state quarks/antiquarks: QGRAF momenta are incoming, so an outgoing (anti)quark with label r has
* physical momentum -r and spin sum -r-slash, while the chain contains r-slash: factor -1 per final-state quark end
* (old code: id Spin(1) = (-1)^('INITFIN'), INITFIN = 1 for one initial-final line).
id pol(CutQuark(?a)) = -pol(CutQuark(?a));
id pol(CutQbar(?a)) = -pol(CutQbar(?a));
id pol(CutQuark2(?a)) = -pol(CutQuark2(?a));
id pol(CutQbar2(?a)) = -pol(CutQbar2(?a));
.sort

#do loopind = 1,{&ngroups}
b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
.sort
b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
#write <tmp/parsed_diagrams/groups/Csum_'loopind'_'PROC'_'NLOOP'.dat> "l Cdiagsum'loopind' = %e" diagsum'loopind'
#enddo
.sort

.end









