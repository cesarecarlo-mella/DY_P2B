(* Vqqbg vv in d = 4 vs the textbook q qb -> V* g:  sum|M|^2 ~ (t^2 + u^2 + 2 s Q^2)/(t u) (Ellis-Stirling-Webber (9.29)),
   times our extra factors: L1 . W = -q^2 g.W (current conservation) and the cut factor (-q.p2) of feynman_rules.h *)
Num[x_] := x; Den[x_] := 1/x;
read[f_] := Module[{s = ReadString[f]}, s = StringReplace[s, {RegularExpression["^\\s*\\w+\\s*=\\s*"] -> "", RegularExpression[";\\s*$"] -> ""}];
   ToExpression[s] /. INT[__] -> 1];
vv = read["Code_R/Scripts/physical_qqbg/Vqqbg/Vqqbg_LO/tmp/unreduced/vv/unreduced1.m"];
m2 = 1; s = m2/z; p1r1 = (m2 uu - s)/(2 (1 + uu)); p2r1 = (m2 - uu s)/(2 (1 + uu));   (* uu = our u *)
t = 2 p1r1; uh = 2 p2r1; mq2 = m2; mqp2 = s/2 + p2r1;
book = mq2 mqp2 (t^2 + uh^2 + 2 s m2)/(t uh);
Print["vv(d=4) / book = ", Simplify[(vv /. u -> uu /. d -> 4)/book]];
