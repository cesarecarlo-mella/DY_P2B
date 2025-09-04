off statistics;
#-
#include all_header.h
#include process_header.h


*#include ./tmp/'PROC'_colour_out.'NLOOP'.dat


#message include diagrams
#do loopind=1,'NDIAG'
#include ./tmp/parsed_diagrams/diag'loopind'_'PROC'_colour_out.'NLOOP'.dat
#enddo
.sort


#message include output of colour_algebra and compute complex conjugated


#do ii=1,100
#do jj =1,100
id T(a1?, i'ii', i'jj') = T(a1,ii'jj', ii'ii');
id T(a1?, i'ii', j'jj') = T(a1, jj'jj', ii'ii');
id T(a1?, j'ii', j'jj') = T(a1, jj'jj', jj'ii');
id T(a1?, j'ii', i'jj') = T(a1, ii'jj', jj'ii');
id T(a1?, ii99,ii1?) = T(a1, i99 , ii1);
id T(a1?, ii97,ii1?) = T(a1, i97,ii1);
id T(a1?, ii1?, ii99) = T(a1, ii1,i99);
id T(a1?, ii1?, ii97) = T(a1, ii1, i97);
#enddo
#enddo

.sort



argument Spin, eps, pgluon, pQuark, pol, vggg, vgggg;
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
id gluon(mu91,r2,a91) = Cutgluon(nu91,r2,a91);
endargument;
.sort



*complex conjugate of couplings
id gv(ti) = cgv(tj);
id ga(ti) = cga(tj);
.sort

#message revert spins
id Spin(1,?x, p2) = Spin(1,?x)*SpinC(1,p2);
.sort
repeat;
id Spin(1,?x, nu?)*SpinC(1,?p2) = Spin(1,?x)*SpinC(1,?p2, nu);
endrepeat;
id Spin(1) =1;
.sort

*id eps(?x) =tag*eps(?x);
id eps(?x) = - eps(?x);
id i_ = -i_;
.sort

#do loopind=1,'NDIAG'
b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
.sort
b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
#write <tmp/parsed_diagrams/Cdiag'loopind'_'PROC'_colour_out.'NLOOP'.dat> "l [Cdiag'loopind'] = %e" [diag'loopind']
.sort
#enddo

.end


b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
.sort
b SpinC, i_, pgluon, pQuark, gem, T, f, s, pol, Nc, Nf, NfZ, NfG, NfGext, NfZext;
#write <tmp/C'PROC'_colour_out.'NLOOP'.dat> "l Campl'NLOOP'L = %e" ampl'NLOOP'L
#message performed sum and written in tmp/
.end







