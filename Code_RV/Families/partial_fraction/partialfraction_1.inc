* NLO: the regular propagators are constants on the cut, (p1+r1)^2 = 2 p1.r1, (p2+r1)^2 = 2 p2.r1 (fams/fams1.inc)
* (= old Code/Scripts/Vqgq/Vqgq_LO/tmp/partial_fraction/partialfraction.inc, with s12 = m2/z)
repeat;
id Prop(p1+r1) = Num(z+u*z)*Den(m2*u*z-m2);
id Prop(p2+r1) = Num(z+u*z)*Den(m2*z-m2*u);
endrepeat;
