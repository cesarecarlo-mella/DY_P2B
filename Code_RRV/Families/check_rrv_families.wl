(* Checks of the RRV families (rrv_families.py), from the FORM files and the Mathematica exports:
     wolframscript -file Families/check_rrv_families.wl
   1. independent families: propagators 1-7 = the RR family (integralfamilies.rr.m); images: the same set
      (only RR families topo1..41, the entries of integralfamilies.rr.m)
   2. 12 linearly independent propagators in the 12 scalar products, in every family
   3. relabelling_momenta.rrv.m: family A with the rule = family B, propagator by propagator
   4. fams/rrv_isp_table.inc: LISP(f, j) = k1.k1, k1.p1, k1.p2, k1.r1, k1.r2 in the propagators of family f,
      modulo D1..D4 (as in the RR ISP)
   5. fams/rrv_match_table.inc + rrv_loopcodes.inc + rrv_shifts.inc: every entry lands in its family
      (RR D's among propagators 5-7, the loop propagators after k1 -> X among 8-12)
   sp[a,b] = a.b, p4 = -r1, p5 = -r2, p6 = -k1, p1^2 = p2^2 = 0, s12 = m2/z. *)
dir = DirectoryName[$InputFileName];
fams = Get[FileNameJoin[{dir, "integralfamilies.rrv.m"}]];
dens = Get[FileNameJoin[{dir, "denominators.rrv.m"}]];
rr = Get[FileNameJoin[{dir, "integralfamilies.rr.m"}]];
rel = Get[FileNameJoin[{dir, "relabelling_momenta.rrv.m"}]];
SetAttributes[sp, Orderless];
mom = {p1, p2, p4, p5, p6};
sq[v_] := Expand[Sum[Coefficient[v, a] Coefficient[v, b] sp[a, b], {a, mom}, {b, mom}] /.
    {sp[p1, p1] -> 0, sp[p2, p2] -> 0, sp[p1, p2] -> m2/(2 z)}];
canon[e_] := Expand[e /. sp[a_, b_] :> sp[a, b]];
sps = Union[Flatten[Table[sp[a, b], {a, {p4, p5, p6}}, {b, {p1, p2, p4, p5, p6}}]]];
fail[msg_] := (Print["FAILED: ", msg]; Exit[1]);
Print[Length[fams], " families, ", Length[rr], " RR families"];

(* RR family of each RRV family, from rrv_families.txt *)
rrf = ToExpression /@ StringCases[Import[FileNameJoin[{dir, "rrv_families.txt"}], "Text"],
    RegularExpression["topo\\d+\\s+RR\\s+(\\d+)"] -> "$1"];
If[Length[rrf] =!= Length[fams], fail["rrv_families.txt"]];
indep = Complement[Range[Length[fams]], rel[[All, 1]]];

(* 1: integralfamilies.rr.m has entries topo1..topo41 (RR 42, 45, 46 not in it) *)
inrr = Select[Range[Length[fams]], rrf[[#]] <= Length[rr] &];
Do[If[canon[fams[[f, ;; 7]]] =!= canon[rr[[rrf[[f]]]]], fail[{"RR part", f}]], {f, Intersection[indep, inrr]}];
Do[If[Sort[canon[fams[[f, ;; 7]]]] =!= Sort[canon[rr[[rrf[[f]]]]]], fail[{"RR part (image)", f}]],
  {f, Intersection[rel[[All, 1]], inrr]}];
Print["1. RR parts = integralfamilies.rr.m: ok (", Length[inrr], " of ", Length[fams], " families; RR families not in",
  " integralfamilies.rr.m: ", Union[rrf[[Complement[Range[Length[fams]], inrr]]]], ")"];

(* 2 *)
Do[If[MatrixRank[D[fams[[f]], {sps}]] =!= 12, fail[{"rank", f}]], {f, Length[fams]}];
Print["2. 12 independent propagators in ", Length[sps], " scalar products: ok"];

(* 3 *)
Do[If[canon[fams[[r[[1]]]] /. r[[2]]] =!= canon[fams[[r[[3]]]]], fail[{"relabelling", r}]], {r, rel}];
Print["3. relabellings: ok"];

(* FORM text -> Mathematica *)
formMom[s_String] := ToExpression[StringReplace[s, " " -> ""]];
toM[e_] := e /. {r1 -> -p4, r2 -> -p5, k1 -> -p6};
dd[n_] := (den[n] /. dens);
formExpr[s_String] := Module[{t = StringReplace[s, {" " -> "", "\n" -> ""}]},
   t = StringReplace[t, {RegularExpression["DD(\\d+)"] -> "dd[$1]", "Den(" -> "1/(",
       RegularExpression["\\b([pr]\\d)\\.([pr]\\d)\\b"] -> "fdot[$1,$2]"}];
   ToExpression[t]];
fdot[a_, b_] := Module[{x = toM[a], y = toM[b]},
   Expand[Sum[Coefficient[x, u1] Coefficient[y, u2] sp[u1, u2], {u1, mom}, {u2, mom}] /.
     {sp[p1, p1] -> 0, sp[p2, p2] -> 0, sp[p1, p2] -> m2/(2 z)}]];

(* 4 *)
isp = StringCases[Import[FileNameJoin[{dir, "fams", "rrv_isp_table.inc"}], "Text"],
   RegularExpression["Fill LISP\\((\\d+),(\\d+)\\) = ([^;]*);"] -> {"$1", "$2", "$3"}];
target = {sp[p6, p6], -sp[p1, p6], -sp[p2, p6], sp[p4, p6], sp[p5, p6]};
(* modulo the cut propagators D1..D4 (an integral with a cut index <= 0 vanishes): solve D1..D4 = 0 *)
cutsol = First[Solve[Thread[(dd /@ Range[4]) == 0], {sp[p4, p4], sp[p5, p5], sp[p4, p5], sp[p1, p5]}]];
Do[With[{f = ToExpression[e[[1]]], j = ToExpression[e[[2]]]},
    If[Together[Expand[formExpr[e[[3]]] - target[[j]]] /. cutsol] =!= 0, fail[{"LISP", f, j, e[[3]]}]]], {e, isp}];
Print["4. loop ISP table (modulo the cut propagators): ok (", Length[isp], " entries)"];

(* 5 *)
codes = Association[Rule @@@ Reverse /@ StringCases[Import[FileNameJoin[{dir, "fams", "rrv_loopcodes.inc"}], "Text"],
      RegularExpression["match\\(Prop\\(([^)]*)\\)\\) \\) id PropSet\\(\\?a\\) = PropSet\\(\\?a,(\\d+)\\)"] :>
       {formMom["$1"], ToExpression["$2"]}]];
shifts = Association[StringCases[Import[FileNameJoin[{dir, "fams", "rrv_shifts.inc"}], "Text"],
     RegularExpression["match\\(LSHIFT\\((\\d+)\\)\\) \\) multiply replace_\\(k1, ([^)]*)\\)"] :>
      (ToExpression["$1"] -> formMom["$2"])]];
tab = StringCases[Import[FileNameJoin[{dir, "fams", "rrv_match_table.inc"}], "Text"],
   RegularExpression["Fill RRVM\\d\\(([\\d,]*)\\) = RRVT\\((\\d+)\\)\\*LSHIFT\\((\\d+)\\);"] :>
    {ToExpression["{" <> "$1" <> "}"], ToExpression["$2"], ToExpression["$3"]}];
Do[Module[{key = e[[1]], f = e[[2]], s = e[[3]], rrd, lc, fp},
    fp = canon[fams[[f]]];
    rrd = Select[key, # < 100 &]; lc = Select[key, # >= 100 &];
    If[! SubsetQ[fp[[5 ;; 7]], canon[dd /@ rrd]], fail[{"RR D's", e}]];
    If[! SubsetQ[fp[[8 ;; 12]], canon[sq[toM[codes[#] /. k1 -> shifts[s]]] & /@ lc]], fail[{"loop", e}]]],
  {e, tab}];
Print["5. matching table: ok (", Length[tab], " nonzero entries, ", Length[shifts], " shifts, ", Length[codes],
  " loop propagators)"];
Print["all checks passed"];
