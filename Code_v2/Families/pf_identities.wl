(* Partial-fraction identities for the triple-real propagators.
   Same method and output format as n3lo_old/RRR/Families_Identification/Triple_Real_Families.nb
   ("Partial fraction identities", "Save identities", "Write Partial fraction in form").

   wolframscript -file pf_identities.wl        (run in Code_v2/Families, needs circuits.m from find_circuits.py)

   In:   circuits.m                     minimal dependent propagator sets {i, j, ...} (DD numbers)
   Out:  allpfid.m                      list of identities PFid[j] (each = 1), as the old allpfid.m
         pfid_sets.m                    {j -> {DD numbers of PFid[j]}}
         pfid_squared.m                 {j -> n}: DD number squared by PFid[j] (0 for the ordinary identities)
         partial_fraction/partialfraction_<j>.inc   FORM version of PFid[j], as the old partial_fraction/

   Relation sum_i c_i DD_i = K + (terms in DD1..DD5) on a minimal set (all c_i != 0):
   K != 0  (PFid 1..36):  PFid = (sum_i c_i DD_i - cut terms)/K = 1, as in the notebook;
                          1/(D_1..D_n) = sum_i (c_i/K) 1/(D_1..^D_i..D_n)
   K == 0  (PFid 37..):   the notebook skipped these. With D_n = the highest DD number of the set (rule in SquaredDD):
                          PFid = (cut terms - sum_{i<n} c_i DD_i)/(c_n DD_n) = 1;
                          1/(D_1..D_n) = sum_{i<n} (-c_i/c_n) 1/(D_1..^D_i..D_{n-1} D_n^2)
   Cut DD1..DD5 are set to 0 in the FORM files (on the cut), as in the notebook. *)

SetDirectory[DirectoryName[$InputFileName]];
WriteLines[file_String, lines_List] := Export[file, StringRiffle[lines, "\n"] <> "\n", "Text"];   (* old files end with a newline *)
Import["~/Software/multivariateapart/MultivariateApart.wl"];

SetAttributes[sp, Orderless];
sp[a_Integer*b_, c_] := a sp[b, c];
sp[a_Rational*b_, c_] := a sp[b, c];
sp[a_Complex*b_, c_] := a sp[b, c];
sp[a_, b_ + c_] := sp[a, b] + sp[a, c];
kin = {sp[p1, p1] -> 0, sp[p2, p2] -> 0, sp[p1, p2] -> s12/2};
ToUZ = {s12 -> m2/z};

(* DD1..DD23 exactly as in the notebook; DD24..DD29 new (q + r_i + r_j and q + r_i, up to sign) *)
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
dds = Table[ToExpression["DD" <> ToString[i]], {i, nDD}];
dds2zero = Thread[dds -> 0];
dd2dd = Table[ToExpression["DD" <> ToString[i]] -> DD[i], {i, nDD}];
cut2zero = {DD1 -> 0, DD2 -> 0, DD3 -> 0, DD4 -> 0, DD5 -> 0};
(* momenta written in the FORM files, same order as the DD numbers (old densalloRdered + DD24..DD29) *)
densalloRdered = Prop /@ {r1, r2, r3, q, -q . p1 + u*q . p2, p1 + r1, p2 + r1, p1 + r2, p2 + r2, p1 + r3, p2 + r3,
    r1 + r2, r2 + r3, r1 + r3, p1 + r1 + r2, p2 + r1 + r2, p1 + r1 + r3, p2 + r1 + r3, p1 + r2 + r3, p2 + r2 + r3,
    r1 + r2 + r3, p1 + r1 + r2 + r3, p2 + r1 + r2 + r3,
    p1 + p2 + r1, p1 + p2 + r2, p1 + p2 + r3, p1 + p2 + r1 + r2, p1 + p2 + r1 + r3, p1 + p2 + r2 + r3};

(* on the cut: solve DD1..DD5 for five scalar products, as "someinversion" in the notebook *)
system = {(DD1 /. denoms) == DD1, (DD2 /. denoms) == DD2, (DD3 /. denoms /. kin) == DD3,
   (DD4 /. denoms /. kin) == DD4, (DD5 /. denoms /. kin) == DD5};
someinversion = Flatten[Solve[system, {sp[r1, r1], sp[r2, r2], sp[r3, r3], sp[p1, r1], sp[p2, r1]}]];

(* the relation sum_i c_i DD_i, with all c_i != 0, that is free of scalar products on the cut *)
Relation[set_List] := Module[{cs, ansatz, tmp, sps, sol},
   cs = Table[c[i], {i, Length[set]}];
   ansatz = cs . (ToExpression["DD" <> ToString[#]] & /@ set);
   tmp = Collect[Expand[ansatz /. denoms /. kin /. someinversion], {_sp}, Together];
   sps = Union[Cases[tmp, _sp, Infinity]];
   sol = Solve[Thread[Coefficient[tmp, sps] == 0], cs];
   If[sol === {}, Return[$Failed]];
   sol = First[sol];
   If[Length[Complement[cs, sol[[All, 1]]]] =!= 1, Return[$Failed]];   (* one free coefficient: set it to 1 *)
   ansatz = Simplify[ansatz /. sol /. Thread[Complement[cs, sol[[All, 1]]] -> 1]];
   If[MemberQ[Coefficient[ansatz, ToExpression["DD" <> ToString[#]] & /@ set], 0], Return[$Failed]];
   ansatz];

FormString[expr_, head_] := head <> "(" <> StringReplace[StringReplace[StringReplace[
       ToString[expr /. Times -> (Row[{##}, "*"] &)], {" " -> ""}], {"+-" -> "-"}], {"-1*" -> "-"}] <> ")";
PropString[list_] := ToString[list /. Prop[a__] :> "Prop(" <> ToString[a] <> ")" /. List -> (Row[{##}, "*"] &)];

SquaredDD[set_List] := Max[set];   (* K == 0: the propagator that gets squared *)

circuits = Get["circuits.m"];
PFsets = {}; AllPFID = {}; Squared = {}; zeroConst = {}; failed = {};
Do[
  lhs = Relation[set];
  If[lhs === $Failed, AppendTo[failed, set]; Continue[]];
  rhs = Simplify[lhs /. denoms /. kin /. someinversion /. ToUZ];
  If[! FreeQ[rhs, sp], AppendTo[failed, set]; Continue[]];
  const = Simplify[rhs /. dds2zero];
  If[const === 0, AppendTo[zeroConst, set]; Continue[]];
  rhs = Simplify[rhs - const];
  one = Collect[MultivariateApart[Simplify[lhs - rhs]], dds]*Factor[1/const];
  (* check: the identity is exactly 1 *)
  If[Simplify[(one /. denoms /. kin /. ToUZ) - 1] =!= 0, AppendTo[failed, set]; Continue[]];
  AppendTo[AllPFID, one]; AppendTo[PFsets, set]; AppendTo[Squared, 0],
  {set, circuits}];

(* K == 0: second step, D_n squared *)
Do[
  lhs = Relation[set];
  cutpart = Simplify[lhs /. denoms /. kin /. someinversion /. ToUZ];   (* only DD1..DD5, no constant *)
  n = SquaredDD[set]; dn = ToExpression["DD" <> ToString[n]];
  cn = Coefficient[lhs, dn];
  one = Collect[(cutpart - (lhs - cn dn))/(cn dn), dds, Factor];
  If[Simplify[(one /. denoms /. kin /. ToUZ) - 1] =!= 0 || ! FreeQ[one /. cut2zero, Alternatives @@ (ToExpression["DD" <> ToString[#]] & /@ Complement[Range[6, nDD], set])],
   AppendTo[failed, set]; Continue[]];
  AppendTo[AllPFID, one]; AppendTo[PFsets, set]; AppendTo[Squared, n],
  {set, zeroConst}];
nids = Length[AllPFID];

Export["allpfid.m", AllPFID];
Export["pfid_sets.m", Thread[Range[nids] -> PFsets]];
Export["pfid_squared.m", Thread[Range[nids] -> Squared]];

If[! DirectoryQ["partial_fraction"], CreateDirectory["partial_fraction"]];
Do[
  tmp = AllPFID[[j]] /. cut2zero /. dd2dd;
  dis = DD /@ PFsets[[j]];
  tmp2 = MultivariateApart[tmp/Times @@ dis];
  tmp2 = Expand[tmp2*den[]] //. {den[c___]/DD[a_] :> den[c, a], den[c___]*DD[a_]^k_Integer /; k < 0 :> den[c, Sequence @@ ConstantArray[a, -k]]};
  dens = Union[Cases[tmp2, den[a__], Infinity]];
  coeffs = Factor[FullSimplify[Coefficient[tmp2, dens]]];
  NUM = FormString[#, "Num"] & /@ Expand[Numerator /@ coeffs];
  DEN = FormString[#, "Den"] & /@ Expand[Denominator /@ coeffs];
  id = "id " <> PropString[densalloRdered[[dis /. DD[a_] -> a]]] <> " = " <>
    StringJoin[Table["+" <> NUM[[i]] <> "*" <> DEN[[i]] <> "*" <> PropString[densalloRdered[[dens[[i]] /. den[a__] -> {a}]]],
      {i, Length[coeffs]}]] <> ";";
  file = "partial_fraction/partialfraction_" <> ToString[j] <> ".inc";
  WriteLines[file, {"repeat;", id, "endrepeat;"}],
  {j, nids}];

Print[Length[circuits], " candidate sets: ", nids, " identities (", Count[Squared, 0], " with K != 0, ",
  Count[Squared, _?Positive], " with K = 0 and a squared propagator), ", Length[failed], " failed"];
If[failed =!= {}, Print["failed: ", failed]];
