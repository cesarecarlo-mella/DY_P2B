(* Check of the identification rules, position by position: for every rule INT[topoA, n..] :> INT[topoB, sigma(n)]
   (reduction/relabelling_INT.m) and its relabelling of p4, p5, p6 (reduction/relabelling_momenta.m), propagator sigma(j)
   of family A, relabelled, must be propagator j of family B (famProps in families_relabelling.m and
   reduction/integralfamilies_all.rrr.m).   wolframscript -file check_relabelling.wl   (after reduction_export.py) *)
SetDirectory[DirectoryName[$InputFileName]];
SetAttributes[sp, Orderless];
Get["families_relabelling.m"];                                  (* famProps: FAM[n] -> {Prop[k], ...} in r1,r2,r3 *)
fams = Get["reduction/integralfamilies_all.rrr.m"];             (* p4,p5,p6 format *)
intRules = Get["reduction/relabelling_INT.m"];
momRules = Get["reduction/relabelling_momenta.m"];
props = Association[famProps];
norm[Prop[k_]] := Prop[If[MatchQ[Expand[k], -_ + ___ | Times[-1, _]], Expand[-k], Expand[k]]];
(* INT index permutation of each rule: apply the rule to INT[topoA, 1..12] *)
bad = 0; badP = 0;
Do[
  {a, rule, b} = r;
  img = INT[ToExpression["topo" <> ToString[a]], Sequence @@ Range[12]] /. intRules;
  If[img[[1]] =!= ToExpression["topo" <> ToString[b]], bad++; Continue[]];
  sigma = List @@ img[[2 ;;]];                                   (* INT_B index j = INT_A index sigma[[j]] *)
  rr = rule /. {p4 -> r1, p5 -> r2, p6 -> r3};
  pa = props[FAM[a]]; pb = props[FAM[b]];
  (* positionwise in the r-form *)
  If[!AllTrue[Range[12], norm[pa[[sigma[[#]]]] /. rr] === norm[pb[[#]]] &], bad++];
  (* positionwise in the p4,p5,p6 file *)
  If[!AllTrue[Range[12], Expand[(fams[[a, sigma[[#]]]] /. rule) - fams[[b, #]]] === 0 &], badP++],
  {r, momRules}];
Print[Length[momRules], " rules checked; position-by-position mismatches: r-form ", bad, ", p4p5p6 file ", badP];
