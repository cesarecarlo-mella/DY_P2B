(* Created with the Wolfram Language : www.wolfram.com *)
{G[I, r] -> -G[-I, r] + Log[1 + r^2], 
 G[0, -I, r] -> -G[0, I, r] - G[-I, 0, r] + G[-I, -I, r] + G[-I, I, r] - 
   G[I, 0, r] + G[I, -I, r] + G[I, I, r] + Log[r]*Log[1 + r^2] - 
   Log[1 + r^2]^2/2, G[-I, 0, r] -> G[-I, -I, r] + G[-I, I, r] - G[I, 0, r] + 
   G[I, -I, r] + G[I, I, r] + Log[r]*Log[1 + r^2] - Log[1 + r^2]^2/2 + 
   PolyLog[2, -r^2]/2, G[-I, -I, r] -> 
  (-2*(G[-I, I, r] + G[I, -I, r] + G[I, I, r]) + Log[1 + r^2]^2)/2, 
 G[0, 0, -I, r] -> -1/2*G[0, -1, -1, r^2] - G[0, 0, I, r] - G[0, -I, 0, r] + 
   G[0, -I, -I, r] + G[0, -I, I, r] - G[0, I, 0, r] + G[0, I, -I, r] + 
   G[0, I, I, r] - (Log[r]*PolyLog[2, -r^2])/2 + PolyLog[3, -r^2]/4, 
 G[0, -I, 0, r] -> -1/2*G[0, -1, -1, r^2] + G[0, -I, -I, r] + 
   G[0, -I, I, r] - G[0, I, 0, r] + G[0, I, -I, r] + G[0, I, I, r] + 
   (2*G[-I, 0, 0, r])/5 + (2*G[I, 0, 0, r])/5 - (Log[r]^2*Log[1 + r^2])/5 - 
   (7*Log[r]*PolyLog[2, -r^2])/10 + (3*PolyLog[3, -r^2])/5, 
 G[-I, 0, 0, r] -> (-4*G[I, 0, 0, r] + 2*Log[r]*(Log[r]*Log[1 + r^2] + 
      PolyLog[2, -r^2]) - PolyLog[3, -r^2])/4, 
 G[-I, 0, -I, r] -> -G[0, -1, -1, r^2] - G[-I, 0, I, r] - G[I, 0, -I, r] - 
   G[I, 0, I, r] - (Log[1 + r^2]*PolyLog[2, -r^2])/2, 
 G[-I, -I, 0, r] -> (2*G[0, -1, -1, r^2] - 4*G[-I, I, 0, r] - 
    4*G[I, -I, 0, r] - 4*G[I, I, 0, r] + G[-1, 0, r^2]*Log[1 + r^2] - 
    G[0, -1, r^2]*Log[1 + r^2])/4, G[-I, -I, -I, r] -> 
  (-6*(G[-I, -I, I, r] + G[-I, I, -I, r] + G[-I, I, I, r] + G[I, -I, -I, r] + 
      G[I, -I, I, r] + G[I, I, -I, r] + G[I, I, I, r]) + Log[1 + r^2]^3)/6, 
 Log[1 - I*r] -> Log[1 - I*r], PolyLog[2, I*r] -> PolyLog[2, I*r], 
 G[0, -I, -I, r] -> (G[0, -1, -1, r^2] - 
    2*(G[0, -I, I, r] + G[0, I, -I, r] + G[0, I, I, r]))/2, 
 G[0, 0, 0, I, r] -> -G[0, 0, 0, -I, r] - G[0, 0, -I, 0, r] - 
   G[0, 0, I, 0, r] - G[0, -I, 0, 0, r] - G[0, I, 0, 0, r] - 
   G[-I, 0, 0, 0, r] - G[I, 0, 0, 0, r] + (Log[r]^3*Log[1 + r^2])/6, 
 G[0, 0, I, I, r] -> (G[0, 0, -1, -1, r^2] - 4*G[0, 0, -I, -I, r] - 
    4*G[0, 0, -I, I, r] - 4*G[0, 0, I, -I, r])/4, 
 G[0, I, 0, I, r] -> G[0, -1, 0, -1, r^2]/4 - G[0, -I, 0, -I, r] - 
   G[0, -I, 0, I, r] - G[0, I, 0, -I, r], G[0, I, I, 0, r] -> 
  G[0, -1, -1, 0, r^2]/4 - G[0, -I, -I, 0, r] - G[0, -I, I, 0, r] - 
   G[0, I, -I, 0, r], G[I, 0, 0, I, r] -> G[-1, 0, 0, -1, r^2]/4 - 
   G[-I, 0, 0, -I, r] - G[-I, 0, 0, I, r] - G[I, 0, 0, -I, r], 
 G[I, 0, I, 0, r] -> G[-1, 0, -1, 0, r^2]/4 - G[-I, 0, -I, 0, r] - 
   G[-I, 0, I, 0, r] - G[I, 0, -I, 0, r], G[0, I, I, I, r] -> 
  G[0, -1, -1, -1, r^2]/2 - G[0, -I, -I, -I, r] - G[0, -I, -I, I, r] - 
   G[0, -I, I, -I, r] - G[0, -I, I, I, r] - G[0, I, -I, -I, r] - 
   G[0, I, -I, I, r] - G[0, I, I, -I, r], G[I, 0, I, I, r] -> 
  G[-1, 0, -1, -1, r^2]/2 - G[-I, 0, -I, -I, r] - G[-I, 0, -I, I, r] - 
   G[-I, 0, I, -I, r] - G[-I, 0, I, I, r] - G[I, 0, -I, -I, r] - 
   G[I, 0, -I, I, r] - G[I, 0, I, -I, r], G[I, I, 0, 0, r] -> 
  G[-1, -1, 0, 0, r^2]/4 - G[-I, -I, 0, 0, r] - G[-I, I, 0, 0, r] - 
   G[I, -I, 0, 0, r], G[I, I, 0, I, r] -> G[-1, -1, 0, -1, r^2]/2 - 
   G[-I, -I, 0, -I, r] - G[-I, -I, 0, I, r] - G[-I, I, 0, -I, r] - 
   G[-I, I, 0, I, r] - G[I, -I, 0, -I, r] - G[I, -I, 0, I, r] - 
   G[I, I, 0, -I, r], G[I, I, I, 0, r] -> G[-1, -1, -1, 0, r^2]/2 - 
   G[-I, -I, -I, 0, r] - G[-I, -I, I, 0, r] - G[-I, I, -I, 0, r] - 
   G[-I, I, I, 0, r] - G[I, -I, -I, 0, r] - G[I, -I, I, 0, r] - 
   G[I, I, -I, 0, r], G[I, I, I, I, r] -> G[-1, -1, -1, -1, r^2] - 
   G[-I, -I, -I, -I, r] - G[-I, -I, -I, I, r] - G[-I, -I, I, -I, r] - 
   G[-I, -I, I, I, r] - G[-I, I, -I, -I, r] - G[-I, I, -I, I, r] - 
   G[-I, I, I, -I, r] - G[-I, I, I, I, r] - G[I, -I, -I, -I, r] - 
   G[I, -I, -I, I, r] - G[I, -I, I, -I, r] - G[I, -I, I, I, r] - 
   G[I, I, -I, -I, r] - G[I, I, -I, I, r] - G[I, I, I, -I, r], 
 G[I, 0, 0, 0, r] -> G[-1, 0, 0, 0, r^2]/8 + G[0, -1, 0, 0, r^2]/12 + 
   G[0, 0, -1, 0, r^2]/6 - (4*G[0, 0, -I, 0, r])/3 - (4*G[0, 0, I, 0, r])/3 - 
   (2*G[0, -I, 0, 0, r])/3 - (2*G[0, I, 0, 0, r])/3 - G[-I, 0, 0, 0, r], 
 G[0, 0, I, 0, r] -> G[0, 0, -1, 0, r^2]/8 - G[0, 0, -I, 0, r], 
 G[0, I, 0, 0, r] -> G[0, -1, 0, 0, r^2]/8 - G[0, -I, 0, 0, r]}
