(* compare a new Code_R/Code_LO channel with the old Code/ result: wolframscript -file cmp_old.wl NEWDIR OLDDIR OLDINT *)
{newdir, olddir, oldint} = Rest[$ScriptCommandLine][[;; 3]];
Num[x_] := x; Den[x_] := 1/x;
read[f_] := Module[{s = ReadString[f]}, s = StringReplace[s, {RegularExpression["^\\s*\\w+\\s*=\\s*"] -> "", RegularExpression[";\\s*$"] -> ""}]; ToExpression[s]];
old[p_] := Expand[read[olddir <> "/unreduced" <> p <> ".m"] /. INT[__] -> 1 /. s12 -> m2/z /. m2 -> 1];
new[piece_, p_] := Module[{f = newdir <> "/" <> piece <> "/unreduced" <> p <> ".m"},
   If[FileExistsQ[f], read[f] /. INT[__] -> 1, Missing[]]];
coup = {"vv" -> gv[ti] cgv[tj], "va" -> gv[ti] cga[tj], "av" -> ga[ti] cgv[tj], "aa" -> ga[ti] cga[tj]};
Do[
  Module[{proj = If[MemberQ[{"vv", "aa"}, c[[1]]], "1", "6"], o, n, d},
   o = Coefficient[old[proj], c[[2]]];
   n = new[c[[1]], proj];
   If[MissingQ[n], Print[c[[1]], " L", proj, ": not computed in new (old is zero: ", Simplify[o] === 0, ")"]; Continue[]];
   d = Simplify[Together[o - n]];
   Print[c[[1]], " L", proj, ": old - new = ", d, If[d === 0, "   IDENTICAL", ""],
     "   (old zero: ", Simplify[o] === 0, ")"]],
  {c, coup}];
(* control: a different piece must differ *)
Print["control vv vs va(L6): ", Simplify[Coefficient[old["1"], gv[ti] cgv[tj]] - new["va", "6"]] =!= 0];
