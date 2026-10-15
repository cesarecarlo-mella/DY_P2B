(* Minimum set cover for the new families (called by families.py --exact).

   In:   cover_problem.m    {nTails, {{tails covered by candidate 1}, {... candidate 2}, ...}}   (tail indices 1..nTails)
   Out:  cover_solution.m   {candidate indices chosen}, as few as possible with every tail covered
   Integer linear programme: minimise sum x_k, x_k >= 0 integer, sum_{k covers t} x_k >= 1 for every tail t
   (matrix form LinearOptimization[c, {a, b}, {}, Integers]: a.x + b >= 0). Stops with exit code 1 on any failure. *)

SetDirectory[DirectoryName[$InputFileName]];
{nT, covers} = Get["cover_problem.m"];
nC = Length[covers];
A = SparseArray[Flatten[Table[{t, k} -> 1, {k, nC}, {t, covers[[k]]}], 1], {nT, nC}];
a = Join[A, IdentityMatrix[nC, SparseArray]];               (* cover every tail;  x >= 0 *)
b = Join[ConstantArray[-1, nT], ConstantArray[0, nC]];
t0 = AbsoluteTime[];
x = LinearOptimization[ConstantArray[1, nC], {a, b}, {}, Integers];
If[! (VectorQ[x, IntegerQ] && Length[x] === nC), Print["LinearOptimization failed: ", Short[x]]; Exit[1]];
chosen = Flatten[Position[x, n_ /; n >= 1]];
If[Min[A[[All, chosen]] . ConstantArray[1, Length[chosen]]] < 1, Print["cover check failed"]; Exit[1]];
Export["cover_solution.m", chosen];
Print[nC, " candidates, ", nT, " tails: minimum cover = ", Length[chosen], " families (", Round[AbsoluteTime[] - t0], " s)"];
