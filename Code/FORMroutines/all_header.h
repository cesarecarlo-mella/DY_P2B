autodeclare s diag, topo,PL, D, polsum, tmp, empty;
autodeclare cf proj, T;
autodeclare s L, S;

***Functions within QGRAF and Reduze output***
s [], cut, lambda, gs, gem, Nc, Nf, NfZ,NfG,NfZext,NfGext,Ef, EfZ,EfGZ, NfGZ,d, [Nc^2-1], eq, s12,s13, s23, m2, u, gA, tag;
cf pol, Prop, prop, v3,v4,v5;
cf G,Z, H, A, gluon, Quark, Qbar, ghost, Ghost, photon,V;
cf Cutgluon, CutQuark, CutQbar, Cutghost, CutGhost, Cutphoton,CutV;
cf DiaMatch, Sector, Shift, Save, INT, BASISLC;
cf Search;
cf C, Ratio;
f Spin, SpinC;
s toC;
i ti=2,tj=2, li=2,lj=2;
i t1=2, t2=2;
cf metric;
cf gv, ga, cgv, cga, eps;

s MONSTER;
s x,n,x1,x2,x3,x4,x5,x6;
s n1,n2,n3,n4;
v mom1,mom2,mom3,mom4,q,vA;
i mu99=d,mu97=d,mu95=d,mu93=d,mu91=d, mu89=d,nu99=d,nu97=d,nu95=d,nu93=d,nu91=d, nu89=d,mu=d,nu=d;
i sigma=d;
i rho1=d,rho2=d,rho3=d,rho4=d,rho5=d,rho6=d,rho8=d;
i omega1=d,omega2=d,omega3=d,omega4=d,omega5=d,omega6=d,omega8=d;
i a200=[Nc^2-1],a110=[Nc^2-1],a103=[Nc^2-1],a102=[Nc^2-1], a101=[Nc^2-1], a100=[Nc^2-1],a99=[Nc^2-1],a97=[Nc^2-1],a95=[Nc^2-1],a93=[Nc^2-1];
i i99=Nc,i97=Nc,i95=Nc,i93=Nc;
t OT, ET;


#do jj = 1,20
i a'jj'=[Nc^2-1], b'jj'=[Nc^2-1], mu'jj'=d, nu'jj'=d, i'jj'=Nc;
s n'jj', x'jj';
#enddo

#do jj = 1,100
i j'jj'=Nc;
#enddo

v k1, k2, k3, p1, p2, p3, q, v, l1, l2, l3, r1, r2, r3;

cf pQuark,pgluon,pghost,T,f(antisymmetric),s(symmetric), Den, Num, CMetric;

cf vQQg,vQQp,vQQV, vggg,vGGg,vgggg,vQQZ, vHgg, vHggg, vHgggg, vAgg, vAggg;

set FRules: pQuark,pgluon,pghost,vQQg,vggg,vGGg,vgggg,vQQZ, vHgg, vHggg, vHgggg, vAgg, vAggg, vQQp;

set PLANARS: PL,PLx12,PLx23,PLx13,PLx123,PLx132;


***Symbols for DY calculation***
s sqrtzu, sqrtziu;

*off statistics;
