autodeclare s diag, topo,PL, D,DD, polsum, tmp, empty;
autodeclare cf proj, T;
autodeclare s L, S;

***Functions within QGRAF and Reduze output***
s [], cut, lambda, gs, gem, Nc, Nf, NfZ,NfV,NfExt, NfVExt, NfG,NfZext,NfGext,Ef, EfZ,EfGZ, NfGZ,d, [Nc^2-1], eq, s12,s13, s23, m2, u, gA, tag;
cf pol, Prop, prop, v3,v4,v5, fD;
cf G,Z, H, A, gluon, Quark, Qbar, ghost, Ghost, photon,V, Quark2, Qbar2;
cf Cutgluon, CutQuark, CutQbar,CutQuark2, CutQbar2, Cutghost, CutGhost, Cutphoton,CutV;
cf DiaMatch, Sector, Shift, Save, INT, BASISLC, TOPO;
cf Search;
cf C, Ratio;
f Spin, SpinC;
s toC;
i ti=2,tj=2, li=2,lj=2;
i t1=2, t2=2;
cf metric;
cf gv, ga, cgv, cga, eps, Gv, Ga, cGv, cGa;

s MONSTER;
s x,n,x1,x2,x3,x4,x5,x6;
s z,u;
s n1,n2,n3,n4;
v mom1,mom2,mom3,mom4,q;
i mu99=d,mu97=d,mu95=d,mu93=d,mu91=d, mu89=d,nu99=d,nu97=d,nu95=d,nu93=d,nu91=d, nu89=d,mu=d,nu=d;
i sigma=d;
i rho1=d,rho2=d,rho3=d,rho4=d,rho5=d,rho6=d,rho8=d;
i omega1=d,omega2=d,omega3=d,omega4=d,omega5=d,omega6=d,omega8=d;
i a200=[Nc^2-1],a110=[Nc^2-1],a103=[Nc^2-1],a102=[Nc^2-1], a101=[Nc^2-1], a100=[Nc^2-1],a99=[Nc^2-1],a97=[Nc^2-1],a95=[Nc^2-1],a93=[Nc^2-1], a91=[Nc^2-1],a89=[Nc^2-1];
i i99=Nc,i97=Nc,i95=Nc,i93=Nc, i91=Nc, i89=Nc;
i ii99=Nc,ii97=Nc,ii95=Nc,ii93=Nc, ii91=Nc, ii89=Nc
t OT, ET;


#do jj = 1,100
i a'jj'=[Nc^2-1], b'jj'=[Nc^2-1], mu'jj'=d, nu'jj'=d, i'jj'=Nc;
s n'jj', x'jj';
#enddo

#do jj = 1,100
i j'jj'=Nc;
#enddo

#do jj = 1,100
i jj'jj'=Nc;
#enddo

#do jj = 1,100
i ii'jj'=Nc;
#enddo

i aa200=[Nc^2-1],aa110=[Nc^2-1],aa103=[Nc^2-1],aa102=[Nc^2-1], aa101=[Nc^2-1], aa100=[Nc^2-1]

#do jj = 1,100
i aa'jj'=[Nc^2-1];
i bb'jj'=[Nc^2-1];
#enddo


v k1, k2, k3, p1, p2, p3, q, v, l1, l2, l3, r1, r2, r3;

cf pQuark2,pQuark,pgluon,pghost,T,f(antisymmetric),s(symmetric), Den, Num, CMetric;

cf vQQg,vQQp,vQQV, vggg,vGGg,vgggg,vQQZ, vHgg, vHggg, vHgggg, vAgg, vAggg;

set FRules: pQuark2,pQuark,pgluon,pghost,vQQg,vggg,vGGg,vgggg,vQQZ, vHgg, vHggg, vHgggg, vAgg, vAggg, vQQp;

*set PLANARS: PL,PLx12,PLx23,PLx13,PLx123,PLx132;


***Symbols for DY calculation***
s sqrtzu, sqrtziu;

*off statistics;
