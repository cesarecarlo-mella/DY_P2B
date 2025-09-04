off statistics;
#-
#include all_header.h
#include process_header.h


#include ./tmp/'PROC'_colour_out.'NLOOP'.dat


#message include output of colour_algebra and compute complex conjugated


id T(a1?, i1?, i2?) = T(a1,i2,i1);
.sort
argument Spin, eps, pgluon, pQuark, pol;
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
* can I just add all of them?
id gluon(mu99,p1,a99) = gluon(nu99,p1,a99);
id gluon(mu97,p2,a97) = gluon(nu97,p2,a97);
* final state now
id V(mu95,q) = CutV(nu95, q);
id gluon(mu93,r1,a93) = Cutgluon(nu93,r1,a93);
id Qbar(93,r1,i93) = CutQbar(93,r1,i93);
endargument;
.sort



*complex conjugate of couplings
id gv(ti) = cgv(tj);
id ga(ti) = cga(tj);
.sort

#message revert spins
id Spin(1,?x, p2?) = Spin(1,?x)*SpinC(1,p2);
.sort
repeat;
id Spin(1,?x, nu?)*SpinC(1,?p2) = Spin(1,?x)*SpinC(1,?p2, nu);
endrepeat;
id Spin(1) =(-1)^('INITFIN');
.sort

*id eps(?x) =tag*eps(?x);
id eps(?x) = - eps(?x);
id i_ = -i_;
.sort



b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
.sort
b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
#write <tmp/C'PROC'_colour_out.'NLOOP'.dat> "l Campl'NLOOP'L = %e" ampl'NLOOP'L
#message performed sum and written in tmp/
.end







