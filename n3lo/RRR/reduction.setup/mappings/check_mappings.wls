
FullFamilies = Import["../Families_Identification/Families.m"];
symmetryRelated = Import["../Families_Identification/SYMMETRY_RELABELLING/symmetryRelated.m"];
WhichMapped = Import["../Families_Identification/SYMMETRY_RELABELLING/WhichMapped.m"];
symmetryRelatedSectors = symmetryRelated /. INT[fam_, {bin__}] :> INT[fam, FromDigits[Reverse[{bin} /. _nisp :> 0 /. _n :> 1], 2], {bin}];
topoToN = 
  Table[Thread[Rule[ToExpression["topo" <> ToString[i]], i]], {i, 1, 
    300}];
SetAttributes[sp, Orderless]
sp[a_Integer b_, c_] := a sp[b, c]
sp[a_Rational b_, c_] := a sp[b, c]
sp[a_Complex b_, c_] := a sp[b, c]
sp[a_ , b_ + c_] := sp[a, b] + sp[a, c]
TransverseTensor = {Tr[mu_, nu_, 
    q_] -> - (g[mu, nu] - q[mu] q[nu]/sp[q, q]) }
kin = { sp[p1, p1] -> 0, sp[p2, p2] -> 0, sp[p1, p2] -> s12/2}
denoms = {
   (* on-shell cut propagators *)
   DD1 -> sp[r1, r1], DD2 -> sp[r2, r2], DD3 -> sp[r3, r3], 
   DD4 -> sp[p1 + p2 + r1 + r2 + r3, p1 + p2 + r1 + r2 + r3] - m2,
   (* cut rapidity propagator *)
   DD5 -> (sp[q, -p1 + u p2] /. sp[a_, u b_] :> u sp[a, b] /. 
          q -> -p1 - p2 - r1 - r2 - r3 /. kin /. 
        sp[-p1 - p2 - r1 - r2 - r3, 
          a_] -> -sp[p1 + p2 + r1 + r2 - r3, a] /. 
       sp[a__, -p1] -> -sp[a, p1] // Expand),
   DD6 -> sp[p1 + r1, p1 + r1],
   DD7 -> sp[p2 + r1, p2 + r1],
   DD8 -> sp[p1 + r2, p1 + r2],
   DD9 -> sp[p2 + r2, p2 + r2],
   DD10 -> sp[p1 + r3, p1 + r3],
   DD11 -> sp[p2 + r3, p2 + r3],
   DD12 -> sp[r1 + r2, r1 + r2],
   DD13 -> sp[r2 + r3, r2 + r3],
   DD14 -> sp[r1 + r3, r1 + r3],
   DD15 -> sp[p1 + r1 + r2, p1 + r1 + r2],
   DD16 -> sp[p2 + r1 + r2, p2 + r1 + r2],
   DD17 -> sp[p1 + r1 + r3, p1 + r1 + r3],
   DD18 -> sp[p2 + r1 + r3, p2 + r1 + r3],
   DD19 -> sp[p1 + r2 + r3, p1 + r2 + r3],
   DD20 -> sp[p2 + r2 + r3, p2 + r2 + r3],
   DD21 -> sp[r1 + r2 + r3, r1 + r2 + r3],
   DD22 -> sp[p1 + r1 + r2 + r3, p1 + r1 + r2 + r3],
   DD23 -> sp[p2 + r1 + r2 + r3, p2 + r1 + r2 + r3]
   };
sps = {sp[p1, r1], sp[p1, r2], sp[p1, r3], sp[p2, r1], sp[p2, r2], 
   sp[p2, r3], sp[r1, r1], sp[r1, r2], sp[r1, r3], sp[r2, r2], 
   sp[r2, r3], sp[r3, r3]};
Do[SPs2Ds[
   i] = (Solve[
      Thread[(FullFamilies[[i, 2]] /. 
          DD[a_] :> ToExpression[
            "DD" <> ToString[a]] ) == (((FullFamilies[[i, 2]] /. 
              DD[a_] :> ToExpression["DD" <> ToString[a]] )) /. 
           denoms /. kin)], sps] // Flatten) /. 
   Rule[a_, b_] :> Rule[a, Collect[b, denoms[[All, 1]], Factor]], {i, 
  1, Length[FullFamilies]}]
dd2dd = Table[
   ToExpression["DD" <> ToString[i]] -> DD[i], {i, 1, Length[denoms]}];
dd2ddRev = dd2dd /. Rule[a_, b_] :> Rule[b, a];


mappings = Import["./mappings.m"];

listchecked = {};
Do[
 todo = mappings[[tocheck]][[1, 1]] /. INT[a_, bin__] -> INT[a, {bin}];
 lhs = (FullFamilies[[todo[[1]] /. topoToN]][[2]]^(-(todo[[2]])) /. 
          List -> Times) /. dd2ddRev /. denoms  /. 
      mappings[[tocheck]][[2]] /. kin /. m2 -> s12 z  /. s12 -> 1/z // Simplify;
 intsrhs = 
  Union@Cases[mappings[[tocheck]][[1, 2]] 2 , _INT, \[Infinity]] /. 
   INT[a_, bin__] -> INT[a, {bin}];
 props = FullFamilies[[intsrhs[[1, 1]] /. topoToN]][[2]];
 raised = 
  Power[props, #] & /@ (intsrhs /. INT[a_, b_, {bin__}] :> -{bin}) ;
 Do[raised[[i]] = raised[[i]] /. List -> Times, {i, 1, Length[raised]}];
 replacement = Thread[Rule[intsrhs, raised]];
 rhs = mappings[[tocheck]][[1, 2]] /. replacement /. dd2ddRev /. 
      denoms /. kin /. m2 -> s12 z /. s12 -> 1/z // Simplify;
 rhs = rhs // Simplify;
 lhs = lhs // Simplify;
 checked =  Factor[(DD[1] DD[2] DD[3] DD[4] DD[
       5] (((rhs - lhs // Simplify) /. 
            SPs2Ds[intsrhs[[1, 1]] /. topoToN] // Simplify) /. dd2dd ))]/. DD[a_] /; a < 6 -> 0;
listchecked = Append[listchecked, {tocheck,checked}];
If[Mod[tocheck,100]===0, Export["./listchecked.m",listchecked]];
 Print[tocheck, "     ", checked
], {tocheck, 1000, Length[mappings]}]
