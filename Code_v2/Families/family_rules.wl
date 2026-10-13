(* Integral families -> integralfamilies.rrr.m and FORM rules, as in n3lo/RRR/Families_Identification/Triple_Real_Families.nb
   ("Define Integral families", "Find Simmetries under permutation of loop momenta", "FORM ids: ISPs, fammatch, etc.").

   wolframscript -file family_rules.wl      (run in Code_v2/Families after families.wl)

   In:   Families.m (FAM[n] -> {DD[..]}), DD1..DD29 as in denoms.m / pf_identities.wl
   Out:  integralfamilies.rrr.m             families in terms of p4 = -r1, p5 = -r2, p6 = -r3 (as the old file)
         fams/dens.inc                      id Prop(...) = 1/Dk
         fams/fammatch.inc                  products of Dk -> TOPO(n) (full family, then subsets of 6..1 regular propagators)
         fams/fams<n>.inc                   scalar products -> propagators of family n
         fams/reconstruct.inc               TOPO(n)/DD.. -> INT(topo n, ...)
         fams/symm_loop_crossings.inc       INT(topo a, ...) = INT(topo b, permuted indices), a related to b by a
                                            relabelling of r1, r2, r3 (no p1 <-> p2)
         families_relabelling.m             for checking by hand: famDD, famProps (families as DD and as momenta),
                                            relabelling = {{FAM[a], {r_i -> r_j}, FAM[b]}}, independentFamilies
   Same code as the notebook; changes: 29 propagators instead of 23; the symmetry search also checks the last family
   (the notebook's While[j < Length[...]] skipped it). *)

SetDirectory[DirectoryName[$InputFileName]];
WriteLines[file_String, lines_List] := Export[file, StringRiffle[lines, "\n"] <> "\n", "Text"];   (* old files end with a newline *)

SetAttributes[sp, Orderless];
sp[a_Integer*b_, c_] := a sp[b, c];
sp[a_Rational*b_, c_] := a sp[b, c];
sp[a_Complex*b_, c_] := a sp[b, c];
sp[a_, b_ + c_] := sp[a, b] + sp[a, c];
kin = {sp[p1, p1] -> 0, sp[p2, p2] -> 0, sp[p1, p2] -> s12/2};
ToUZ = {s12 -> m2/z};
UnkSPs = {sp[r1, r1], sp[r2, r2], sp[r3, r3], sp[r1, r2], sp[r1, r3], sp[r2, r3], sp[p1, r1], sp[p2, r1], sp[p1, r2],
   sp[p2, r2], sp[p1, r3], sp[p2, r3]};

denoms = {DD1 -> sp[r1, r1], DD2 -> sp[r2, r2], DD3 -> sp[r3, r3],
   DD4 -> sp[p1 + p2 + r1 + r2 + r3, p1 + p2 + r1 + r2 + r3] - m2,
   DD5 -> Expand[sp[q, -p1 + u*p2] /. sp[a_, u*(b_)] :> u*sp[a, b] /. q -> -p1 - p2 - r1 - r2 - r3 /. kin /.
       sp[-p1 - p2 - r1 - r2 - r3, a_] -> -sp[p1 + p2 + r1 + r2 - r3, a] /. sp[a__, -p1] -> -sp[a, p1]],
   DD6 -> sp[p1 + r1, p1 + r1], DD7 -> sp[p2 + r1, p2 + r1], DD8 -> sp[p1 + r2, p1 + r2], DD9 -> sp[p2 + r2, p2 + r2],
   DD10 -> sp[p1 + r3, p1 + r3], DD11 -> sp[p2 + r3, p2 + r3], DD12 -> sp[r1 + r2, r1 + r2], DD13 -> sp[r2 + r3, r2 + r3],
   DD14 -> sp[r1 + r3, r1 + r3], DD15 -> sp[p1 + r1 + r2, p1 + r1 + r2], DD16 -> sp[p2 + r1 + r2, p2 + r1 + r2],
   DD17 -> sp[p1 + r1 + r3, p1 + r1 + r3], DD18 -> sp[p2 + r1 + r3, p2 + r1 + r3], DD19 -> sp[p1 + r2 + r3, p1 + r2 + r3],
   DD20 -> sp[p2 + r2 + r3, p2 + r2 + r3], DD21 -> sp[r1 + r2 + r3, r1 + r2 + r3],
   DD22 -> sp[p1 + r1 + r2 + r3, p1 + r1 + r2 + r3], DD23 -> sp[p2 + r1 + r2 + r3, p2 + r1 + r2 + r3],
   DD24 -> sp[p1 + p2 + r1, p1 + p2 + r1], DD25 -> sp[p1 + p2 + r2, p1 + p2 + r2], DD26 -> sp[p1 + p2 + r3, p1 + p2 + r3],
   DD27 -> sp[p1 + p2 + r1 + r2, p1 + p2 + r1 + r2], DD28 -> sp[p1 + p2 + r1 + r3, p1 + p2 + r1 + r3],
   DD29 -> sp[p1 + p2 + r2 + r3, p1 + p2 + r2 + r3]};
nDD = Length[denoms];
d2dd = Table[ToExpression["D" <> ToString[i]] -> ToExpression["DD" <> ToString[i]], {i, nDD}];
dd2d = Table[ToExpression["DD" <> ToString[i]] -> ToExpression["D" <> ToString[i]], {i, nDD}];
dd2dd = Table[ToExpression["DD" <> ToString[i]] -> DD[i], {i, nDD}];
densalloRdered = Prop /@ {r1, r2, r3, q, -q . p1 + u*q . p2, p1 + r1, p2 + r1, p1 + r2, p2 + r2, p1 + r3, p2 + r3,
    r1 + r2, r2 + r3, r1 + r3, p1 + r1 + r2, p2 + r1 + r2, p1 + r1 + r3, p2 + r1 + r3, p1 + r2 + r3, p2 + r2 + r3,
    r1 + r2 + r3, p1 + r1 + r2 + r3, p2 + r1 + r2 + r3,
    p1 + p2 + r1, p1 + p2 + r2, p1 + p2 + r3, p1 + p2 + r1 + r2, p1 + p2 + r1 + r3, p1 + p2 + r2 + r3};
densAlltoDD = Thread[densalloRdered -> Table[DD[i], {i, nDD}]];
DDtodensAll = densAlltoDD /. (a_ -> b_) -> b -> a;

FullFamilies = Get["Families.m"];
NFamilies = Length[FullFamilies];
If[! AllTrue[FullFamilies, MatchQ[#, FAM[_] -> {DD[1], DD[2], DD[3], DD[4], DD[5], DD[_] ..}] && Length[#[[2]]] == 12 &],
  Print["Families.m: unexpected format"]; Exit[1]];
If[! DirectoryQ["fams"], CreateDirectory["fams"]];

(* ---------- integralfamilies.rrr.m (notebook: integralFamilieaAll) ---------- *)
convert = Flatten[Table[ToExpression["p" <> ToString[i]]*ToExpression["p" <> ToString[j]] ->
     sp[ToExpression["p" <> ToString[i]], ToExpression["p" <> ToString[j]]], {i, 1, 10}, {j, 1, 10}]];
integralFamilieaAll = Expand[FullFamilies[[1 ;; All, 2]] /. DDtodensAll /. {r1 -> -p4, r2 -> -p5, r3 -> -p6} /.
          Prop[-(a_)] -> Prop[a] /.
         Prop[-q . p1 + u*q . p2] -> m2/(2*z) - (m2*u)/(2*z) - sp[p1, p4] - sp[p1, p5] - sp[p1, p6] + u*sp[p2, p4] +
           u*sp[p2, p5] + u*sp[p2, p6] /.
        Prop[q] -> -m2 + m2/z - 2*sp[p1, p4] - 2*sp[p1, p5] - 2*sp[p1, p6] - 2*sp[p2, p4] - 2*sp[p2, p5] -
          2*sp[p2, p6] + sp[p4, p4] + 2*sp[p4, p5] + 2*sp[p4, p6] + sp[p5, p5] + 2*sp[p5, p6] + sp[p6, p6] /.
       q -> p1 + p2 - p4 - p5 - p6 /. Prop[a_] -> a*a] /. convert /. sp[p1, p1] -> 0 /. sp[p2, p2] -> 0;
Export["integralfamilies.rrr.m", integralFamilieaAll];

(* ---------- symmetries under permutations of r1, r2, r3 (notebook section, all families) ---------- *)
permutations = {{r1 -> r2, r2 -> r1}, {r1 -> r3, r3 -> r1}, {r2 -> r3, r3 -> r2}, {r1 -> r2, r2 -> r3, r3 -> r1},
   {r1 -> r3, r3 -> r2, r2 -> r1}};
labelCross = {cross[1] -> x12, cross[2] -> x13, cross[3] -> x23, cross[4] -> x123, cross[5] -> x132};
whichCross = {x12 -> {r1 -> r2, r2 -> r1}, x13 -> {r1 -> r3, r3 -> r1}, x23 -> {r2 -> r3, r3 -> r2},
   x123 -> {r1 -> r2, r2 -> r3, r3 -> r1}, x132 -> {r1 -> r3, r3 -> r2, r2 -> r1}};
Crossed[fam_, perm_] := Sort[fam /. DDtodensAll /. perm /. densAlltoDD];
CheckCrossed[fam_, perm_] := If[! AllTrue[Crossed[fam, perm], MatchQ[#, DD[_]] &], Print["relabelled propagator not in DD list: ", fam]; Exit[1]];
FindRelated[fams_] := Module[{minimal = {fams[[1]]}, related = {}, j, relation, crossed, pos},
   Do[relation = False;
    Do[If[! relation,
      CheckCrossed[fams[[j, 2]], permutations[[i]]];
      crossed = Crossed[fams[[j, 2]], permutations[[i]]];
      pos = Flatten[Position[minimal[[1 ;; All, 2]], crossed]];
      If[pos =!= {}, AppendTo[related, {fams[[j, 1]], minimal[[pos[[1]], 1]], cross[i] /. labelCross}]; relation = True]],
     {i, 1, 5}];
    If[! relation, AppendTo[minimal, fams[[j]]]],
    {j, 2, Length[fams]}];
   {minimal, related}];
{MinimalUnderRCrossing, RelatedByCrossing} = FindRelated[FullFamilies];
nOld = If[FileExistsQ["family_origin.m"], Count[Get["family_origin.m"][[All, 2]], "old"], 0];
{minimalOld, relatedOld} = If[nOld > 1, FindRelated[FullFamilies[[1 ;; nOld]]], {{}, {}}];
symmLines = Table[Module[{startfam, endfam, crossR, crossed, permutation},
    startfam = RelatedByCrossing[[i, 1]][[1]]; endfam = RelatedByCrossing[[i, 2]][[1]];
    crossR = RelatedByCrossing[[i, 3]] /. whichCross;
    crossed = FullFamilies[[startfam, 2]] /. DDtodensAll /. crossR /. densAlltoDD;
    permutation = ToExpression[Flatten[(Position[crossed, #1] &) /@ FullFamilies[[endfam, 2]]] /. (a_)?NumberQ :> "n" <> ToString[a]];
    "id INT(topo" <> ToString[startfam] <> ",n1?,n2?,n3?,n4?,n5?,n6?,n7?,n8?,n9?,n10?,n11?,n12?)= INT(topo" <>
     ToString[endfam] <> "," <> StringRiffle[ToString /@ permutation, ","] <> ");"],
   {i, Length[RelatedByCrossing]}];
WriteLines["fams/symm_loop_crossings.inc", symmLines];
famDD = FullFamilies;
famProps = (#[[1]] -> (#[[2]] /. DDtodensAll)) & /@ FullFamilies;
relabelling = {#[[1]], #[[3]] /. whichCross, #[[2]]} & /@ RelatedByCrossing;
independentFamilies = MinimalUnderRCrossing[[All, 1]];
WriteString[OpenWrite["families_relabelling.m"],
  "(* Families and their relabelling symmetries (r1, r2, r3 only), generated by family_rules.wl.\n" <>
  "   famDD:               FAM[n] -> its 12 propagators, DD numbers (DD1..DD29 as in denoms.m)\n" <>
  "   famProps:            FAM[n] -> the same propagators as momenta: Prop[k] = 1/k^2 (Prop[q] = q^2 - m2, Prop[-q.p1 + u q.p2])\n" <>
  "   relabelling:         {FAM[a], rule, FAM[b]}: family a with the relabelling rule applied is family b\n" <>
  "   independentFamilies: the families no relabelling maps onto an earlier one\n" <>
  "   check: AllTrue[relabelling, Sort[(#[[1]] /. famProps) /. #[[2]]] === Sort[#[[3]] /. famProps] &] *)\n\n",
  "famDD = ", ToString[famDD, InputForm], ";\n\n",
  "famProps = ", ToString[famProps, InputForm], ";\n\n",
  "relabelling = ", ToString[relabelling, InputForm], ";\n\n",
  "independentFamilies = ", ToString[independentFamilies, InputForm], ";\n"];
Close["families_relabelling.m"];

(* ---------- FORM ids (notebook chapter "FORM ids: ISPs, fammatch, etc.") ---------- *)
Do[SPs2Ds[i] = Flatten[Solve[Thread[(FullFamilies[[i, 2]] /. DD[a_] :> ToExpression["DD" <> ToString[a]]) ==
         (FullFamilies[[i, 2]] /. DD[a_] :> ToExpression["DD" <> ToString[a]] /. denoms)], UnkSPs] /. kin] /.
    (a_ -> b_) :> a -> Collect[b, denoms[[All, 1]], Factor], {i, 1, NFamilies}];
If[! AllTrue[Range[NFamilies], Length[SPs2Ds[#]] === 12 &], Print["a family does not determine all 12 scalar products"]; Exit[1]];

(* dens.inc *)
propLines = Table["id Prop(" <> StringReplace[ToString[densalloRdered[[i, 1]], InputForm], " " -> ""] <> ") = 1/D" <>
    ToString[i] <> ";", {i, 6, nDD}];
WriteLines["fams/dens.inc", Join[{"id Prop(cut,r1) = 1/D1;", "id Prop(cut,r2) = 1/D2;", "id Prop(cut,r3) = 1/D3;",
    "id Prop(cut,p1 + p2 + r1 + r2 + r3,m2) = 1/D4;", "id Den(cut, - q.p1 + q.p2*u) = 1/D5;"}, propLines, {".sort"}]];

(* fammatch.inc *)
Do[FamToPrint[i] = FullFamilies[[i, 2]] /. DD[a_] :> ToExpression["DD" <> ToString[a]] /. dd2d, {i, 1, NFamilies}];
pw = "?{-1,-2,-3,-4,-5,-6,1,2,3,4,5,6}";
fammatch = Table[
   "id " <> StringRiffle[Table[ToString[FamToPrint[i][[j]]] <> "^n" <> ToString[j] <> pw, {j, 6, 12}], "*"] <>
    " = TOPO(" <> ToString[i] <> ")*" <> StringRiffle[Table[ToString[FamToPrint[i][[j]] /. d2dd] <> "^n" <> ToString[j], {j, 6, 12}], "*"] <> ";",
   {i, 1, NFamilies}];
Do[subs = {};
  Do[sub = Subsets[FamToPrint[fam][[6 ;; All]], {subpropnum}]; sub = Complement[sub, subs]; subs = Join[subs, sub];
   Do[AppendTo[fammatch,
     "id " <> StringRiffle[Table[ToString[sub[[i, j]]] <> "^n" <> ToString[j] <> pw, {j, 1, Length[sub[[i]]]}], "*"] <>
      " = TOPO(" <> ToString[fam] <> ")*" <> StringRiffle[Table[ToString[sub[[i, j]] /. d2dd] <> "^n" <> ToString[j], {j, 1, Length[sub[[i]]]}], "*"] <> ";"],
    {i, 1, Length[sub]}],
   {fam, 1, NFamilies}], {subpropnum, {6, 5, 4, 3, 2, 1}}];
WriteLines["fams/fammatch.inc", fammatch];

(* fams<n>.inc: scalar products -> propagators of the family *)
NumexplicitMultiplyString[expr_] := "Num(" <> StringReplace[StringReplace[StringReplace[ToString[expr /. Times -> (Row[{##1}, "*"] &)],
       {" " -> ""}], {"+-" -> "-"}], {"-1*" -> "-"}] <> ")";
DenexplicitMultiplyString[expr_] := "Den(" <> StringReplace[StringReplace[StringReplace[ToString[expr /. Times -> (Row[{##1}, "*"] &)],
       {" " -> ""}], {"+-" -> "-"}], {"-1*" -> "-"}] <> ")";
Do[sps = SPs2Ds[fam] /. {DD1 -> 0, DD2 -> 0, DD3 -> 0, DD4 -> 0, DD5 -> 0} /. ToUZ;
  lines = Table[Module[{id, tmp, dens, coeffs, len, NUM, DEN, COEFFS, PROPS},
     id = "id " <> ToString[sps[[pr, 1]][[1]]] <> "." <> ToString[sps[[pr, 1]][[2]]] <> "*TOPO(" <> ToString[fam] <> ") = ";
     tmp = sps[[pr, 2]] /. dd2dd; dens = Union[Cases[tmp, DD[a_], Infinity]];
     coeffs = Factor[FullSimplify[Coefficient[tmp, dens]]]; len = Length[coeffs];
     If[(tmp /. Thread[dens -> 0]) =!= 0, coeffs = Together[Append[coeffs, tmp /. Thread[dens -> 0]]]; dens = Append[dens, 1]];
     NUM = (Numerator[#1] &) /@ coeffs; DEN = (Denominator[#1] &) /@ coeffs;
     NUM = NumexplicitMultiplyString /@ Expand[NUM]; NUM = NUM /. "Num(1)" -> "1" /. "Num(-1)" -> "(-1)";
     DEN = DenexplicitMultiplyString /@ Expand[DEN];
     COEFFS = Table[NUM[[i]] <> "*" <> DEN[[i]], {i, Length[coeffs]}];
     PROPS = Table[If[dens[[i]] === 1, "1", "DD" <> ToString[dens[[i, 1]]]], {i, Length[coeffs]}];
     id <> StringJoin[Table["+" <> COEFFS[[i]] <> "*TOPO(" <> ToString[fam] <> ")*" <> PROPS[[i]], {i, Length[coeffs]}]] <> ";"],
    {pr, {4, 5, 6, 7, 8, 9, 10, 11, 12}}];
  WriteLines["fams/fams" <> ToString[fam] <> ".inc", lines], {fam, 1, NFamilies}];

(* reconstruct.inc *)
WriteLines["fams/reconstruct.inc", Table["id TOPO(" <> ToString[i] <> ")/DD1/DD2/DD3/DD4/DD5/" <>
    StringRiffle[Table[ToString[FamToPrint[i][[5 + k]] /. d2dd] <> "^n" <> ToString[k] <> "?", {k, 1, 7}], "/"] <>
    " = INT(topo" <> ToString[i] <> ",1,1,1,1,1,n1,n2,n3,n4,n5,n6,n7);", {i, 1, NFamilies}]];

Print[NFamilies, " families -> integralfamilies.rrr.m, fams/ (dens, fammatch, fams1..", NFamilies, ", reconstruct, symm_loop_crossings)"];
Print["relabelling r1,r2,r3: all ", NFamilies, " families -> ", Length[MinimalUnderRCrossing], " independent (",
  Length[RelatedByCrossing], " related)", If[nOld > 1, "; old " <> ToString[nOld] <> " alone -> " <> ToString[Length[minimalOld]] <>
   " independent (" <> ToString[Length[relatedOld]] <> " related)", ""]];
