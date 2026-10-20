(* Compare two pieces of a step-06 output, INT by INT.
   usage (from the repo root):
     wolframscript -file notes_Larin/checks/aa_vs_vv.wl <channel>_LO/tmp/unreduced <pieceA> <pieceB>
   e.g. pieceA = aa, pieceB = vv.  Prints how many INT coefficients differ at d = 4 and in d
   (numerical point z = 3/17, u = 5/7, Nc = 3, gs = 1; d kept symbolic).
   Caveat: the INT are not reduced (not independent), so "equal INT by INT" is a sufficient test of equality,
   "different INT by INT" is strong evidence, not a proof, of a difference after reduction. *)
{dir, pa, pb} = $ScriptCommandLine[[2 ;; 4]];
rd[p_] := Module[{f = First[FileNames["*.m", FileNameJoin[{dir, p}]]], s},
  s = StringTrim[ReadString[f]]; s = StringReplace[s, RegularExpression["^\\s*\\w+\\s*="] -> ""];
  s = StringTrim[s]; If[StringEndsQ[s, ";"], s = StringDrop[s, -1]];
  ToExpression[s] /. {Num[x_] :> x, Den[x_] :> 1/x}];
coef[e_] := Module[{ints = Union@Cases[e, _INT, Infinity]},
  Association[# -> Coefficient[Expand[e, _INT], #] & /@ ints]];
ca = coef[rd[pa]]; cb = coef[rd[pb]];
ints = Union[Keys[ca], Keys[cb]];
pt = {z -> 3/17, u -> 5/7, Nc -> 3, gs -> 1, sqrtzu -> Sqrt[3/17*5/7], sqrtziu -> Sqrt[3/17/(5/7)]};
diff = Table[Together[(Lookup[ca, i, 0] - Lookup[cb, i, 0]) /. pt], {i, ints}];
Print[pa, " vs ", pb, " (", dir, "): ", Length[ints], " INTs"];
Print["  coefficients different at d = 4: ", Count[Simplify[diff /. d -> 4], x_ /; x =!= 0]];
Print["  coefficients different in d    : ", Count[diff, x_ /; x =!= 0]];
nz = Select[Transpose[{ints, diff}], #[[2]] =!= 0 &];
If[Length[nz] > 0, Print["  example ", nz[[1, 1]], ":  A - B = ", Factor[nz[[1, 2]]],
   ",  B = ", Factor[Lookup[cb, nz[[1, 1]], 0] /. pt]]];
