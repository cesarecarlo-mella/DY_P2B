* family 1 = the cut propagators D1 = r1^2, D2 = (p1+p2+r1)^2 - m2, D3 = rapidity; on the cut (D's = 0),
* with p1.p2 = s12/2 = m2/(2z): p1.r1 = (m2 u - s12)/(2(1+u)), p2.r1 = (m2 - u s12)/(2(1+u))
* (= old Code/Scripts/Vqgq/Vqgq_LO/tmp/ISP/PL.inc)
id p1.r1*TOPO(1) = Num(m2*u*z-m2)*Den(2*z+2*u*z)*TOPO(1);
id p2.r1*TOPO(1) = Num(m2*z-m2*u)*Den(2*z+2*u*z)*TOPO(1);
