(* p1<->p2 partners and charge conjugation of the Code_R channels: ratios of the coefficients of INT(topo1,1,1,1) *)
dir = Rest[$ScriptCommandLine][[1]];
Num[x_] := x; Den[x_] := 1/x;
read[f_] := Module[{s = ReadString[f]}, s = StringReplace[s, {RegularExpression["^\\s*\\w+\\s*=\\s*"] -> "", RegularExpression[";\\s*$"] -> ""}];
   ToExpression[s] /. INT[__] -> 1];
get[c_, p_] := read[dir <> "/physical_qqbg/" <> c <> "/" <> c <> "_LO/tmp/unreduced/" <> p <> "/unreduced" <> If[MemberQ[{"vv", "aa"}, p], "1", "6"] <> ".m"];
swap = {u -> 1/u, sqrtzu -> sqrtziu, sqrtziu -> sqrtzu};
Do[Print[pr[[1]], " vs ", pr[[2]], " (u -> 1/u, sqrtzu <-> sqrtziu): ",
   Table[p -> Simplify[get[pr[[2]], p]/(get[pr[[1]], p] /. swap), Assumptions -> u > 0], {p, {"vv", "aa", "va", "av"}}]],
  {pr, {{"Vqqbg", "Vqbqg"}, {"Vqgq", "Vgqq"}, {"Vqbgqb", "Vgqbqb"}}}];
Do[Print[pr[[1]], " vs ", pr[[2]], " (charge conjugation): ",
   Table[p -> Simplify[get[pr[[2]], p]/get[pr[[1]], p]], {p, {"vv", "aa", "va", "av"}}]],
  {pr, {{"Vqgq", "Vqbgqb"}, {"Vgqq", "Vgqbqb"}}}];
