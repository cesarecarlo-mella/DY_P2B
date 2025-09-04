NExt = 2;
NLoops = 1;

NSP = NLoops + NLoops*(NLoops-1)/2+NLoops*NExt;

Get["tmp/propagators.m"]
Get["tmp/input.m"]

Print["Running ISP.m with ", NExt, " massless external legs and ", NLoops, 
  " loops. The number of scalar products to substitute is ", NSP, "."];
  
kin = {p1^2 -> 0, p2^2 -> 0, p1 p2 -> (m2)/2};

Print["The kinematical relations are: ", kin];
Nfam = Length[propagators];

momtmp = 
 Join[Table[{"kx", ToString[i]}, {i, 1, NLoops}], 
  Table[{"px", ToString[i]}, {i, 1, NExt}]] 
mom = Table[
  Symbol[StringReplace[momtmp[[i, 1]], "x" -> momtmp[[i, 2]]]], {i, 1,
    Length[momtmp]}]
SPvar = Table[
   SP[mom[[i]], mom[[j]]], {i, 1, NLoops}, {j, i, Length[mom]}] // Flatten
ruleSP = 
 Table[mom[[i]]*mom[[j]] -> SP[mom[[i]], mom[[j]]], {i, 1, 
    NLoops}, {j, i, Length[mom]}] // Flatten
  
sol = Table[{ToString[
     propagators[[i, 1, 
      1]] ], ((Solve[(propagators[[i, 1, 2]] /. 
               Rule[a_, b__] -> a == b^2 // Expand) /. ruleSP /. kin, 
          SPvar]) /. SP[a_, b_] -> a . b // Flatten ) /. 
     Rule[a_, b_] -> {a, b}} , {i, 1, Nfam}] ;


    
solmm = Table[{ToString[
     propagators[[i, 1, 
       1]]], ((Solve[(propagators[[i, 1, 2]] /. 
              Rule[a_, b__] -> a == b^2 // Expand) /. ruleSP /. kin, 
         SPvar]) /. SP[a_, b_] -> a b // Flatten)}, {i, 1, Nfam}];

Print[solmm]
PrettyText[var_] := 
 StringReplace[ToString[InputForm[var]], {" " -> ""}]

For[i = 1, i <= Nfam, i++, mypath  = "tmp/ISP/" <> sol[[i, 1]] <> ".inc"; 
 Quiet@Close[mypath]; Quiet@DeleteFile[mypath]; 
 file = OpenAppend[mypath]; For[j = 1, j <= NSP, j++,
  WriteString[file, 
   "id " <> PrettyText[sol[[i, 2]][[j]][[1]]] <> " = " <> 
    PrettyText[sol[[i, 2]][[j]][[2]]] <> ";\n"]
  ]]


(*
words2mom = 
  Thread[
   Rule[Flatten[input[[;; , 2]] , 1][[;; , 2]], 
    Flatten[input[[;; , 2]] , 1][[;; , 1]]]];
externalCombo = 
  Table[input[[-1, 2]][[i, 2]] . input[[-1, 2]][[j, 2]], {i, 1, 
     Length[input[[-1, 2]]]}, {j, i, Length[input[[-1, 2]]]}] // 
   Flatten ;
externalComboRHS = (Table[(input[[-1, 2]][[i, 2]] /. 
           words2mom) (input[[-1, 2]][[j, 2]] /. words2mom), {i, 1, 
         Length[input[[-1, 2]]]}, {j, i, Length[input[[-1, 2]]]}] // 
       Flatten  // Expand ) /. kin // Simplify;
solExternal = Thread[List[externalCombo, externalComboRHS]];
mypath = "tmp/ISP/externalCombo.inc";
Quiet@Close[mypath]; Quiet@DeleteFile[mypath];
file = OpenAppend[mypath];
For[i = 1, i <= Length[solExternal], i++, 
 WriteString[file, 
   "id " <> PrettyText[solExternal[[i, 1]]] <> " = " <> 
    PrettyText[solExternal[[i, 2]]] <> ";\n"];]


For[i = 1, i <= Nfam, i++,
 name = ToString[input[[i, 1]]];
 toPick = Position[solmm, name][[1, 1]];
 loopCombo = 
  Table[input[[i, 2]][[j, 2]] . input[[i, 2]][[k, 2]], {j, 1, 
     Length[input[[i, 2]]]}, {k, j, Length[input[[i, 2]]]}] // 
   Flatten ;
 loopComboRHS = ((Table[(input[[i, 2]][[j, 2]] /. 
               words2mom) (input[[i, 2]][[k, 2]] /. words2mom), {j, 1,
              Length[input[[i, 2]]]}, {k, j, Length[input[[i, 2]]]}] // 
           Flatten  // Expand ) /. kin // Simplify // Expand) /. 
    solmm[[toPick, 2]] // Simplify;
 loopExternalCombo = 
  Table[input[[i, 2]][[j, 2]] . input[[-1, 2]][[k, 2]], {j, 1, 
     Length[input[[i, 2]]]}, {k, 1, Length[input[[-1, 2]]]}] // 
   Flatten ;
 loopExternalComboRHS = ((Table[(input[[i, 2]][[j, 2]] /. 
               words2mom) (input[[-1, 2]][[k, 2]] /. words2mom), {j, 
             1, Length[input[[i, 2]]]}, {k, 1, 
             Length[input[[-1, 2]]]}] // Flatten  // Expand ) /. kin // 
       Simplify // Expand) /. solmm[[toPick, 2]] // Simplify;
 solLoop = Thread[List[loopCombo, loopComboRHS]];
 solExternalLoop = 
  Thread[List[loopExternalCombo, loopExternalComboRHS]];
 solLE = Join[solLoop, solExternalLoop];
 mypath = "tmp/ISP/Combo_" <> name <> ".inc";
 Quiet@Close[mypath]; Quiet@DeleteFile[mypath];
 file = OpenAppend[mypath];
 For[p = 1, p <= Length[solLE], p++, 
  WriteString[file, 
    "id " <> PrettyText[solLE[[p, 1]]] <> " = " <> 
     PrettyText[solLE[[p, 2]]] <> ";\n"];]
 ]
    *)


		  
Print["ISP.m done!"]


