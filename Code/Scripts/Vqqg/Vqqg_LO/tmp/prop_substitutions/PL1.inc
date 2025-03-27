repeat;
id Sector(PL1)*Prop(p1+p2+r1,m2) = Sector(PL1)/D1;
id Sector(PL1)*Prop(r1) = Sector(PL1)/D2;
id Sector(PL1)*Den(-q.p1 + q.p2*u) = Sector(PL1)/D3;
id Sector(PL1)*Prop(p1+r1) = Sector(PL1)/D4;
endrepeat;