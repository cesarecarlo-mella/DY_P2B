(* compare new Code_RR unreduced files with old Code/ ones, integral by integral (whole coefficient as one rational
   function, m2 = 1): wolframscript -file cmp_rr.wl NEWDIR OLDDIR    (both .../tmp/unreduced)
   every old piece/projector file is matched against every new piece with the same projector *)
{newdir, olddir} = Rest[$ScriptCommandLine][[;; 2]];
Num[x_] := x; Den[x_] := 1/x;
read[f_] := Module[{s = ReadString[f]}, s = StringReplace[s, {RegularExpression["^\\s*[\\w\\[\\]]+\\s*=\\s*"] -> "", RegularExpression[";\\s*$"] -> ""}];
   ToExpression[s] /. m2 -> 1];
byint[e_] := Module[{x = Expand[e, INT], ints}, ints = Union[Cases[x, _INT, Infinity]];
   Association[# -> Together[Coefficient[x, #]] & /@ ints] ];
same[a_, b_] := Keys[a] === Keys[b] && AllTrue[Keys[a], Together[a[#] - b[#]] === 0 &];
oldf = FileNames["unreduced*.m", olddir, 2]; newf = FileNames["unreduced*.m", newdir, 2];
proj[f_] := StringCases[FileNameTake[f], RegularExpression["unreduced(\\d)"] -> "$1"][[1]];
piece[f_] := FileNameTake[f, {-2}];
newdata = Association[(piece[#] <> "/" <> proj[#]) -> byint[read[#]] & /@ newf];
Do[Module[{o = byint[read[f]], key = piece[f] <> "/" <> proj[f], hits},
   If[Length[o] == 0, Print["old ", key, ": zero"]; Continue[]];
   hits = Select[Keys[newdata], StringEndsQ[#, "/" <> proj[f]] && same[o, newdata[#]] &];
   Print["old ", key, " (", Length[o], " INT): identical to new ", hits]], {f, oldf}];
Print["new pieces: ", (# -> Length[newdata[#]]) & /@ Keys[newdata]];
