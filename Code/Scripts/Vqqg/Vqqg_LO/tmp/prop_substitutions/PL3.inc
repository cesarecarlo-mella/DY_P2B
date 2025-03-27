repeat;
id Sector(PL3)*Prop(p1+p2+r1,m2) = Sector(PL3)/D1;
id Sector(PL3)*Prop(r1) = Sector(PL3)/D2;
id Sector(PL3)*Den(-q.p1 +q.p2*u) = Sector(PL3)/D3;
id Sector(PL3)*Prop(p1+r1) = Sector(PL3)/D4;
id Sector(PL3)*Prop(-p2-r1) = Sector(PL3)/D5;
endrepeat;