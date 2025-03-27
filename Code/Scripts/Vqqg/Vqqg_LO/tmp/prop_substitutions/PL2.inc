repeat;
id Sector(PL2)*Prop(p1+p2+r1,m2) = Sector(PL2)/D1;
id Sector(PL2)*Prop(r1) = Sector(PL2)/D2;
id Sector(PL2)*Den(-q.p1 + q.p2*u) = Sector(PL2)/D3;
id Sector(PL2)*Prop(-p2-r1) = Sector(PL2)/D4;
endrepeat;