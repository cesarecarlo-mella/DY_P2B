(* Born q qb -> V with Larin's gamma5 in d dimensions: ratio aa/vv from Code_LO (run with SKIPAA=0).
   usage (from the repo root): wolframscript -file notes_Larin/checks/lo_ratio.wl *)
dir = "Code_LO/Scripts/physical_qqb/Vqqb/Vqqb_LO/tmp/unreduced";
rd[p_] := Module[{f = First[FileNames["*.m", FileNameJoin[{dir, p}]]], s},
  s = StringTrim[ReadString[f]]; s = StringReplace[s, RegularExpression["^\\s*\\w+\\s*="] -> ""];
  s = StringTrim[s]; If[StringEndsQ[s, ";"], s = StringDrop[s, -1]];
  ToExpression[s] /. {Num[x_] :> x, Den[x_] :> 1/x}];
vv = rd["vv"]; aa = rd["aa"];
Print["vv = ", vv]; Print["aa = ", aa];
r = Factor[aa/vv]; Print["aa/vv = ", r];
re = Factor[Expand[r /. d -> 4 - 2 ep]]; Print["aa/vv at d = 4 - 2 ep: ", re];
Print["check (1-2ep)(1-2ep^2/3): ", Simplify[re - (1 - 2 ep) (1 - 2 ep^2/3)] === 0];
