(* The INTEGRAND of nnlo_rr/integrals/IF1/boundaries.nb (copied verbatim, units s = 1, m2 = z) integrated over
   lambda1, lambda2, lambda4, compared with the light-cone results of phase_space.pdf.
   run:  wolframscript -file notebook_integrand.wl > notebook_integrand.log
   A = int INTEGRAND            : fixed rapidity with delta(u - u_Q)            -> compare with Psi2 (extra Q.p2 = a/2)
   B = int INTEGRAND/(-p2dotq)  : the master, delta(Q.p1 - u Q.p2) = delta(u - u_Q)/Q.p2   -> compare with J2 (eq. oned)
   Fc = the closed formula in the comment of the notebook (without K[0]).
   lambda4 and lambda2 factorise: Beta[1/2-e,1/2-e] and Beta[1-e,1-e]; only lambda1 is integrated numerically.
   Norm is kept up to constants: its (y,z)-dependent part ((1-y)y)^(1-2e) (1-z)^(2-4e). A column constant over the
   points means the two functions are the same up to an eps-dependent constant. *)
setup[z0_, u0_] := (z = z0; u = u0; r = Sqrt[u]; t = Sqrt[z]; Kp = (r + t) (1 + r t); Km = (r - t) (1 - r t);
   y = (-u + z)/((1 + u) (-1 + z)));
integrand1[e_, l1_] := ((1 + z)/((1 + u)^2)) ((Kp r)/(1 + u)^2)^(-1 + e) ((1 - l1) (1 - (Km l1)/Kp))^-e *
   (1 - (Km l1)/(r (1 + z))) l1^-e;
s2h[l1_] := -(1 - y) (1 - z) (1 - l1 (r - t)/r/(1 + r t));
p2dotq[l1_] := (-z + s2h[l1])/2;
normYZ[e_] := ((1 - y) y)^(1 - 2 e) (1 - z)^(2 - 4 e);
lam[e_, f_] := Beta[1/2 - e, 1/2 - e] Beta[1 - e, 1 - e] NIntegrate[f, {l1, 0, 1}, WorkingPrecision -> 25];
A[e_] := normYZ[e] lam[e, integrand1[e, l1]];
B[e_] := normYZ[e] lam[e, integrand1[e, l1]/(-p2dotq[l1])];
J2[e_] := NIntegrate[(u a^2 - z)^-e (1 + z - a (1 + u))^-e, {a, Sqrt[z/u], (1 + z)/(1 + u)}, WorkingPrecision -> 25];
Psi2[e_] := NIntegrate[a/2 (u a^2 - z)^-e (1 + z - a (1 + u))^-e, {a, Sqrt[z/u], (1 + z)/(1 + u)}, WorkingPrecision -> 25];
Fc[e_] := ((u - z) (1 - u z))^(1 - 2 e)/(1 + u)^(1 - 2 e)/(Sqrt[u] (Sqrt[u] + Sqrt[z]) (1 + Sqrt[u z]))^(1 - e);
pts = {{1/5, 7/10}, {1/3, 2}, {1/20, 1/3}, {1/2, 1}, {9/10, 21/20}};
Off[NIntegrate::precw];
Do[Print["eps = ", e, ":   {z, u}   A/Psi2   B/J2   A/Fc   B/Fc"];
  Do[setup @@ p; Module[{a = A[e], b = B[e]},
     Print["   ", p, "   ", NumberForm[Re[N[#, 12]], 10] & /@ {a/Psi2[e], b/J2[e], a/Fc[e], b/Fc[e]}]], {p, pts}],
  {e, {0, 3/10}}];
