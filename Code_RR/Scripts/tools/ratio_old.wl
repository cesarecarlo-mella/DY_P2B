(* ratio new/old per integral for one piece: wolframscript -file ratio_rr.wl NEWFILE OLDFILE *)
{nf, of} = Rest[$ScriptCommandLine][[;; 2]];
Num[x_] := x; Den[x_] := 1/x;
read[f_] := Module[{s = ReadString[f]}, s = StringReplace[s, {RegularExpression["^\\s*[\\w\\[\\]]+\\s*=\\s*"] -> "", RegularExpression[";\\s*$"] -> ""}];
   ToExpression[s]];
byint[e_] := Module[{x = Expand[e, INT], ints}, ints = Union[Cases[x, _INT, Infinity]];
   Association[# -> Together[Coefficient[x, #]] & /@ ints]];
n = byint[read[nf]]; o = byint[read[of]];
r = Factor /@ (Together /@ ((n /. m2 -> 1)/(o /. m2 -> 1)));
Print["distinct ratios new/old: ", Tally[Values[r]] // Short[#, 20] &];
d = Factor /@ (Together /@ ((n /. m2 -> 1) - (o /. m2 -> 1)));
Print["number of INT with new != old: ", Count[Values[d], x_ /; x =!= 0], " of ", Length[d]];

