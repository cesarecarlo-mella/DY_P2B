(* Checks of phase_space_int/phase_space.pdf.   run:  wolframscript -file checks.wl > checks.log
   Phi_n(z,u) = int prod_{i=1..n} d^d r_i delta+(r_i^2) delta+(Q^2-m2) delta(Q.p1 - u Q.p2),  Q = p1+p2-sum k_i,
   d = 4-2 eps, s = 2 p1.p2 = m2/z.  Notation of the pdf: a0 = Sqrt[z/u], a1 = (1+z)/(1+u), w = (1+u)(a1-a0),
   x = (a1-a0)/(2 a0), G_n = (1+x)^eps 2F1(eps,1-eps;n-n eps;-x). *)
Print["== 1. one-dimensional integral J_n vs closed form (n = 2, 3, 4)"];
Jnum[n_, e_, z_, u_] := NIntegrate[(u a^2 - z)^-e (1 + z - a (1 + u))^(n - 2 - (n - 1) e),
   {a, Sqrt[z/u], (1 + z)/(1 + u)}, WorkingPrecision -> 30, PrecisionGoal -> 15, MaxRecursion -> 30];
Jcl[n_, e_, z_, u_] := Module[{a0 = Sqrt[z/u], a1 = (1 + z)/(1 + u)},
   Beta[1 - e, (n - 1) (1 - e)] (1 + u)^(n - 2 - (n - 1) e) (a1 - a0)^(n - 1 - n e) u^-e (2 a0)^-e *
    Hypergeometric2F1[e, 1 - e, n - n e, -(a1 - a0)/(2 a0)]];
(* the same, written as in the pdf: w^((n-1)(1-eps)) / (1+u) * [(u-z)(1-u z)/(1+u)^2]^-eps * G_n, times B *)
Jpdf[n_, e_, z_, u_] := Module[{a0 = Sqrt[z/u], a1 = (1 + z)/(1 + u), w, x},
   w = (1 + u) (a1 - a0); x = (a1 - a0)/(2 a0);
   Beta[1 - e, (n - 1) (1 - e)] w^((n - 1) (1 - e))/(1 + u) ((u - z) (1 - u z)/(1 + u)^2)^-e (1 + x)^e *
    Hypergeometric2F1[e, 1 - e, n - n e, -x]];
pts = {{3/10, 1/5, 7/10}, {-1/4, 1/3, 2}, {1/7, 1/20, 1/3}, {2/5, 1/2, 1}, {-3/10, 1/10, 5}};
Do[Module[{cl = N[Jcl[n, Sequence @@ p], 40]},
   Print["   n=", n, "  {eps,z,u}=", p, "   numeric/closed - 1 = ", NumberForm[N[Jnum[n, Sequence @@ p]/cl - 1], 3],
    "   pdf form/closed - 1 = ", NumberForm[N[N[Jpdf[n, Sequence @@ p], 40]/cl - 1], 3]]], {n, 2, 4}, {p, pts}];

Print["== 2. n = 1 (NLO): 2F1(eps,1-eps;1-eps;-x) (1+x)^eps = 1"];
Print[FullSimplify[(1 + x)^e Hypergeometric2F1[e, 1 - e, 1 - e, -x], x > 0]];

Print["== 3. NNLO variable y: u = (y+z-y z)/(1-y+y z)  =>  (u-z)(1-u z)/(1+u)^2 = y(1-y)(1-z)^2"];
uyf[y_, z_] := (y + z - y z)/(1 - y + y z); uy = uyf[y, z];
Print[Factor[(uy - z) (1 - uy z)/(1 + uy)^2]];
Print["   and 1+u = ", Factor[1 + uy], ",  u - z = ", Factor[uy - z], ",  1 - u z = ", Factor[1 - uy z]];

Print["== 4. leading power z -> 1 at fixed y:  w -> y(1-y)(1-z)^2,  x -> 0"];
wy = Module[{a0 = Sqrt[z/uy], a1 = (1 + z)/(1 + uy)}, (1 + uy) (a1 - a0)];
Print["   w/(y(1-y)(1-z)^2) at z=1-10^-8, y=3/10: ", N[wy/(y (1 - y) (1 - z)^2) /. {y -> 3/10, z -> 1 - 10^-8}, 20]];
Print["   series of w in bz = 1-z: ", Simplify[Normal[Series[wy /. z -> 1 - bz, {bz, 0, 3}]], 0 < y < 1]];

Print["== 5. eps expansion of G_n (n = 2, 3): eps^1 (from the series of 2F1) and eps^2 (Euler integral)"];
G1coef[n_] := Log[1 + x] + Sum[(m - 1)!/Pochhammer[n, m] (-x)^m, {m, 1, Infinity}];
Do[Print["   n=", n, ":  G_n = 1 + eps (", FullSimplify[G1coef[n], x > 0], ") + O(eps^2)"], {n, 2, 3}];
(* numerical check of the eps^1 coefficient *)
Do[Print["   n=", n, " x=", xx, ": (G(10^-6)-1)/10^-6 = ",
   N[((1 + xx)^ep Hypergeometric2F1[ep, 1 - ep, n - n ep, -xx] - 1)/ep /. ep -> 10^-12, 12],
   "  formula: ", N[FullSimplify[G1coef[n], x > 0] /. x -> xx, 12]], {n, 2, 3}, {xx, {1/10, 2, 7}}];

G2coef[n_] := Module[{e, t, euler, ser},
   euler = Gamma[n - n e]/(Gamma[1 - e] Gamma[n - n e - 1 + e]) t^-e (1 - t)^(n - n e - 2 + e) (1 + x t)^-e;
   ser = Series[(1 + x)^e euler, {e, 0, 2}];
   FullSimplify[Integrate[SeriesCoefficient[ser, 2], {t, 0, 1}, Assumptions -> x > 0], x > 0]];
Do[Module[{c1 = FullSimplify[G1coef[n], x > 0], c2 = G2coef[n], h = 10^-8},
   Print["   n=", n, ":  eps^2 coefficient = ", InputForm[c2]];
   Do[Print["      x=", xx, ":  ", N[c2 /. x -> xx, 12], "   numeric (G - 1 - eps c1)/eps^2 at eps=10^-8: ",
      N[((1 + xx)^h Hypergeometric2F1[h, 1 - h, n - n h, -xx] - 1 - h (c1 /. x -> xx))/h^2, 12]], {xx, {1/10, 2}}]],
  {n, 2, 3}];

(* the simplified forms written in the pdf (Landen: Li2(x/(1+x)) = -Li2(-x) - Log[1+x]^2/2) *)
pdf2[2] = (6 x - 2 Log[1 + x] + x Log[1 + x]^2 + 2 (2 + x) PolyLog[2, -x])/(2 x);
pdf2[3] = (x (7 + 11 x) - (1 + 2 x) Log[1 + x] + (1 + 2 x + 2 x^2) Log[1 + x]^2 + 2 (3 + 6 x + 2 x^2) PolyLog[2, -x])/(2 x^2);
Do[Print["   n=", n, ": pdf form of the eps^2 coefficient - Euler result at x = 1/10, 2, 7: ",
   (N[pdf2[n] /. x -> #, 30] - N[G2coef[n] /. x -> #, 30]) & /@ {1/10, 2, 7}], {n, 2, 3}];

Print["== 6. NNLO soft master SoftMasters/m1_1111000.m = e^(2 eps gamma) Gamma(1-eps)^2/(4 Gamma(2-2 eps)^2)"];
m1 = Get["../../nnlo_rr/integrals/IF1/SoftMasters/m1_1111000.m"];
mine = CoefficientList[Normal[Series[Exp[2 eps EulerGamma] Gamma[1 - eps]^2/(4 Gamma[2 - 2 eps]^2), {eps, 0, 6}]], eps];
Print["   prefactor in the file: ", m1[[1]]];
Print["   coefficients eps^0..eps^6, file - formula: ", FullSimplify[m1[[2]] - mine]];

Print["== 7. the closed form in the comment of boundaries.nb vs exact (n = 2)"];
(* comment: ((u-z)(1-uz))^(1-2eps) / (1+u)^(1-2eps) / (Sqrt[u](Sqrt[u]+Sqrt[z])(1+Sqrt[u z]))^(1-eps) *)
Fc[e_, z_, u_] := ((u - z) (1 - u z))^(1 - 2 e)/(1 + u)^(1 - 2 e)/(Sqrt[u] (Sqrt[u] + Sqrt[z]) (1 + Sqrt[u z]))^(1 - e);
Print["   symbolic: comment = w^(1-eps)/(1+u) [(u-z)(1-uz)/(1+u)^2]^-eps ? ",
  FullSimplify[Fc[e, z, u]/(Module[{w = (1 + u) ((1 + z)/(1 + u) - Sqrt[z/u])}, w^(1 - e)/(1 + u) ((u - z) (1 - u z)/(1 + u)^2)^-e]) /. e -> 3/10 /. {z -> 1/5, u -> 7/10}]];
Print["   exact/comment / B(1-eps,1-eps) = G_2 :"];
Do[Module[{e = 3/10, z = 1 - bz, u, a0, a1, x},
    u = uyf[y, 1 - bz]; a0 = Sqrt[z/u]; a1 = (1 + z)/(1 + u); x = (a1 - a0)/(2 a0);
    Print["     eps=3/10 bz=", bz, " y=", y, ":  numeric ", N[Jnum[2, e, z, u]/Fc[e, z, u]/Beta[1 - e, 1 - e], 10],
     "   G_2 ", N[(1 + x)^e Hypergeometric2F1[e, 1 - e, 2 - 2 e, -x], 10], "   x = ", N[x, 6]]],
  {bz, {1/2, 1/10, 1/100}}, {y, {1/5, 1/2}}];

Print["== 8. N3LO: leading power, normalised like NNLO (e^(3 eps gamma)/pi^(3-3eps)): C_3/2 series"];
Print["   ", Collect[Normal[Series[Exp[3 eps EulerGamma] Gamma[1 - eps]^3/(8 Gamma[3 - 3 eps]^2), {eps, 0, 4}]], eps, FullSimplify]];

Print["== 9. p1 <-> p2 symmetry: Phi_n(z,1/u) = u Phi_n(z,u)  (u-independent factors of eq. (main) drop out)"];
Phif[n_, e_, z_, u_] := Module[{w = (1 - Sqrt[z/u]) (1 - Sqrt[z u]), x},
   x = w Sqrt[u]/(2 Sqrt[z] (1 + u));
   w^((n - 1) (1 - e))/(1 + u) ((u - z) (1 - u z)/(1 + u)^2)^-e (1 + x)^e Hypergeometric2F1[e, 1 - e, n - n e, -x]];
Do[Print["   n=", n, " {eps,z,u}=", p, ":  Phi(z,1/u)/(u Phi(z,u)) - 1 = ",
   N[N[Phif[n, p[[1]], p[[2]], 1/p[[3]]], 40]/N[p[[3]] Phif[n, Sequence @@ p], 40] - 1, 3]], {n, 2, 3}, {p, {{3/10, 1/5, 7/10}, {-1/4, 1/3, 2}}}];
