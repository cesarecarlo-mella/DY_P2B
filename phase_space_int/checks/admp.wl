(* hep-ph/0312266 (ADMP) eq. (3.8)-(3.11) for nu = 0 vs phase_space.pdf eq. (main) with n = 2, absolute normalisation *)
Om[n_] := 2 Pi^(n/2)/Gamma[n/2];
K0[e_, dl_] := NIntegrate[(ch (1 - ch) (1 - ch dl))^-e, {ch, 0, 1}, WorkingPrecision -> 30];
admp[e_, s_, z_, u_] := Module[{d = 4 - 2 e, dl = (Sqrt[u] - Sqrt[z]) (1 - Sqrt[u z])/((Sqrt[u] + Sqrt[z]) (1 + Sqrt[u z]))},
   Om[d - 2] Om[d - 1] s^(-2 e) (u - z)^(1 - 2 e) (1 - u z)^(1 - 2 e)/(2^d (1 + u)^(1 - 2 e) (Sqrt[u] (Sqrt[u] + Sqrt[z]) (1 + Sqrt[u z]))^(1 - e)) K0[e, dl]];
mine[n_, e_, s_, z_, u_] := Module[{w = (1 - Sqrt[z/u]) (1 - Sqrt[z u]), x},
   x = w Sqrt[u]/(2 Sqrt[z] (1 + u));
   Pi^(n (1 - e)) Gamma[1 - e]^n/(2^(n - 1) Gamma[n (1 - e)]^2) s^(n - 2 - n e) w^((n - 1) (1 - e))/(1 + u) *
    ((u - z) (1 - u z)/(1 + u)^2)^-e (1 + x)^e Hypergeometric2F1[e, 1 - e, n - n e, -x]];
Print["ADMP I[0] / Phi_2 (mine) - 1:"];
Do[Print["   ", p, "  ", N[N[admp @@ p, 30]/N[mine[2, Sequence @@ p], 30] - 1, 3]], {p, {{3/10, 1, 1/5, 7/10}, {-1/4, 3, 1/3, 2}, {1/7, 2, 1/20, 1/3}}}];
Print["Pfaff form: (1+x)^e 2F1(e,1-e;n-ne;-x) = 2F1(e,(n-1)(1-e);n-ne;x/(1+x)), and x/(1+x) = ADMP delta:"];
Do[Module[{e = p[[1]], z = p[[2]], u = p[[3]], w, x, dl},
   w = (1 - Sqrt[z/u]) (1 - Sqrt[z u]); x = w Sqrt[u]/(2 Sqrt[z] (1 + u));
   dl = (Sqrt[u] - Sqrt[z]) (1 - Sqrt[u z])/((Sqrt[u] + Sqrt[z]) (1 + Sqrt[u z]));
   Print["   n=", n, " ", p, ":  G_n difference ", N[(1 + x)^e Hypergeometric2F1[e, 1 - e, n - n e, -x], 30] - N[Hypergeometric2F1[e, (n - 1) (1 - e), n - n e, x/(1 + x)], 30] // Chop,
     "   x/(1+x) - delta ", N[x/(1 + x), 30] - N[dl, 30] // Chop]], {n, 2, 3}, {p, {{3/10, 1/5, 7/10}, {-1/4, 1/3, 2}}}];
Print["symbolic: x/(1+x) == delta ? ", FullSimplify[Module[{z = t^2, u = r^2, w, x}, w = (1 - t/r) (1 - t r); x = w r/(2 t (1 + r^2));
   x/(1 + x) - (r - t) (1 - r t)/((r + t) (1 + r t))], 0 < t < r < 1/t]];
Print["K0 eps^1 (ADMP 3.12) vs mine B(1-e,1-e) G_2 at eps^1, delta = 1/3: ",
  N[Module[{dl = 1/3}, 3 - (dl - 1) Log[1 - dl]/dl], 20], "  ", N[Module[{x = (1/3)/(1 - 1/3)}, 2 + 1 - Log[1 + x]/x], 20]];
