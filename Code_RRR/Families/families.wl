(* Exact check and export of the families found by families.py.

   wolframscript -file families.wl      (run in Code_RRR/Families after families.py)

   In:   families_raw.m   {{DD numbers}, ...} from families.py; old Families.m of n3lo_old/RRR/Families_Identification
   Out:  Families.m       {FAM[n] -> {DD[..], ...}}, same format as the old Families.m
   Checks: families marked "old" in family_origin.m (families.py --keep-old) identical to the old Families.m;
   every family has 12 propagators, linearly independent
   in the 12 scalar products with u symbolic (rank 12, as in Triple_Real_Families.nb). *)

SetDirectory[DirectoryName[$InputFileName]];
oldFam = Get["../../n3lo_old/RRR/Families_Identification/Families.m"];

SetAttributes[sp, Orderless];
sp[a_Integer*b_, c_] := a sp[b, c];
sp[a_Rational*b_, c_] := a sp[b, c];
sp[a_, b_ + c_] := sp[a, b] + sp[a, c];
kin = {sp[p1, p1] -> 0, sp[p2, p2] -> 0, sp[p1, p2] -> s12/2};
sps = {sp[p1, r1], sp[p1, r2], sp[p1, r3], sp[p2, r1], sp[p2, r2], sp[p2, r3], sp[r1, r1], sp[r1, r2], sp[r1, r3],
   sp[r2, r2], sp[r2, r3], sp[r3, r3]};
momenta = {p1 + r1, p2 + r1, p1 + r2, p2 + r2, p1 + r3, p2 + r3, r1 + r2, r2 + r3, r1 + r3, p1 + r1 + r2, p2 + r1 + r2,
   p1 + r1 + r3, p2 + r1 + r3, p1 + r2 + r3, p2 + r2 + r3, r1 + r2 + r3, p1 + r1 + r2 + r3, p2 + r1 + r2 + r3,
   p1 + p2 + r1, p1 + p2 + r2, p1 + p2 + r3, p1 + p2 + r1 + r2, p1 + p2 + r1 + r3, p1 + p2 + r2 + r3};   (* DD6..DD29 *)
denoms = Join[{sp[r1, r1], sp[r2, r2], sp[r3, r3], sp[p1 + p2 + r1 + r2 + r3, p1 + p2 + r1 + r2 + r3] - m2,
    Expand[sp[q, -p1 + u*p2] /. sp[a_, u*(b_)] :> u*sp[a, b] /. q -> -p1 - p2 - r1 - r2 - r3 /. kin /.
       sp[-p1 - p2 - r1 - r2 - r3, a_] -> -sp[p1 + p2 + r1 + r2 - r3, a] /. sp[a__, -p1] -> -sp[a, p1]]},
   sp[#, #] & /@ momenta] /. kin;
coef = Normal[CoefficientArrays[denoms, sps][[2]]];

raw = Get["families_raw.m"];
FullFamilies = Table[FAM[n] -> (DD /@ raw[[n]]), {n, Length[raw]}];
nOld = If[FileExistsQ["family_origin.m"], Count[Get["family_origin.m"][[All, 2]], "old"], Length[oldFam]];
If[nOld > 0 && FullFamilies[[1 ;; nOld]] =!= oldFam[[1 ;; nOld]], Print["FAM[1..", nOld, "] differ from the old Families.m"]; Exit[1]];
bad = Select[Range[Length[raw]], ! (Length[raw[[#]]] === 12 && MatrixRank[coef[[raw[[#]]]]] === 12) &];
If[bad =!= {}, Print["families without 12 independent propagators: ", bad]; Exit[1]];
Export["Families.m", FullFamilies];
Print[Length[FullFamilies], " families (", nOld, " old, unchanged, + ", Length[FullFamilies] - nOld,
  " new), all of rank 12 -> Families.m"];
