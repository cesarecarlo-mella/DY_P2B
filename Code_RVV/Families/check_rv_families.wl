(* Checks of the RV families (rv_families.py), from the FORM files and integralfamilies_r.rv.m:
     wolframscript -file Families/check_rv_families.wl
   1. 7 linearly independent propagators in the 7 scalar products (r1.r1, r1.p1, r1.p2, k1.k1, k1.p1, k1.p2, k1.r1)
   2. fams/rv_isp_table.inc: LISP(f, j) = k1.k1, k1.p1, k1.p2, k1.r1 in the propagators of family f, modulo the cut
      propagators D1..D3
   3. fams/rv_match_table.inc + rv_loopcodes.inc + rv_shifts.inc: every entry lands in its family (the loop
      propagators after k1 -> X among 4-7)
   4. fams/rv_reconstruct.inc: the propagators of every family = integralfamilies_r.rv.m
   Momenta as in FORM: p1, p2, r1, k1 incoming, q = -p1-p2-r1; sp[a,b] = a.b, p1^2 = p2^2 = 0, p1.p2 = m2/(2 z). *)
dir = DirectoryName[$InputFileName];
{fams, ddDef} = Get[FileNameJoin[{dir, "integralfamilies_r.rv.m"}]];
SetAttributes[sp, Orderless];
mom = {p1, p2, r1, k1};
fdot[a_, b_] := Expand[Sum[Coefficient[a, x] Coefficient[b, y] sp[x, y], {x, mom}, {y, mom}] /.
    {sp[p1, p1] -> 0, sp[p2, p2] -> 0, sp[p1, p2] -> m2/(2 z)}];
qsub = q -> -p1 - p2 - r1;
ddval[Den[e_]] := If[FreeQ[e, sp], fdot[e, e], Expand[e /. sp[a_, b_] :> fdot[a /. qsub, b /. qsub]]];
ddval[Den[e_, m_]] := fdot[e, e] - m;
dd[n_] := ddval[DD[n] /. ddDef];
fail[msg_] := (Print["FAILED: ", msg]; Exit[1]);
sps = {sp[r1, r1], sp[r1, p1], sp[r1, p2], sp[k1, k1], sp[k1, p1], sp[k1, p2], sp[k1, r1]};
Print[Length[fams], " families"];
(* 1 *)
Do[If[MatrixRank[D[ddval /@ (fams[[f]] /. ddDef), {sps}]] =!= 7, fail[{"rank", f}]], {f, Length[fams]}];
Print["1. 7 independent propagators in 7 scalar products: ok"];
(* 2 *)
formExpr[s_String] := ToExpression[StringReplace[StringReplace[s, {" " -> "", "\n" -> ""}],
    {RegularExpression["DD(\\d+)"] -> "dd[$1]", "Den(" -> "1/(", RegularExpression["\\b([pr]\\d)\\.([pr]\\d)\\b"] -> "fdot[$1,$2]"}]];
cutsol = First[Solve[Thread[(dd /@ Range[3]) == 0], {sp[r1, r1], sp[r1, p1], sp[r1, p2]}]];
target = {sp[k1, k1], sp[k1, p1], sp[k1, p2], sp[k1, r1]};
isp = StringCases[Import[FileNameJoin[{dir, "fams", "rv_isp_table.inc"}], "Text"],
   RegularExpression["Fill LISP\\((\\d+),(\\d+)\\) = ([^;]*);"] -> {"$1", "$2", "$3"}];
Do[If[Together[Expand[formExpr[e[[3]]] - target[[ToExpression[e[[2]]]]]] /. cutsol] =!= 0, fail[{"LISP", e}]], {e, isp}];
Print["2. loop ISP table (modulo the cut propagators): ok (", Length[isp], " entries)"];
(* 3 *)
codes = Association[StringCases[Import[FileNameJoin[{dir, "fams", "rv_loopcodes.inc"}], "Text"],
    RegularExpression["match\\(Prop\\(([^)]*)\\)\\) \\) id PropSet\\(\\?a\\) = PropSet\\(\\?a,(\\d+)\\)"] :>
     (ToExpression["$2"] -> ToExpression["$1"])]];
shifts = Association[StringCases[Import[FileNameJoin[{dir, "fams", "rv_shifts.inc"}], "Text"],
    RegularExpression["match\\(LSHIFT\\((\\d+)\\)\\) \\) multiply replace_\\(k1, ([^)]*)\\)"] :>
     (ToExpression["$1"] -> ToExpression["$2"])]];
tab = StringCases[Import[FileNameJoin[{dir, "fams", "rv_match_table.inc"}], "Text"],
   RegularExpression["Fill RVM\\d\\(([\\d,]*)\\) = RVT\\((\\d+)\\)\\*LSHIFT\\((\\d+)\\);"] :>
    {ToExpression["{" <> "$1" <> "}"], ToExpression["$2"], ToExpression["$3"]}];
Do[Module[{fp = ddval /@ (fams[[e[[2]]]] /. ddDef)},
    If[! SubsetQ[fp[[4 ;; 7]], (fdot[#, #] &[codes[#] /. k1 -> shifts[e[[3]]]]) & /@ e[[1]]], fail[{"loop", e}]]], {e, tab}];
Print["3. matching table: ok (", Length[tab], " entries, ", Length[shifts], " shifts)"];
(* 4 *)
recon = StringCases[Import[FileNameJoin[{dir, "fams", "rv_reconstruct.inc"}], "Text"],
   RegularExpression["id RVT\\((\\d+)\\)\\*TOPO\\(1\\)(\\S*) = INT"] :>
    {ToExpression["$1"], ToExpression /@ StringCases["$2", RegularExpression["DD(\\d+)"] -> "$1"]}];
Do[If[(DD /@ e[[2]]) =!= fams[[e[[1]]]], fail[{"rv_reconstruct", e[[1]]}]], {e, recon}];
Print["4. rv_reconstruct.inc = integralfamilies_r.rv.m: ok"];
Print["all checks passed"];
