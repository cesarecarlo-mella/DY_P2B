(* Created with the Wolfram Language : www.wolfram.com *)
{Log[1 + t] -> Log[1 + t], G[1, t^2] -> Log[1 - z], 
 G[r^(-1), t] -> -Log[1 + r*t] + Log[1 + u] + Log[1 - y] + Log[1 - z], 
 G[r, t] -> -Log[1 + t/r] - Log[u] + Log[1 + u] + Log[y] + Log[1 - z], 
 G[1, zb] -> Log[z], G[2, zb] -> Log[(1 + z)/2], 
 G[-1, t^2] -> Log[2] + Log[(1 + z)/2], Log[z]/2 -> Log[z]/2, 
 Log[u]/2 -> Log[u]/2, G[0, t^2] -> Log[z], Log[1 + r*t] -> Log[1 + r*t], 
 Log[1 + t/r] -> Log[1 + t/r], G[I, r] -> -G[-I, r] + Log[1 + u], 
 G[0, 0, t^2] -> Log[z]^2/2, G[0, 0, r] -> Log[u]^2/8, 
 G[0, 0, t] -> Log[z]^2/8, G[-1, -1, t^2] -> (Log[2] + Log[(1 + z)/2])^2/2, 
 G[0, 1, zb] -> -PolyLog[2, 1 - z], G[1, 1, zb] -> Log[z]^2/2, 
 G[2, 2, zb] -> Log[2]^2/2 - Log[2]*(Log[2] + Log[(1 + z)/2]) + 
   (Log[2] + Log[(1 + z)/2])^2/2, G[1, 2, zb] -> 
  -1/12*Pi^2 - Log[2]*Log[z] - PolyLog[2, -z], 
 G[2, 1, zb] -> Pi^2/12 + Log[z]*(Log[2] + Log[(1 + z)/2]) + PolyLog[2, -z], 
 G[0, 2, zb] -> -PolyLog[2, (1 - z)/2], 
 G[1, 0, t^2] -> Pi^2/6 - PolyLog[2, 1 - z], 
 G[0, -1, t^2] -> -PolyLog[2, -z], G[-1, 0, t^2] -> 
  Log[z]*(Log[2] + Log[(1 + z)/2]) + PolyLog[2, -z], 
 G[-1, 0, t] -> Pi^2/12 - G[1, 0, t] - PolyLog[2, 1 - z]/2, 
 G[-r, -r, t] -> Log[1 + t/r]^2/2, G[1, -1, t/r] -> 
  Pi^2/12 - Log[2]^2/2 + Log[2]*(-Log[1 + t/r] - Log[u] + Log[1 + u] + 
     Log[y] + Log[1 - z]) - PolyLog[2, (r - t)/(2*r)], 
 G[0, -r^(-1), t] -> -PolyLog[2, -(r*t)], G[0, -r, t] -> -PolyLog[2, -(t/r)], 
 G[-r^(-1), -r, t] -> -G[-r, -r^(-1), t] + Log[1 + t/r]*Log[1 + r*t], 
 G[-r, 0, t] -> (Log[1 + t/r]*Log[z])/2 + PolyLog[2, -(t/r)], 
 G[-r^(-1), -r^(-1), t] -> Log[1 + r*t]^2/2, 
 G[-r^(-1), 0, t] -> (Log[1 + r*t]*Log[z])/2 + PolyLog[2, -(r*t)], 
 G[1, -1, t^2] -> Pi^2/12 - Log[2]^2/2 + Log[2]*Log[1 - z] - 
   PolyLog[2, (1 - z)/2], G[r^(-1), -r^(-1), t] -> 
  Pi^2/12 - Log[2]^2/2 + Log[2]*(-Log[1 + r*t] + Log[1 + u] + Log[1 - y] + 
     Log[1 - z]) - PolyLog[2, (1 - r*t)/2], 
 G[r, -r, t] -> Pi^2/12 - Log[2]^2/2 + 
   Log[2]*(-Log[1 + t/r] - Log[u] + Log[1 + u] + Log[y] + Log[1 - z]) - 
   PolyLog[2, (r - t)/(2*r)], G[r, 0, t] -> 
  Pi^2/6 - (-Log[1 + t/r] - Log[u] + Log[1 + u] + Log[y] + Log[1 - z])*
    (-1/2*Log[u] + Log[z]/2) + 
   ((-Log[1 + t/r] - Log[u] + Log[1 + u] + Log[y] + Log[1 - z])*Log[z])/2 - 
   PolyLog[2, 1 - t/r], G[r^(-1), 0, t] -> 
  Pi^2/6 - (Log[u]*(-Log[1 + r*t] + Log[1 + u] + Log[1 - y] + Log[1 - z]))/
    2 - PolyLog[2, 1 - r*t], G[r, -r^(-1), t] -> 
  -1/2*Log[1 + u]^2 + Log[1 + u]*(-Log[1 + t/r] - Log[u] + Log[1 + u] + 
     Log[y] + Log[1 - z]) - PolyLog[2, -r^2] - 
   PolyLog[2, (r*(r - t))/(1 + r^2)], G[r^(-1), -r, t] -> 
  Pi^2/6 + Log[u]*Log[1 + u] - Log[1 + u]^2/2 - 
   Log[u]*(-Log[1 + r*t] + Log[1 + u] + Log[1 - y] + Log[1 - z]) + 
   Log[1 + u]*(-Log[1 + r*t] + Log[1 + u] + Log[1 - y] + Log[1 - z]) + 
   PolyLog[2, -r^2] - PolyLog[2, (1 - r*t)/(1 + r^2)], 
 G[1, -r^(-1), t] -> -1/2*Log[1 + r]^2 - Log[1 + r]*Log[1 + t] + 
   Log[1 + r]*Log[1 - z] - PolyLog[2, -r] - PolyLog[2, (r*(1 - t))/(1 + r)], 
 G[-1, -r^(-1), t] -> G[1, -r, t]/2 + G[-r, -r^(-1), t]/2 + Log[1 + r]^2/4 + 
   (Log[1 + r]*Log[1 + t])/2 + Log[1 + t]*Log[1 + r*t] - Log[1 + r*t]^2/2 - 
   (Log[1 + t/r] + Log[u]/2)^2/4 + (Log[1 + r]*Log[u])/4 - 
   (Log[1 + t]*Log[u])/4 + (Log[1 + r*t]*Log[u])/2 - 
   ((Log[1 + t/r] + Log[u]/2)*Log[u])/4 - Log[u]^2/16 - 
   (Log[1 + r]*Log[1 - z])/2 + (Log[u]*Log[1 - z])/4 + PolyLog[2, -r]/2 + 
   PolyLog[2, (1 - t)/(1 + r)]/2 - PolyLog[2, (-1 + r^2)/(r*(r + t))]/2 - 
   PolyLog[2, (1 - r)/(1 + r*t)], G[-1, -r, t] -> 
  -1/2*G[1, -r, t] - G[-r, -r^(-1), t]/2 - Log[1 + r]^2/4 - 
   (Log[1 + r]*Log[1 + t])/2 + Log[1 + t]*(Log[1 + t/r] + Log[u]/2) - 
   (Log[1 + t/r] + Log[u]/2)^2/4 - (Log[1 + r]*Log[u])/4 - 
   (Log[1 + t]*Log[u])/4 + ((Log[1 + t/r] + Log[u]/2)*Log[u])/4 + 
   Log[u]^2/16 + (Log[1 + r]*Log[1 - z])/2 - (Log[u]*Log[1 - z])/4 - 
   PolyLog[2, -r]/2 - PolyLog[2, (1 - t)/(1 + r)]/2 - 
   PolyLog[2, (-1 + r)/(r + t)] + PolyLog[2, (-1 + r^2)/(r*(r + t))]/2, 
 G[1, 1, 1, zb] -> Log[z]^3/6, G[1, 0, 1, zb] -> 
  -(Log[z]*PolyLog[2, 1 - z]) - 
   2*((Pi^2*Log[z])/6 - (Log[1 - z]*Log[z]^2)/2 - Log[z]*PolyLog[2, 1 - z] - 
     PolyLog[3, z] + Zeta[3]), G[0, 1, 1, zb] -> 
  (Pi^2*Log[z])/6 - (Log[1 - z]*Log[z]^2)/2 - Log[z]*PolyLog[2, 1 - z] - 
   PolyLog[3, z] + Zeta[3], G[0, 0, 1, zb] -> -PolyLog[3, 1 - z], 
 G[0, 0, 2, zb] -> -PolyLog[3, (1 - z)/2], 
 G[2, 2, 2, zb] -> Log[(1 + z)/2]^3/6, G[2, 1, 1, zb] -> 
  (Log[z]^2*(Log[2] + Log[(1 + z)/2]))/2 + Log[z]*PolyLog[2, -z] - 
   PolyLog[3, -z] - (3*Zeta[3])/4, G[2, 0, 1, zb] -> 
  (Pi^2*Log[2])/6 - Log[2]^3/3 + (Log[2]^2*Log[1 - z])/2 - (Pi^2*Log[z])/4 - 
   (Log[2]*Log[z]^2)/2 + (Log[1 - z]*Log[z]^2)/2 - Log[z]^3/6 - 
   (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 + (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/
    2 - Log[2]*Log[1 - z]*(Log[2] + Log[(1 + z)/2]) + 
   (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 - (Log[2] + Log[(1 + z)/2])^3/3 + 
   Log[z]*PolyLog[2, (1 - z)/2] + PolyLog[3, -1/2*(1 - z)/z] + 
   PolyLog[3, z] + PolyLog[3, (1 - z)/(1 + z)] + PolyLog[3, z/(1 + z)] + 
   PolyLog[3, (1 + z)/2] - (23*Zeta[3])/8, 
 G[2, 2, 1, zb] -> (5*Pi^2*Log[2])/12 - (7*Log[2]^3)/4 + 
   (7*Log[2]^2*Log[1 - z])/4 - Log[2]^2*Log[z] - 
   (Pi^2*(Log[2] + Log[(1 + z)/2]))/2 + 
   (7*Log[2]^2*(Log[2] + Log[(1 + z)/2]))/2 - 
   (7*Log[2]*Log[1 - z]*(Log[2] + Log[(1 + z)/2]))/2 - 
   (7*Log[2]*(Log[2] + Log[(1 + z)/2])^2)/4 + 
   (7*Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/4 + 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/6 - 
   2*Log[2]*PolyLog[2, (1 - z)/2] + 2*(Log[2] + Log[(1 + z)/2])*
    PolyLog[2, (1 - z)/2] - 2*Log[2]*PolyLog[2, -z] + 
   2*(Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] - PolyLog[3, -z] - 
   PolyLog[3, z/(1 + z)] + (7*PolyLog[3, (1 + z)/2])/2 + 
   2*((Pi^2*Log[2])/12 + (Log[2]^2*Log[z])/2 - (Log[2] + Log[(1 + z)/2])^3/
      6 + Log[2]*PolyLog[2, -z] - (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] + 
     PolyLog[3, -z] + PolyLog[3, z/(1 + z)] - Zeta[3]/8) - (27*Zeta[3])/8 + 
   (-1/6*(Pi^2*Log[2]) + Log[2]^3/2 - (Log[2]^2*Log[1 - z])/2 + 
     (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 - 
     Log[2]^2*(Log[2] + Log[(1 + z)/2]) + Log[2]*Log[1 - z]*
      (Log[2] + Log[(1 + z)/2]) + (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
     (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
     Log[2]*PolyLog[2, (1 - z)/2] - (Log[2] + Log[(1 + z)/2])*
      PolyLog[2, (1 - z)/2] - PolyLog[3, (1 + z)/2] + Zeta[3])/2 - 
   (3*(Log[2]*PolyLog[2, (1 - z)/2] - (Log[2] + Log[(1 + z)/2])*
       PolyLog[2, (1 - z)/2] - 2*(-1/6*(Pi^2*Log[2]) + Log[2]^3/2 - 
        (Log[2]^2*Log[1 - z])/2 + (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 - 
        Log[2]^2*(Log[2] + Log[(1 + z)/2]) + Log[2]*Log[1 - z]*
         (Log[2] + Log[(1 + z)/2]) + (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
        (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
        Log[2]*PolyLog[2, (1 - z)/2] - (Log[2] + Log[(1 + z)/2])*
         PolyLog[2, (1 - z)/2] - PolyLog[3, (1 + z)/2] + Zeta[3])))/2, 
 G[2, 0, 2, zb] -> Log[2]*PolyLog[2, (1 - z)/2] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, (1 - z)/2] - 
   2*(-1/6*(Pi^2*Log[2]) + Log[2]^3/2 - (Log[2]^2*Log[1 - z])/2 + 
     (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 - 
     Log[2]^2*(Log[2] + Log[(1 + z)/2]) + Log[2]*Log[1 - z]*
      (Log[2] + Log[(1 + z)/2]) + (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
     (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
     Log[2]*PolyLog[2, (1 - z)/2] - (Log[2] + Log[(1 + z)/2])*
      PolyLog[2, (1 - z)/2] - PolyLog[3, (1 + z)/2] + Zeta[3]), 
 G[0, 2, 1, zb] -> (Pi^2*Log[z])/4 + (Log[2]*Log[z]^2)/2 - 
   (Log[1 - z]*Log[z]^2)/2 + Log[z]^3/6 - Log[z]*PolyLog[2, (1 - z)/2] + 
   PolyLog[3, (1 - z)/2] - PolyLog[3, 1 - z] - PolyLog[3, -1/2*(1 - z)/z] + 
   PolyLog[3, -z] - PolyLog[3, z] + (7*Zeta[3])/4, 
 G[1, 2, 1, zb] -> (Log[1 - z]*Log[z]^2)/4 + (Log[z]*PolyLog[2, 1 - z])/2 - 
   Log[z]*PolyLog[2, -z] + 2*PolyLog[3, -z] + PolyLog[3, z]/2 + Zeta[3] + 
   ((Pi^2*Log[z])/6 - (Log[1 - z]*Log[z]^2)/2 - Log[z]*PolyLog[2, 1 - z] - 
     PolyLog[3, z] + Zeta[3])/2, G[1, 1, 2, zb] -> 
  -1/2*(Log[2]*Log[z]^2) - (Log[1 - z]*Log[z]^2)/4 - 
   (Log[z]*PolyLog[2, 1 - z])/2 - PolyLog[3, -z] - PolyLog[3, z]/2 + 
   (-1/6*(Pi^2*Log[z]) + (Log[1 - z]*Log[z]^2)/2 + Log[z]*PolyLog[2, 1 - z] + 
     PolyLog[3, z] - Zeta[3])/2 - Zeta[3]/4, 
 G[2, 1, 2, zb] -> Log[2]^3/4 - (Log[2]^2*Log[1 - z])/4 + Log[2]^2*Log[z] - 
   (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/2 + 
   (Log[2]*Log[1 - z]*(Log[2] + Log[(1 + z)/2]))/2 - 
   Log[2]*Log[z]*(Log[2] + Log[(1 + z)/2]) + 
   (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/4 - 
   (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/4 + 
   (Log[2]*PolyLog[2, (1 - z)/2])/2 - 
   ((Log[2] + Log[(1 + z)/2])*PolyLog[2, (1 - z)/2])/2 + 
   Log[2]*PolyLog[2, -z] - (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] - 
   PolyLog[3, (1 + z)/2]/2 + ((Pi^2*Log[2])/6 - Log[2]^3/2 + 
     (Log[2]^2*Log[1 - z])/2 - (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 + 
     Log[2]^2*(Log[2] + Log[(1 + z)/2]) - Log[2]*Log[1 - z]*
      (Log[2] + Log[(1 + z)/2]) - (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
     (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
     Log[2]*PolyLog[2, (1 - z)/2] + (Log[2] + Log[(1 + z)/2])*
      PolyLog[2, (1 - z)/2] + PolyLog[3, (1 + z)/2] - Zeta[3])/2 - 
   2*((Pi^2*Log[2])/12 + (Log[2]^2*Log[z])/2 - (Log[2] + Log[(1 + z)/2])^3/
      6 + Log[2]*PolyLog[2, -z] - (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] + 
     PolyLog[3, -z] + PolyLog[3, z/(1 + z)] - Zeta[3]/8) + Zeta[3]/2, 
 G[0, 2, 2, zb] -> -1/6*(Pi^2*Log[2]) + Log[2]^3/2 - 
   (Log[2]^2*Log[1 - z])/2 + (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 - 
   Log[2]^2*(Log[2] + Log[(1 + z)/2]) + Log[2]*Log[1 - z]*
    (Log[2] + Log[(1 + z)/2]) + (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
   (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
   Log[2]*PolyLog[2, (1 - z)/2] - (Log[2] + Log[(1 + z)/2])*
    PolyLog[2, (1 - z)/2] - PolyLog[3, (1 + z)/2] + Zeta[3], 
 G[1, 0, 2, zb] -> (Pi^2*Log[2])/6 - Log[2]^3/3 + (Log[2]^2*Log[1 - z])/2 - 
   (Pi^2*Log[z])/4 - (Log[2]*Log[z]^2)/2 + (Log[1 - z]*Log[z]^2)/2 - 
   Log[z]^3/6 - (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 + 
   (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/2 - Log[2]*Log[1 - z]*
    (Log[2] + Log[(1 + z)/2]) + (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 - (Log[2] + Log[(1 + z)/2])^3/3 - 
   Log[2]*PolyLog[2, 1 - z] + (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] + 
   PolyLog[3, -1/2*(1 - z)/z] + PolyLog[3, z] + PolyLog[3, (1 - z)/(1 + z)] + 
   PolyLog[3, z/(1 + z)] + PolyLog[3, (1 + z)/2] - (23*Zeta[3])/8, 
 G[1, 2, 2, zb] -> (Pi^2*Log[2])/12 + (Log[2]^2*Log[z])/2 - 
   (Log[2] + Log[(1 + z)/2])^3/6 + Log[2]*PolyLog[2, -z] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] + PolyLog[3, -z] + 
   PolyLog[3, z/(1 + z)] - Zeta[3]/8, G[0, 1, 2, zb] -> 
  -1/6*(Pi^2*Log[2]) + Log[2]^3/3 - (Log[2]^2*Log[1 - z])/2 + 
   (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 - (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/
    2 + Log[2]*Log[1 - z]*(Log[2] + Log[(1 + z)/2]) - 
   (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/3 + 
   Log[2]*PolyLog[2, 1 - z] - (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] - 
   PolyLog[3, (1 - z)/2] + PolyLog[3, 1 - z] - PolyLog[3, -z] - 
   PolyLog[3, (1 - z)/(1 + z)] - PolyLog[3, z/(1 + z)] - 
   PolyLog[3, (1 + z)/2] + (9*Zeta[3])/8, G[(-2*z)/(1 - z), 1] -> 
  -Log[z] + Log[(1 + z)/2], G[-(z/(1 - z)), 1] -> -Log[z], 
 G[0, (-2*z)/(1 - z), 1] -> Pi^2/12 + Log[2]*Log[z] + Log[z]^2/2 - 
   PolyLog[2, (1 - z)/2] + PolyLog[2, 1 - z] + PolyLog[2, -z], 
 G[0, -(z/(1 - z)), 1] -> Log[z]^2/2 + PolyLog[2, 1 - z], 
 G[(-2*z)/(1 - z), 0, 1] -> -1/12*Pi^2 - Log[2]*Log[z] - Log[z]^2/2 + 
   PolyLog[2, (1 - z)/2] - PolyLog[2, 1 - z] - PolyLog[2, -z], 
 G[(-2*z)/(1 - z), 1, 1] -> -1/12*Pi^2 + Log[2]^2/2 - 
   Log[2]*(Log[2] + Log[(1 + z)/2]) - Log[z]*(Log[2] + Log[(1 + z)/2]) + 
   (Log[2] + Log[(1 + z)/2])^2/2 + PolyLog[2, (1 - z)/2] - 
   PolyLog[2, 1 - z] - PolyLog[2, -z], 
 G[(-2*z)/(1 - z), (-2*z)/(1 - z), 1] -> (-Log[z] + Log[(1 + z)/2])^2/2, 
 G[-(z/(1 - z)), 0, 1] -> -1/2*Log[z]^2 - PolyLog[2, 1 - z], 
 G[-(z/(1 - z)), 1, 1] -> -PolyLog[2, 1 - z], 
 G[-(z/(1 - z)), (-2*z)/(1 - z), 1] -> Pi^2/12 + Log[2]*Log[z] + Log[z]^2/2 + 
   PolyLog[2, -z], G[-(z/(1 - z)), -(z/(1 - z)), 1] -> Log[z]^2/2, 
 G[0, 0, (-2*z)/(1 - z), 1] -> -PolyLog[3, -1/2*(1 - z)/z], 
 G[0, 0, -(z/(1 - z)), 1] -> -1/6*(Pi^2*Log[z]) + (Log[1 - z]*Log[z]^2)/2 - 
   Log[z]^3/6 + PolyLog[3, 1 - z] + PolyLog[3, z] - Zeta[3], 
 G[0, 1, (-2*z)/(1 - z), 1] -> (5*Pi^2*Log[2])/12 + (2*Log[2]^3)/3 - 
   Log[2]^2*Log[1 - z] + (5*Pi^2*Log[z])/12 + Log[2]^2*Log[z] - 
   2*Log[2]*Log[1 - z]*Log[z] + (Log[2]*Log[z]^2)/2 - Log[1 - z]*Log[z]^2 + 
   Log[z]^3/6 - (3*Pi^2*(Log[2] + Log[(1 + z)/2]))/4 - 
   Log[2]^2*(Log[2] + Log[(1 + z)/2]) + 2*Log[2]*Log[1 - z]*
    (Log[2] + Log[(1 + z)/2]) - Log[2]*Log[z]*(Log[2] + Log[(1 + z)/2]) + 
   2*Log[1 - z]*Log[z]*(Log[2] + Log[(1 + z)/2]) - 
   (Log[z]^2*(Log[2] + Log[(1 + z)/2]))/2 + 
   I*Pi*(Log[2] + Log[(1 + z)/2])^2 - Log[1 - z]*(Log[2] + Log[(1 + z)/2])^
     2 + Log[z]*(Log[2] + Log[(1 + z)/2])^2 + Log[2]*PolyLog[2, (1 - z)/2] + 
   Log[z]*PolyLog[2, (1 - z)/2] - (Log[2] + Log[(1 + z)/2])*
    PolyLog[2, (1 - z)/2] - Log[2]*PolyLog[2, 1 - z] - 
   Log[z]*PolyLog[2, 1 - z] + (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] - 
   Log[2]*PolyLog[2, -z] - Log[z]*PolyLog[2, -z] + 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] - PolyLog[3, -1/2*(1 - z)/z] + 
   2*PolyLog[3, -z] + 2*PolyLog[3, z/(1 + z)] - 
   2*((Pi^2*Log[2])/6 + Log[2]^3/6 - (Log[2]^2*Log[1 - z])/2 + 
     (Pi^2*Log[z])/6 + (Log[2]^2*Log[z])/2 - Log[2]*Log[1 - z]*Log[z] + 
     (Log[2]*Log[z]^2)/2 - (Log[1 - z]*Log[z]^2)/2 + Log[z]^3/6 - 
     (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 + Log[2]*Log[1 - z]*
      (Log[2] + Log[(1 + z)/2]) + Log[1 - z]*Log[z]*
      (Log[2] + Log[(1 + z)/2]) - (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
     (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
     (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/3 - 
     PolyLog[3, -1/2*(1 - z)/z] - PolyLog[3, (1 - z)/(1 + z)] + Zeta[3]) + 
   2*((Pi^2*(Log[2] + Log[(1 + z)/2]))/6 - 
     (I/2)*Pi*(Log[2] + Log[(1 + z)/2])^2 - 
     (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/6 - 
     PolyLog[3, -z] - PolyLog[3, z/(1 + z)] + Zeta[3]), 
 G[0, 1, -(z/(1 - z)), 1] -> (Pi^2*Log[z])/3 - (Log[1 - z]*Log[z]^2)/2 - 
   Log[z]*PolyLog[2, 1 - z] + PolyLog[3, 1 - z] - PolyLog[3, z] + Zeta[3], 
 G[0, (-2*z)/(1 - z), 0, 1] -> 2*PolyLog[3, -1/2*(1 - z)/z], 
 G[0, (-2*z)/(1 - z), 1, 1] -> -1/6*(Pi^2*Log[2]) - Log[2]^3/6 - 
   (Pi^2*Log[z])/6 - (Log[2]^2*Log[z])/2 - (Log[2]*Log[z]^2)/2 - Log[z]^3/6 + 
   (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 + (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/
    2 + Log[2]*Log[z]*(Log[2] + Log[(1 + z)/2]) + 
   (Log[z]^2*(Log[2] + Log[(1 + z)/2]))/2 - 
   (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/6 + 
   PolyLog[3, -1/2*(1 - z)/z] - PolyLog[3, (1 - z)/(1 + z)], 
 G[0, (-2*z)/(1 - z), (-2*z)/(1 - z), 1] -> -1/12*(Pi^2*Log[2]) + 
   Log[2]^3/6 - (Pi^2*Log[z])/12 - (Log[2]^2*Log[z])/2 - Log[2]*Log[z]^2 - 
   Log[z]^3/3 + (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 - 
   (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/2 + 
   (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 - (Log[2] + Log[(1 + z)/2])^3/6 + 
   Log[2]*PolyLog[2, (1 - z)/2] + Log[z]*PolyLog[2, (1 - z)/2] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, (1 - z)/2] - 
   Log[2]*PolyLog[2, 1 - z] - Log[z]*PolyLog[2, 1 - z] + 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] - Log[2]*PolyLog[2, -z] - 
   Log[z]*PolyLog[2, -z] + (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] + 
   PolyLog[3, -1/2*(1 - z)/z] + PolyLog[3, -z] + 
   (-4*PolyLog[3, -z] - 4*PolyLog[3, z])/4 + PolyLog[3, z] + 
   PolyLog[3, (1 - z)/(1 + z)], G[0, -(z/(1 - z)), 0, 1] -> 
  (Pi^2*Log[z])/3 - Log[1 - z]*Log[z]^2 + Log[z]^3/3 - 2*PolyLog[3, 1 - z] - 
   2*PolyLog[3, z] + 2*Zeta[3], G[0, -(z/(1 - z)), 1, 1] -> 
  -1/2*(Log[1 - z]*Log[z]^2) - 2*PolyLog[3, 1 - z] - PolyLog[3, z] + Zeta[3], 
 G[0, -(z/(1 - z)), -(z/(1 - z)), 1] -> (Pi^2*Log[z])/6 - 
   (Log[1 - z]*Log[z]^2)/2 - Log[z]^3/6 - Log[z]*PolyLog[2, 1 - z] - 
   PolyLog[3, z] + Zeta[3], G[(-2*z)/(1 - z), 0, 0, 1] -> 
  -PolyLog[3, -1/2*(1 - z)/z], G[(-2*z)/(1 - z), 0, 1, 1] -> 
  (Pi^2*Log[2])/4 - Log[2]^3/6 + (Pi^2*Log[z])/4 + (Log[2]^2*Log[z])/2 + 
   Log[2]*Log[z]^2 + Log[z]^3/3 - (Pi^2*(Log[2] + Log[(1 + z)/2]))/4 + 
   (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/2 - 
   (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/6 - 
   Log[2]*PolyLog[2, (1 - z)/2] - Log[z]*PolyLog[2, (1 - z)/2] + 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, (1 - z)/2] + 
   Log[2]*PolyLog[2, 1 - z] + Log[z]*PolyLog[2, 1 - z] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] + Log[2]*PolyLog[2, -z] + 
   Log[z]*PolyLog[2, -z] - (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] - 
   2*PolyLog[3, -1/2*(1 - z)/z] - PolyLog[3, (1 - z)/(1 + z)], 
 G[(-2*z)/(1 - z), 0, (-2*z)/(1 - z), 1] -> (Pi^2*Log[2])/12 - Log[2]^3/3 + 
   (Pi^2*Log[z])/12 + (Log[2]*Log[z]^2)/2 + Log[z]^3/6 - 
   (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 + Log[2]^2*(Log[2] + Log[(1 + z)/2]) + 
   Log[2]*Log[z]*(Log[2] + Log[(1 + z)/2]) + 
   (Log[z]^2*(Log[2] + Log[(1 + z)/2]))/2 - 
   Log[2]*(Log[2] + Log[(1 + z)/2])^2 - Log[z]*(Log[2] + Log[(1 + z)/2])^2 + 
   (Log[2] + Log[(1 + z)/2])^3/3 - Log[2]*PolyLog[2, (1 - z)/2] - 
   Log[z]*PolyLog[2, (1 - z)/2] + (Log[2] + Log[(1 + z)/2])*
    PolyLog[2, (1 - z)/2] + Log[2]*PolyLog[2, 1 - z] + 
   Log[z]*PolyLog[2, 1 - z] - (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] + 
   Log[2]*PolyLog[2, -z] + Log[z]*PolyLog[2, -z] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] - 2*PolyLog[3, -1/2*(1 - z)/z] - 
   2*PolyLog[3, -z] - 2*PolyLog[3, z] + (4*PolyLog[3, -z] + 4*PolyLog[3, z])/
    2 - 2*PolyLog[3, (1 - z)/(1 + z)], G[(-2*z)/(1 - z), 1, 0, 1] -> 
  -1/12*(Pi^2*Log[2]) + Log[2]^3/3 - (Pi^2*Log[z])/12 - (Log[2]*Log[z]^2)/2 - 
   Log[z]^3/6 + (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 - 
   Log[2]^2*(Log[2] + Log[(1 + z)/2]) - Log[2]*Log[z]*
    (Log[2] + Log[(1 + z)/2]) - (Log[z]^2*(Log[2] + Log[(1 + z)/2]))/2 + 
   Log[2]*(Log[2] + Log[(1 + z)/2])^2 + Log[z]*(Log[2] + Log[(1 + z)/2])^2 - 
   (Log[2] + Log[(1 + z)/2])^3/3 + Log[2]*PolyLog[2, (1 - z)/2] + 
   Log[z]*PolyLog[2, (1 - z)/2] - (Log[2] + Log[(1 + z)/2])*
    PolyLog[2, (1 - z)/2] - Log[2]*PolyLog[2, 1 - z] - 
   Log[z]*PolyLog[2, 1 - z] + (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] - 
   Log[2]*PolyLog[2, -z] - Log[z]*PolyLog[2, -z] + 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] + PolyLog[3, -1/2*(1 - z)/z] + 
   2*PolyLog[3, (1 - z)/(1 + z)], G[(-2*z)/(1 - z), 1, (-2*z)/(1 - z), 1] -> 
  (Pi^2*Log[2])/4 + Log[2]^3/2 - Log[2]^2*Log[1 - z] + (Pi^2*Log[z])/4 + 
   (Log[2]^2*Log[z])/2 - 2*Log[2]*Log[1 - z]*Log[z] - Log[1 - z]*Log[z]^2 - 
   (7*Pi^2*(Log[2] + Log[(1 + z)/2]))/12 - 
   (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/2 + 2*Log[2]*Log[1 - z]*
    (Log[2] + Log[(1 + z)/2]) + 2*Log[1 - z]*Log[z]*
    (Log[2] + Log[(1 + z)/2]) + I*Pi*(Log[2] + Log[(1 + z)/2])^2 - 
   (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
   Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2 + 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/6 + 
   Log[2]*PolyLog[2, (1 - z)/2] + Log[z]*PolyLog[2, (1 - z)/2] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, (1 - z)/2] - 
   Log[2]*PolyLog[2, 1 - z] - Log[z]*PolyLog[2, 1 - z] + 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] - Log[2]*PolyLog[2, -z] - 
   Log[z]*PolyLog[2, -z] + (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] + 
   2*PolyLog[3, -z] + 2*PolyLog[3, z/(1 + z)] - 
   2*((Pi^2*Log[2])/6 + Log[2]^3/6 - (Log[2]^2*Log[1 - z])/2 + 
     (Pi^2*Log[z])/6 + (Log[2]^2*Log[z])/2 - Log[2]*Log[1 - z]*Log[z] + 
     (Log[2]*Log[z]^2)/2 - (Log[1 - z]*Log[z]^2)/2 + Log[z]^3/6 - 
     (Pi^2*(Log[2] + Log[(1 + z)/2]))/6 + Log[2]*Log[1 - z]*
      (Log[2] + Log[(1 + z)/2]) + Log[1 - z]*Log[z]*
      (Log[2] + Log[(1 + z)/2]) - (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
     (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
     (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/3 - 
     PolyLog[3, -1/2*(1 - z)/z] - PolyLog[3, (1 - z)/(1 + z)] + Zeta[3]) + 
   2*((Pi^2*(Log[2] + Log[(1 + z)/2]))/6 - 
     (I/2)*Pi*(Log[2] + Log[(1 + z)/2])^2 - 
     (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/6 - 
     PolyLog[3, -z] - PolyLog[3, z/(1 + z)] + Zeta[3]), 
 G[(-2*z)/(1 - z), (-2*z)/(1 - z), 0, 1] -> 
  Log[2]^3/6 + (Log[2]^2*Log[z])/2 + (Log[2]*Log[z]^2)/2 + Log[z]^3/6 - 
   (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/2 - 
   Log[2]*Log[z]*(Log[2] + Log[(1 + z)/2]) - 
   (Log[z]^2*(Log[2] + Log[(1 + z)/2]))/2 + 
   (Log[2]*(Log[2] + Log[(1 + z)/2])^2)/2 + 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 - (Log[2] + Log[(1 + z)/2])^3/6 + 
   PolyLog[3, -1/2*(1 - z)/z] + PolyLog[3, -z] + 
   (-4*PolyLog[3, -z] - 4*PolyLog[3, z])/4 + PolyLog[3, z] + 
   PolyLog[3, (1 - z)/(1 + z)], G[(-2*z)/(1 - z), (-2*z)/(1 - z), 1, 1] -> 
  (Pi^2*Log[2])/12 - Log[2]^3/3 + (Pi^2*Log[z])/12 + (Log[2]*Log[z]^2)/2 + 
   Log[z]^3/6 - (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 + 
   Log[2]^2*(Log[2] + Log[(1 + z)/2]) + Log[2]*Log[z]*
    (Log[2] + Log[(1 + z)/2]) + (Log[z]^2*(Log[2] + Log[(1 + z)/2]))/2 - 
   Log[2]*(Log[2] + Log[(1 + z)/2])^2 - Log[z]*(Log[2] + Log[(1 + z)/2])^2 + 
   (Log[2] + Log[(1 + z)/2])^3/3 - Log[2]*PolyLog[2, (1 - z)/2] - 
   Log[z]*PolyLog[2, (1 - z)/2] + (Log[2] + Log[(1 + z)/2])*
    PolyLog[2, (1 - z)/2] + Log[2]*PolyLog[2, 1 - z] + 
   Log[z]*PolyLog[2, 1 - z] - (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] + 
   Log[2]*PolyLog[2, -z] + Log[z]*PolyLog[2, -z] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] - PolyLog[3, -1/2*(1 - z)/z] - 
   PolyLog[3, -z] - PolyLog[3, z] + (4*PolyLog[3, -z] + 4*PolyLog[3, z])/4 - 
   PolyLog[3, (1 - z)/(1 + z)], G[(-2*z)/(1 - z), (-2*z)/(1 - z), 
   (-2*z)/(1 - z), 1] -> (-Log[z] + Log[(1 + z)/2])^3/6, 
 G[-(z/(1 - z)), 0, 0, 1] -> -1/6*(Pi^2*Log[z]) + (Log[1 - z]*Log[z]^2)/2 - 
   Log[z]^3/6 + PolyLog[3, 1 - z] + PolyLog[3, z] - Zeta[3], 
 G[-(z/(1 - z)), 0, 1, 1] -> -1/6*(Pi^2*Log[z]) + Log[1 - z]*Log[z]^2 + 
   Log[z]*PolyLog[2, 1 - z] + PolyLog[3, 1 - z] + 2*PolyLog[3, z] - 
   2*Zeta[3], G[-(z/(1 - z)), 0, (-2*z)/(1 - z), 1] -> 
  -1/6*(Pi^2*Log[2]) + Log[2]^3/3 - (Log[2]^2*Log[1 - z])/2 - 
   (Pi^2*Log[z])/6 + (Log[1 - z]*Log[z]^2)/2 + 
   (Pi^2*(Log[2] + Log[(1 + z)/2]))/12 - (Log[2]^2*(Log[2] + Log[(1 + z)/2]))/
    2 + Log[2]*Log[1 - z]*(Log[2] + Log[(1 + z)/2]) - 
   (Log[1 - z]*(Log[2] + Log[(1 + z)/2])^2)/2 - 
   (Log[z]*(Log[2] + Log[(1 + z)/2])^2)/2 + (Log[2] + Log[(1 + z)/2])^3/3 + 
   Log[2]*PolyLog[2, 1 - z] + Log[z]*PolyLog[2, 1 - z] - 
   (Log[2] + Log[(1 + z)/2])*PolyLog[2, 1 - z] - PolyLog[3, -1/2*(1 - z)/z] - 
   PolyLog[3, -z] + PolyLog[3, z] - PolyLog[3, (1 - z)/(1 + z)] - 
   PolyLog[3, z/(1 + z)] - PolyLog[3, (1 + z)/2] + Zeta[3]/8, 
 G[-(z/(1 - z)), 0, -(z/(1 - z)), 1] -> -1/3*(Pi^2*Log[z]) + 
   Log[1 - z]*Log[z]^2 - Log[z]^3/6 + Log[z]*PolyLog[2, 1 - z] + 
   2*PolyLog[3, z] - 2*Zeta[3], G[-(z/(1 - z)), 1, 0, 1] -> 
  (Pi^2*Log[z])/6 - (Log[1 - z]*Log[z]^2)/2 - Log[z]*PolyLog[2, 1 - z] + 
   PolyLog[3, 1 - z] - PolyLog[3, z] + Zeta[3], 
 G[-(z/(1 - z)), 1, -(z/(1 - z)), 1] -> (Pi^2*Log[z])/3 - 
   Log[1 - z]*Log[z]^2 - Log[z]*PolyLog[2, 1 - z] - 2*PolyLog[3, z] + 
   2*Zeta[3], G[-(z/(1 - z)), (-2*z)/(1 - z), 0, 1] -> 
  (Pi^2*Log[z])/12 + (Log[2]*Log[z]^2)/2 + Log[z]^3/6 - 
   PolyLog[3, (1 - z)/2] + PolyLog[3, 1 - z] + PolyLog[3, -1/2*(1 - z)/z] + 
   PolyLog[3, -z] + (3*Zeta[3])/4, 
 G[-(z/(1 - z)), (-2*z)/(1 - z), (-2*z)/(1 - z), 1] -> 
  -1/12*(Pi^2*Log[2]) - (Log[2]^2*Log[z])/2 - (Log[2]*Log[z]^2)/2 - 
   Log[z]^3/6 + (Log[2] + Log[(1 + z)/2])^3/6 - Log[2]*PolyLog[2, -z] - 
   Log[z]*PolyLog[2, -z] + (Log[2] + Log[(1 + z)/2])*PolyLog[2, -z] - 
   PolyLog[3, z/(1 + z)] + (7*Zeta[3])/8, 
 G[-(z/(1 - z)), -(z/(1 - z)), 0, 1] -> (Pi^2*Log[z])/6 - 
   (Log[1 - z]*Log[z]^2)/2 + Log[z]^3/3 - PolyLog[3, z] + Zeta[3], 
 G[-(z/(1 - z)), -(z/(1 - z)), -(z/(1 - z)), 1] -> -1/6*Log[z]^3, 
 G[(-2*t)/(r - t), 1] -> -Log[2] + Log[1 + t/r] + Log[u]/2 - Log[z]/2, 
 G[(-2*t)/(r - t), 1] -> -Log[2] + Log[1 + t/r] + Log[u]/2 - Log[z]/2, 
 G[(-2*r*t)/(1 - r*t), 1] -> -Log[2] + Log[1 + r*t] - Log[u]/2 - Log[z]/2, 
 G[-((r*t)/(1 - r*t)), 1] -> -1/2*Log[u] - Log[z]/2, 
 G[-((r*(r + t))/(1 - r*t)), 1] -> -Log[1 + t/r] - Log[u] + Log[1 + u], 
 G[0, -((1 + r*t)/(r^2 - r*t)), 1] -> Log[1 + r*t]^2/2 - 
   Log[1 + r*t]*Log[1 + u] + Log[1 + u]^2/2 + 
   PolyLog[2, (r*(r - t))/(1 + r^2)], G[0, (-2*r*t)/(1 - r*t), 1] -> 
  Pi^2/12 + (Log[2]*Log[u])/2 + Log[u]^2/8 + (Log[2]*Log[z])/2 + 
   (Log[u]*Log[z])/4 + Log[z]^2/8 + PolyLog[2, -(r*t)] - 
   PolyLog[2, (1 - r*t)/2] + PolyLog[2, 1 - r*t], 
 G[0, -((r*(r + t))/(1 - r*t)), 1] -> Log[1 + t/r]^2/2 + 
   Log[1 + t/r]*Log[u] + Log[u]^2/2 - Log[1 + t/r]*Log[1 + u] - 
   Log[u]*Log[1 + u] + Log[1 + u]^2/2 + PolyLog[2, (1 - r*t)/(1 + r^2)], 
 G[-(t/(r - t)), -((1 + r*t)/(r^2 - r*t)), 1] -> 
  -1/2*(Log[1 + r*t]*Log[u]) + (Log[1 + r*t]*Log[z])/2 - PolyLog[2, -r^2] + 
   PolyLog[2, -(r*t)], G[(-2*t)/(r - t), -((1 + r*t)/(r^2 - r*t)), 1] -> 
  Pi^2/12 - Log[2]^2/2 + Log[2]*Log[1 + r*t] - Log[1 + t/r]*Log[1 + r*t] - 
   (Log[1 + r*t]*Log[u])/2 + Log[1 + t/r]*Log[1 + u] + Log[u]*Log[1 + u] - 
   Log[1 + u]^2/2 + (Log[1 + r*t]*Log[z])/2 + PolyLog[2, -(r*t)] - 
   PolyLog[2, (1 - r*t)/2] + PolyLog[2, 1 - r*t] - 
   PolyLog[2, (1 - r*t)/(1 + r^2)], 
 G[(-2*r*t)/(1 - r*t), -((r*(r + t))/(1 - r*t)), 1] -> 
  Pi^2/12 - Log[2]^2/2 + Log[2]*Log[1 + t/r] - Log[1 + t/r]*Log[1 + r*t] + 
   (Log[1 + t/r]*Log[u])/2 - Log[1 + r*t]*Log[u] + Log[u]^2/2 + 
   Log[1 + r*t]*Log[1 + u] - Log[1 + u]^2/2 + (Log[1 + t/r]*Log[z])/2 - 
   PolyLog[2, (r - t)/(2*r)] - PolyLog[2, (r*(r - t))/(1 + r^2)] + 
   PolyLog[2, -(t/r)] + PolyLog[2, 1 - t/r], 
 G[-((1 + r*t)/(r^2 - r*t)), 1, 1] -> -PolyLog[2, (r*(r - t))/(1 + r^2)], 
 G[(-2*r*t)/(1 - r*t), 0, 1] -> -1/12*Pi^2 - (Log[2]*Log[u])/2 - Log[u]^2/8 - 
   (Log[2]*Log[z])/2 - (Log[u]*Log[z])/4 - Log[z]^2/8 - PolyLog[2, -(r*t)] + 
   PolyLog[2, (1 - r*t)/2] - PolyLog[2, 1 - r*t], 
 G[(-2*r*t)/(1 - r*t), 1, 1] -> -1/12*Pi^2 + Log[2]^2/2 - 
   Log[2]*Log[1 + r*t] + Log[1 + r*t]^2/2 - (Log[1 + r*t]*Log[u])/2 - 
   (Log[1 + r*t]*Log[z])/2 - PolyLog[2, -(r*t)] + PolyLog[2, (1 - r*t)/2] - 
   PolyLog[2, 1 - r*t], G[(-2*r*t)/(1 - r*t), (-2*r*t)/(1 - r*t), 1] -> 
  Log[2]^2/2 - Log[2]*Log[1 + r*t] + Log[1 + r*t]^2/2 + (Log[2]*Log[u])/2 - 
   (Log[1 + r*t]*Log[u])/2 + Log[u]^2/8 + (Log[2]*Log[z])/2 - 
   (Log[1 + r*t]*Log[z])/2 + (Log[u]*Log[z])/4 + Log[z]^2/8, 
 G[(-2*r*t)/(1 - r*t), -((r*(r + t))/(1 - r*t)), 1] -> 
  Pi^2/12 - Log[2]^2/2 + Log[2]*Log[1 + t/r] - Log[1 + t/r]*Log[1 + r*t] + 
   (Log[1 + t/r]*Log[u])/2 - Log[1 + r*t]*Log[u] + Log[u]^2/2 + 
   Log[1 + r*t]*Log[1 + u] - Log[1 + u]^2/2 + (Log[1 + t/r]*Log[z])/2 - 
   PolyLog[2, (r - t)/(2*r)] - PolyLog[2, (r*(r - t))/(1 + r^2)] + 
   PolyLog[2, -(t/r)] + PolyLog[2, 1 - t/r], G[-((r*t)/(1 - r*t)), 0, 1] -> 
  -1/8*Log[u]^2 - (Log[u]*Log[z])/4 - Log[z]^2/8 - PolyLog[2, 1 - r*t], 
 G[-((r*t)/(1 - r*t)), (-2*r*t)/(1 - r*t), 1] -> 
  Pi^2/12 + (Log[2]*Log[u])/2 + Log[u]^2/8 + (Log[2]*Log[z])/2 + 
   (Log[u]*Log[z])/4 + Log[z]^2/8 + PolyLog[2, -(r*t)], 
 G[-((r*t)/(1 - r*t)), -((r*(r + t))/(1 - r*t)), 1] -> 
  Pi^2/6 + (Log[1 + t/r]*Log[u])/2 + Log[u]^2/2 + (Log[1 + t/r]*Log[z])/2 + 
   PolyLog[2, -r^2] + PolyLog[2, -(t/r)], 
 G[-((r*(r + t))/(1 - r*t)), 0, 1] -> -1/2*Log[1 + t/r]^2 - 
   Log[1 + t/r]*Log[u] - Log[u]^2/2 + Log[1 + t/r]*Log[1 + u] + 
   Log[u]*Log[1 + u] - Log[1 + u]^2/2 - PolyLog[2, (1 - r*t)/(1 + r^2)], 
 G[-((r*(r + t))/(1 - r*t)), 1, 1] -> -PolyLog[2, (1 - r*t)/(1 + r^2)], 
 G[-((r*(r + t))/(1 - r*t)), (-2*r*t)/(1 - r*t), 1] -> 
  -1/12*Pi^2 + Log[2]^2/2 + Log[2]*Log[u] - Log[2]*Log[1 + u] - 
   (Log[u]*Log[1 + u])/2 + Log[1 + u]^2/2 + (Log[u]*Log[z])/2 - 
   (Log[1 + u]*Log[z])/2 + PolyLog[2, (r - t)/(2*r)] + 
   PolyLog[2, (r*(r - t))/(1 + r^2)] - PolyLog[2, -(t/r)] - 
   PolyLog[2, 1 - t/r], G[-((r*(r + t))/(1 - r*t)), -((r*(r + t))/(1 - r*t)), 
   1] -> Log[1 + t/r]^2/2 + Log[1 + t/r]*Log[u] + Log[u]^2/2 - 
   Log[1 + t/r]*Log[1 + u] - Log[u]*Log[1 + u] + Log[1 + u]^2/2, 
 G[0, (2*t^2)/(-1 + t^2), 1] -> Pi^2/12 - Log[2]^2/2 + 
   (Log[2] + Log[z])^2/2 - PolyLog[2, (1 - z)/2] + PolyLog[2, 1 - z] + 
   PolyLog[2, -z], G[t^2/(-1 + t^2), 0, 1] -> 
  -1/2*Log[z]^2 - PolyLog[2, 1 - z], 
 G[t^2/(-1 + t^2), (2*t^2)/(-1 + t^2), 1] -> Pi^2/12 - Log[2]^2/2 + 
   (Log[2] + Log[z])^2/2 + PolyLog[2, -z], G[0, (r^2 + r*t)/(-1 + r*t), 1] -> 
  (Pi^2/3 + (Log[1 + t/r] + Log[u] - Log[1 + u])*(Log[1 + t/r] + Log[u] - 
      Log[1 + u] - 2*(-Log[1 + r*t] + Log[1 - y] + Log[1 - z])) - 
    2*PolyLog[2, (r*(r + t))/(1 + r^2)])/2, G[(r*t)/(-1 + r*t), 0, 1] -> 
  -1/6*Pi^2 + (-Log[1 + r*t] + Log[1 + u] + Log[1 - y] + Log[1 - z])*
    (Log[u]/2 + Log[z]/2) - (Log[u]/2 + Log[z]/2)^2/2 + PolyLog[2, r*t], 
 G[(r^2 + r*t)/(-1 + r*t), 0, 1] -> 
  -1/6*Pi^2 + (-((Log[1 + t/r] + Log[u] - Log[1 + u])*
       (Log[1 + t/r] + Log[u] - Log[1 + u] - 2*(-Log[1 + r*t] + Log[1 - y] + 
          Log[1 - z]))) + 2*PolyLog[2, (r*(r + t))/(1 + r^2)])/2, 
 G[(r*t)/(-1 + r*t), (2*r*t)/(-1 + r*t), 1] -> 
  -1/4*Pi^2 + (4*G[(r*t)/(-1 + r*t), (r^2 + r*t)/(-1 + r*t), 1] + 
     Log[2]*Log[u] - 2*Log[1 + t/r]*Log[u] - (7*Log[u]^2)/4 - 
     2*Log[1 + t/r]*Log[z] + (Log[2] + Log[u]/2)*Log[z] + Log[z]^2/4 - 
     4*PolyLog[2, -r^2] - 4*PolyLog[2, -(t/r)] + 2*PolyLog[2, -(r*t)])/2, 
 G[(2*r*t)/(-1 + r*t), 0, 1] -> (-Pi^2 + 2*Log[2]^2)/4 - 
   (Log[2] + Log[u]/2)^2/2 - Log[2]*(-Log[1 + r*t] + Log[1 + u] + 
     Log[1 - y] + Log[1 - z]) + (Log[2] + Log[u]/2)*
    (-Log[1 + r*t] + Log[1 + u] + Log[1 - y] + Log[1 - z]) - 
   ((Log[2] + Log[u]/2)*Log[z])/2 + 
   ((-Log[1 + r*t] + Log[1 + u] + Log[1 - y] + Log[1 - z])*Log[z])/2 - 
   Log[z]^2/8 - PolyLog[2, -(r*t)] + PolyLog[2, r*t] + 
   PolyLog[2, (1 - r*t)/2]}
