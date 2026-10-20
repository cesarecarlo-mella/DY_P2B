dir = $ScriptCommandLine[[2]];
md[a_List, b_List] := a[[1]] b[[1]] - a[[2 ;; 4]].b[[2 ;; 4]];
(* all-incoming massless momenta, rational; q = -(p1+p2+r1+r2) *)
P1 = {5, 0, 0, 5}; P2 = {7, 0, 0, -7}; R1 = -{9, 1, 4, 8}; R2 = -{3, 2, 1, -2};
ev[expr_, r1v_, r2v_] := Module[{vec, rules, e},
  vec[x_] := x /. {p1 -> P1, p2 -> P2, r1 -> r1v, r2 -> r2v, q -> -(P1 + P2 + r1v + r2v)};
  e = expr /. {Prop[cut, __] -> 1, Den[cut, __] -> 1};
  e = e /. Prop[x_] :> 1/md[vec[x], vec[x]];
  e = e /. Dot[a_, b_] :> md[vec[a], vec[b]];
  e = e /. s12 -> 2 md[P1, P2];
  Factor[Together[e]]];
Do[
  s = StringReplace[ReadString[FileNameJoin[{dir, p <> ".m"}]], {"[Nc^2-1]" -> "(Nc^2-1)", "\n" -> ""}];
  e = ToExpression[StringTrim[s]];
  a = ev[e, R1, R2]; b = ev[e, R2, R1];
  Print[p, ":  f(r1,r2) = ", Short[a, 3]];
  Print["      f(r1,r2) - f(r2,r1) = ", Factor[a - b], "    f(r1,r2) + f(r2,r1) = ", Factor[a + b]],
  {p, {"vv", "v2v2", "vv2", "aa2", "a2a"}}];
