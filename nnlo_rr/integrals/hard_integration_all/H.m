(* Created with the Wolfram Language : www.wolfram.com *)
{H[1, IF1] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF1] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF1] -> (2*eps^2*Pi^2)/3 + G[0, t]*(-4*eps - 12*eps^2*G[-I, r] - 
     12*eps^2*G[I, r]) + G[-I, r]*(-3*eps - 3*eps^2*G[-r, t] - 
     3*eps^2*G[r, t]) + G[I, r]*(-3*eps - 3*eps^2*G[-r, t] - 
     3*eps^2*G[r, t]) + G[0, r]*(-2*eps - 8*eps^2*G[0, t] - 
     3*eps^2*G[-r, t] + eps^2*G[r, t]) + 23*eps^2*G[-1, -1, t^2] + 
   3*eps^2*G[-1, 0, t^2] + eps^2*G[0, -1, t^2] - 4*eps^2*G[0, 0, r] - 
   16*eps^2*G[0, 0, t] + 13*eps^2*G[0, 0, t^2] - 12*eps^2*G[0, -I, r] - 
   12*eps^2*G[0, I, r] - 4*eps^2*G[0, -r, t] - 6*eps^2*G[-I, 0, r] - 
   6*eps^2*G[-I, -I, r] - 6*eps^2*G[-I, I, r] - 6*eps^2*G[I, 0, r] - 
   6*eps^2*G[I, -I, r] - 6*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 
   2*eps^2*G[1, 0, t^2] - 3*eps^2*G[-r, 0, t] - 2*eps^2*G[-r, -r, t] - 
   eps^2*G[r, 0, t] + 3*eps^2*G[r, -r^(-1), t] + eps^2*G[r, -r, t] - 
   3*eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] - eps^2*G[r, t]*Log[2] - 
   (47*eps^2*Log[2]^2)/2 + G[-r, t]*(-eps + eps^2*Log[2]) + 
   G[0, t^2]*(eps + 3*eps^2*Log[2]) + G[-1, t^2]*(7*eps + 5*eps^2*Log[2]) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/2 + (eps^2*(Pi^2 + 24*Log[2]^2))/3, 
 H[4, IF1] -> -1/2*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(2*eps + 8*eps^2*G[0, t] + 
     4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - 
     eps^2*G[r, t]) + G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] + 4*eps^2*G[0, 0, r] - 
   5*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   2*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), -r, t] + 
   3*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + 
   eps^2*G[r, 0, t] - eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - 
   eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[5, IF1] -> -1/4*(eps^2*Pi^2) + G[-I, r]*(3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(3*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   14*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t^2] - 8*eps^2*G[0, 0, r] + 
   4*eps^2*G[0, 0, t^2] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(4*eps + 2*eps^2*Log[2]) + G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r^(-1), t]*(-2*eps - 3*eps^2*G[-I, r] - 3*eps^2*G[I, r] + 
     4*eps^2*Log[2]) + G[0, r]*(-2*eps - 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 
     8*eps^2*Log[2]) + (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + 
   (eps^2*(Pi^2 - 24*Log[2]^2))/6 + (eps^2*(Pi^2 + 24*Log[2]^2))/6, 
 H[6, IF1] -> -1/2*(eps^2*Pi^2) + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(4*eps + 16*eps^2*G[0, t] + 
     6*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 6*eps^2*G[-r, t] - 
     2*eps^2*G[r, t]) + G[-I, r]*(2*eps + 3*eps^2*G[-r^(-1), t] + 
     3*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(2*eps + 3*eps^2*G[-r^(-1), t] + 3*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) - 20*eps^2*G[-1, -1, t^2] - 
   12*eps^2*G[-1, 0, t^2] - 14*eps^2*G[0, -1, t^2] + 8*eps^2*G[0, 0, r] + 
   24*eps^2*G[0, 0, t] - 14*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 
   4*eps^2*G[0, I, r] + 8*eps^2*G[0, -r^(-1), t] + 8*eps^2*G[0, -r, t] + 
   8*eps^2*G[-I, 0, r] + 8*eps^2*G[I, 0, r] + 2*eps^2*G[1, -1, t^2] - 
   2*eps^2*G[1, 0, t^2] + 4*eps^2*G[-r^(-1), 0, t] + 
   4*eps^2*G[-r^(-1), -r^(-1), t] + 5*eps^2*G[-r^(-1), -r, t] + 
   4*eps^2*G[r^(-1), 0, t] - 4*eps^2*G[r^(-1), -r^(-1), t] - 
   3*eps^2*G[r^(-1), -r, t] + 6*eps^2*G[-r, 0, t] + 
   5*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 2*eps^2*G[r, 0, t] - 
   eps^2*G[r, -r^(-1), t] - 2*eps^2*G[r, -r, t] + 2*eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   2*eps^2*G[r, t]*Log[2] - 12*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-8*eps - 12*eps^2*Log[2]) + 
   G[-r^(-1), t]*(2*eps - 4*eps^2*Log[2]) + 
   G[0, t^2]*(-4*eps - 2*eps^2*Log[2]) + G[-r, t]*(2*eps - 2*eps^2*Log[2]) + 
   (eps^2*(Pi^2 + 66*Log[2]^2))/6 + (eps^2*(Pi^2 + 72*Log[2]^2))/6, 
 H[1, IF2] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF2] -> (eps^2*Pi^2)/24 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (7*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2), 
 H[3, IF2] -> -1/3*(eps^2*Pi^2) + G[0, t]*(-4*eps - 12*eps^2*G[-I, r] - 
     12*eps^2*G[I, r]) + 5*eps^2*G[0, r]*G[r^(-1), t] + 
   G[-I, r]*(-3*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t]) + 
   G[I, r]*(-3*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t]) + 
   23*eps^2*G[-1, -1, t^2] + 7*eps^2*G[-1, 0, t^2] + 5*eps^2*G[0, -1, t^2] - 
   16*eps^2*G[0, 0, t] + 5*eps^2*G[0, 0, t^2] - 4*eps^2*G[0, -r^(-1), t] - 
   6*eps^2*G[-I, 0, r] - 6*eps^2*G[-I, -I, r] - 6*eps^2*G[-I, I, r] - 
   6*eps^2*G[I, 0, r] - 6*eps^2*G[I, -I, r] - 6*eps^2*G[I, I, r] + 
   2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 3*eps^2*G[-r^(-1), 0, t] - 
   2*eps^2*G[-r^(-1), -r^(-1), t] - eps^2*G[r^(-1), 0, t] + 
   eps^2*G[r^(-1), -r^(-1), t] + 3*eps^2*G[r^(-1), -r, t] - 3*eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] - eps^2*G[r^(-1), t]*Log[2] - 
   (31*eps^2*Log[2]^2)/2 + G[0, t^2]*(eps - eps^2*Log[2]) + 
   G[-r^(-1), t]*(-eps + eps^2*G[0, r] + eps^2*Log[2]) + 
   G[-1, t^2]*(7*eps + 5*eps^2*Log[2]) + (eps^2*(Pi^2 + 24*Log[2]^2))/3, 
 H[4, IF2] -> (eps^2*Pi^2)/16 + G[-I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + G[I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + (11*eps^2*G[-1, -1, t^2])/4 - 
   (15*eps^2*G[-1, 0, t^2])/4 - (23*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 + (7*eps^2*G[0, 0, t^2])/4 - 
   8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + (19*eps^2*G[0, -r^(-1), t])/4 + 
   (3*eps^2*G[0, -r, t])/4 - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (33*eps^2*G[-r^(-1), 0, t])/8 + (11*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 + (5*eps^2*G[r^(-1), 0, t])/8 - 
   (5*eps^2*G[r^(-1), -r^(-1), t])/8 - (5*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (19*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + (5*eps^2*G[r^(-1), t]*Log[2])/8 - 
   (3*eps^2*G[r, t]*Log[2])/8 + (3*eps^2*Log[2]^2)/16 + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r^(-1), t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*(eps/2 + eps^2*G[0, t] + (33*eps^2*G[-r^(-1), t])/8 - 
     (5*eps^2*G[r^(-1), t])/8 + (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - 
     eps^2*Log[2]) + G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - 
     (eps^2*Log[2])/2) + G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[0, t^2]*((-5*eps)/4 + (3*eps^2*Log[2])/4) + 
   (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF2] -> -1/4*(eps^2*Pi^2) + G[-I, r]*(3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(3*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   14*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t^2] - 8*eps^2*G[0, 0, r] + 
   4*eps^2*G[0, 0, t^2] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(4*eps + 2*eps^2*Log[2]) + G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r^(-1), t]*(-2*eps - 3*eps^2*G[-I, r] - 3*eps^2*G[I, r] + 
     4*eps^2*Log[2]) + G[0, r]*(-2*eps - 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 
     8*eps^2*Log[2]) + (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + 
   (eps^2*(Pi^2 - 24*Log[2]^2))/6 + (eps^2*(Pi^2 + 24*Log[2]^2))/6, 
 H[6, IF2] -> (-5*eps^2*Pi^2)/6 + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(4*eps + 16*eps^2*G[0, t] + 
     8*eps^2*G[-r^(-1), t] + 4*eps^2*G[-r, t] - 4*eps^2*G[r, t]) + 
   G[-I, r]*(2*eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] + 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(2*eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] + 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) - 20*eps^2*G[-1, -1, t^2] - 
   12*eps^2*G[-1, 0, t^2] - 14*eps^2*G[0, -1, t^2] + 24*eps^2*G[0, 0, t] - 
   14*eps^2*G[0, 0, t^2] + 12*eps^2*G[0, -I, r] + 12*eps^2*G[0, I, r] + 
   8*eps^2*G[0, -r^(-1), t] + 8*eps^2*G[0, -r, t] + 8*eps^2*G[-I, 0, r] + 
   8*eps^2*G[I, 0, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   6*eps^2*G[-r^(-1), 0, t] + 4*eps^2*G[-r^(-1), -r^(-1), t] + 
   5*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), 0, t] - 
   2*eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   4*eps^2*G[-r, 0, t] + 5*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] + 
   2*eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + 2*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 12*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-8*eps - 12*eps^2*Log[2]) + 
   G[-r, t]*(2*eps - 4*eps^2*Log[2]) + G[0, t^2]*(-4*eps - 2*eps^2*Log[2]) + 
   G[-r^(-1), t]*(2*eps - 2*eps^2*Log[2]) + (eps^2*(Pi^2 + 66*Log[2]^2))/6 + 
   (eps^2*(Pi^2 + 72*Log[2]^2))/6, 
 H[1, IF3] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF3] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF3] -> (5*eps^2*Pi^2)/24 + G[0, t]*((-5*eps)/2 - 6*eps^2*G[-I, r] - 
     6*eps^2*G[I, r]) + G[-I, r]*((-3*eps)/2 - (3*eps^2*G[-r, t])/2 - 
     (3*eps^2*G[r, t])/2) + G[I, r]*((-3*eps)/2 - (3*eps^2*G[-r, t])/2 - 
     (3*eps^2*G[r, t])/2) + G[0, r]*(-1/2*eps - 4*eps^2*G[0, t] - 
     (eps^2*G[-r, t])/2 + (3*eps^2*G[r, t])/2) + (23*eps^2*G[-1, -1, t^2])/
    2 + (5*eps^2*G[-1, 0, t^2])/2 + (5*eps^2*G[0, -1, t^2])/2 + 
   eps^2*G[0, 0, r] - 11*eps^2*G[0, 0, t] + 5*eps^2*G[0, 0, t^2] - 
   3*eps^2*G[0, -I, r] - 3*eps^2*G[0, I, r] - (3*eps^2*G[0, -r^(-1), t])/2 - 
   (5*eps^2*G[0, -r, t])/2 - 3*eps^2*G[-I, 0, r] - 3*eps^2*G[-I, -I, r] - 
   3*eps^2*G[-I, I, r] - 3*eps^2*G[I, 0, r] - 3*eps^2*G[I, -I, r] - 
   3*eps^2*G[I, I, r] + eps^2*G[1, -1, t^2] - (5*eps^2*G[-r, 0, t])/2 - 
   eps^2*G[-r, -r, t] - (3*eps^2*G[r, 0, t])/2 + (3*eps^2*G[r, -r^(-1), t])/
    2 + (eps^2*G[r, -r, t])/2 - (3*eps*Log[2])/2 - eps^2*G[1, t^2]*Log[2] - 
   (eps^2*G[r, t]*Log[2])/2 + (eps^2*Log[2]^2)/4 + 
   G[-r, t]*(-1/2*eps + (eps^2*Log[2])/2) + 
   G[0, t^2]*(eps + (3*eps^2*Log[2])/2) + 
   G[-1, t^2]*((7*eps)/2 + (5*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 - 48*Log[2]^2))/12, 
 H[4, IF3] -> (eps^2*Pi^2)/16 + G[-I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + G[I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + (11*eps^2*G[-1, -1, t^2])/4 - 
   (15*eps^2*G[-1, 0, t^2])/4 - (23*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 + (7*eps^2*G[0, 0, t^2])/4 - 
   8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + (19*eps^2*G[0, -r^(-1), t])/4 + 
   (3*eps^2*G[0, -r, t])/4 - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (33*eps^2*G[-r^(-1), 0, t])/8 + (11*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 + (5*eps^2*G[r^(-1), 0, t])/8 - 
   (5*eps^2*G[r^(-1), -r^(-1), t])/8 - (5*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (19*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + (5*eps^2*G[r^(-1), t]*Log[2])/8 - 
   (3*eps^2*G[r, t]*Log[2])/8 + (3*eps^2*Log[2]^2)/16 + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r^(-1), t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*(eps/2 + eps^2*G[0, t] + (33*eps^2*G[-r^(-1), t])/8 - 
     (5*eps^2*G[r^(-1), t])/8 + (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - 
     eps^2*Log[2]) + G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - 
     (eps^2*Log[2])/2) + G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[0, t^2]*((-5*eps)/4 + (3*eps^2*Log[2])/4) + 
   (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF3] -> -1/2*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(2*eps + 8*eps^2*G[0, t] + 
     4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - 
     eps^2*G[r, t]) + G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] + 4*eps^2*G[0, 0, r] - 
   5*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   2*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), -r, t] + 
   3*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + 
   eps^2*G[r, 0, t] - eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - 
   eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF3] -> (-7*eps^2*Pi^2)/6 + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(2*eps + 2*eps^2*G[-1, t] + 
     16*eps^2*G[0, t] + 2*eps^2*G[1, t] + 2*eps^2*G[-r, t] - 
     6*eps^2*G[r, t]) + G[-I, r]*(2*eps + 4*eps^2*G[-r, t] + 
     4*eps^2*G[r, t]) + G[I, r]*(2*eps + 4*eps^2*G[-r, t] + 
     4*eps^2*G[r, t]) - 16*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t] - 
   8*eps^2*G[-1, 0, t^2] - 2*eps^2*G[-1, -r^(-1), t] + 2*eps^2*G[-1, -r, t] - 
   10*eps^2*G[0, -1, t^2] - 4*eps^2*G[0, 0, r] + 28*eps^2*G[0, 0, t] - 
   12*eps^2*G[0, 0, t^2] + 8*eps^2*G[0, -I, r] + 8*eps^2*G[0, I, r] + 
   6*eps^2*G[0, -r^(-1), t] + 10*eps^2*G[0, -r, t] + 8*eps^2*G[-I, 0, r] + 
   8*eps^2*G[I, 0, r] - 2*eps^2*G[1, -1, t^2] + 2*eps^2*G[1, 0, t] - 
   4*eps^2*G[1, 0, t^2] - 2*eps^2*G[1, -r^(-1), t] + 2*eps^2*G[1, -r, t] + 
   10*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 
   6*eps^2*G[r, 0, t] - 4*eps^2*G[r, -r^(-1), t] - 2*eps^2*G[r, -r, t] + 
   2*eps*Log[2] + 2*eps^2*G[1, t^2]*Log[2] + 2*eps^2*G[r, t]*Log[2] + 
   G[-1, t^2]*(-6*eps - 8*eps^2*Log[2]) + 
   G[0, t^2]*(-4*eps - 6*eps^2*Log[2]) + G[-r, t]*(2*eps - 2*eps^2*Log[2]) + 
   (eps^2*(Pi^2 - 3*Log[2]^2))/3 + (2*eps^2*(Pi^2 + 12*Log[2]^2))/3, 
 H[1, IF4] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF4] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF4] -> (5*eps^2*Pi^2)/24 + G[0, t]*((-5*eps)/2 - 6*eps^2*G[-I, r] - 
     6*eps^2*G[I, r]) + G[-I, r]*((-3*eps)/2 - (3*eps^2*G[-r^(-1), t])/2 - 
     (3*eps^2*G[r^(-1), t])/2) + 
   G[I, r]*((-3*eps)/2 - (3*eps^2*G[-r^(-1), t])/2 - 
     (3*eps^2*G[r^(-1), t])/2) + G[0, r]*(-1/2*eps - 4*eps^2*G[0, t] - 
     (eps^2*G[-r^(-1), t])/2 + (3*eps^2*G[r^(-1), t])/2) + 
   (23*eps^2*G[-1, -1, t^2])/2 + (9*eps^2*G[-1, 0, t^2])/2 + 
   (9*eps^2*G[0, -1, t^2])/2 + eps^2*G[0, 0, r] - 11*eps^2*G[0, 0, t] + 
   5*eps^2*G[0, 0, t^2] - 3*eps^2*G[0, -I, r] - 3*eps^2*G[0, I, r] - 
   (5*eps^2*G[0, -r^(-1), t])/2 - (3*eps^2*G[0, -r, t])/2 - 
   3*eps^2*G[-I, 0, r] - 3*eps^2*G[-I, -I, r] - 3*eps^2*G[-I, I, r] - 
   3*eps^2*G[I, 0, r] - 3*eps^2*G[I, -I, r] - 3*eps^2*G[I, I, r] + 
   eps^2*G[1, -1, t^2] - (5*eps^2*G[-r^(-1), 0, t])/2 - 
   eps^2*G[-r^(-1), -r^(-1), t] - (3*eps^2*G[r^(-1), 0, t])/2 + 
   (eps^2*G[r^(-1), -r^(-1), t])/2 + (3*eps^2*G[r^(-1), -r, t])/2 - 
   (3*eps*Log[2])/2 - eps^2*G[1, t^2]*Log[2] - (eps^2*G[r^(-1), t]*Log[2])/
    2 + (eps^2*Log[2]^2)/4 + G[0, t^2]*(eps - (eps^2*Log[2])/2) + 
   G[-r^(-1), t]*(-1/2*eps + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((7*eps)/2 + (5*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 - 48*Log[2]^2))/12, 
 H[4, IF4] -> (eps^2*Pi^2)/16 + G[-I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + G[I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + (11*eps^2*G[-1, -1, t^2])/4 - 
   (15*eps^2*G[-1, 0, t^2])/4 - (23*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 + (7*eps^2*G[0, 0, t^2])/4 - 
   8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + (19*eps^2*G[0, -r^(-1), t])/4 + 
   (3*eps^2*G[0, -r, t])/4 - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (33*eps^2*G[-r^(-1), 0, t])/8 + (11*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 + (5*eps^2*G[r^(-1), 0, t])/8 - 
   (5*eps^2*G[r^(-1), -r^(-1), t])/8 - (5*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (19*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + (5*eps^2*G[r^(-1), t]*Log[2])/8 - 
   (3*eps^2*G[r, t]*Log[2])/8 + (3*eps^2*Log[2]^2)/16 + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r^(-1), t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*(eps/2 + eps^2*G[0, t] + (33*eps^2*G[-r^(-1), t])/8 - 
     (5*eps^2*G[r^(-1), t])/8 + (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - 
     eps^2*Log[2]) + G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - 
     (eps^2*Log[2])/2) + G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[0, t^2]*((-5*eps)/4 + (3*eps^2*Log[2])/4) + 
   (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF4] -> -1/2*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(2*eps + 8*eps^2*G[0, t] + 
     4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - 
     eps^2*G[r, t]) + G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] + 4*eps^2*G[0, 0, r] - 
   5*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   2*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), -r, t] + 
   3*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + 
   eps^2*G[r, 0, t] - eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - 
   eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF4] -> (-7*eps^2*Pi^2)/6 + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(2*eps - 2*eps^2*G[-1, t] + 
     16*eps^2*G[0, t] - 2*eps^2*G[1, t] + 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t]) + G[-I, r]*(2*eps + 4*eps^2*G[-r^(-1), t] + 
     4*eps^2*G[r^(-1), t]) + G[I, r]*(2*eps + 4*eps^2*G[-r^(-1), t] + 
     4*eps^2*G[r^(-1), t]) - 16*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t] - 
   16*eps^2*G[-1, 0, t^2] + 2*eps^2*G[-1, -r^(-1), t] - 
   2*eps^2*G[-1, -r, t] - 18*eps^2*G[0, -1, t^2] - 4*eps^2*G[0, 0, r] + 
   28*eps^2*G[0, 0, t] - 12*eps^2*G[0, 0, t^2] + 8*eps^2*G[0, -I, r] + 
   8*eps^2*G[0, I, r] + 10*eps^2*G[0, -r^(-1), t] + 6*eps^2*G[0, -r, t] + 
   8*eps^2*G[-I, 0, r] + 8*eps^2*G[I, 0, r] - 2*eps^2*G[1, -1, t^2] + 
   2*eps^2*G[1, 0, t] - 4*eps^2*G[1, 0, t^2] + 2*eps^2*G[1, -r^(-1), t] - 
   2*eps^2*G[1, -r, t] + 10*eps^2*G[-r^(-1), 0, t] + 
   4*eps^2*G[-r^(-1), -r^(-1), t] + 2*eps^2*G[-r^(-1), -r, t] + 
   6*eps^2*G[r^(-1), 0, t] - 2*eps^2*G[r^(-1), -r^(-1), t] - 
   4*eps^2*G[r^(-1), -r, t] + 2*eps*Log[2] + 2*eps^2*G[1, t^2]*Log[2] + 
   2*eps^2*G[r^(-1), t]*Log[2] + G[-1, t^2]*(-6*eps - 8*eps^2*Log[2]) + 
   G[-r^(-1), t]*(2*eps - 2*eps^2*Log[2]) + 
   G[0, t^2]*(-4*eps + 2*eps^2*Log[2]) + (eps^2*(Pi^2 - 3*Log[2]^2))/3 + 
   (2*eps^2*(Pi^2 + 12*Log[2]^2))/3, 
 H[1, IF5] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF5] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF5] -> (eps^2*Pi^2)/6 + G[0, t]*(-4*eps - 12*eps^2*G[-I, r] - 
     12*eps^2*G[I, r]) + 5*eps^2*G[0, r]*G[r^(-1), t] + 
   G[-I, r]*(-3*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t]) + 
   G[I, r]*(-3*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t]) + 
   23*eps^2*G[-1, -1, t^2] + 7*eps^2*G[-1, 0, t^2] + 5*eps^2*G[0, -1, t^2] - 
   16*eps^2*G[0, 0, t] + 5*eps^2*G[0, 0, t^2] - 4*eps^2*G[0, -r^(-1), t] - 
   6*eps^2*G[-I, 0, r] - 6*eps^2*G[-I, -I, r] - 6*eps^2*G[-I, I, r] - 
   6*eps^2*G[I, 0, r] - 6*eps^2*G[I, -I, r] - 6*eps^2*G[I, I, r] + 
   2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 3*eps^2*G[-r^(-1), 0, t] - 
   2*eps^2*G[-r^(-1), -r^(-1), t] - eps^2*G[r^(-1), 0, t] + 
   eps^2*G[r^(-1), -r^(-1), t] + 3*eps^2*G[r^(-1), -r, t] - 3*eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] - eps^2*G[r^(-1), t]*Log[2] - 
   (47*eps^2*Log[2]^2)/2 + G[0, t^2]*(eps - eps^2*Log[2]) + 
   G[-r^(-1), t]*(-eps + eps^2*G[0, r] + eps^2*Log[2]) + 
   G[-1, t^2]*(7*eps + 5*eps^2*Log[2]) + (eps^2*(-Pi^2 + 16*Log[2]^2))/2 + 
   (eps^2*(Pi^2 + 24*Log[2]^2))/3, 
 H[4, IF5] -> (eps^2*Pi^2)/16 + G[-I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + G[I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + (11*eps^2*G[-1, -1, t^2])/4 - 
   (15*eps^2*G[-1, 0, t^2])/4 - (23*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 + (7*eps^2*G[0, 0, t^2])/4 - 
   8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + (19*eps^2*G[0, -r^(-1), t])/4 + 
   (3*eps^2*G[0, -r, t])/4 - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (33*eps^2*G[-r^(-1), 0, t])/8 + (11*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 + (5*eps^2*G[r^(-1), 0, t])/8 - 
   (5*eps^2*G[r^(-1), -r^(-1), t])/8 - (5*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (19*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + (5*eps^2*G[r^(-1), t]*Log[2])/8 - 
   (3*eps^2*G[r, t]*Log[2])/8 + (3*eps^2*Log[2]^2)/16 + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r^(-1), t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*(eps/2 + eps^2*G[0, t] + (33*eps^2*G[-r^(-1), t])/8 - 
     (5*eps^2*G[r^(-1), t])/8 + (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - 
     eps^2*Log[2]) + G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - 
     (eps^2*Log[2])/2) + G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[0, t^2]*((-5*eps)/4 + (3*eps^2*Log[2])/4) + 
   (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF5] -> -1/4*(eps^2*Pi^2) + G[-I, r]*(3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(3*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   14*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t^2] - 8*eps^2*G[0, 0, r] + 
   4*eps^2*G[0, 0, t^2] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(4*eps + 2*eps^2*Log[2]) + G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r^(-1), t]*(-2*eps - 3*eps^2*G[-I, r] - 3*eps^2*G[I, r] + 
     4*eps^2*Log[2]) + G[0, r]*(-2*eps - 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 
     8*eps^2*Log[2]) + (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + 
   (eps^2*(Pi^2 - 24*Log[2]^2))/6 + (eps^2*(Pi^2 + 24*Log[2]^2))/6, 
 H[6, IF5] -> -1/2*(eps^2*Pi^2) + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(4*eps + 16*eps^2*G[0, t] + 
     6*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 6*eps^2*G[-r, t] - 
     2*eps^2*G[r, t]) + G[-I, r]*(2*eps + 3*eps^2*G[-r^(-1), t] + 
     3*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(2*eps + 3*eps^2*G[-r^(-1), t] + 3*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) - 20*eps^2*G[-1, -1, t^2] - 
   12*eps^2*G[-1, 0, t^2] - 14*eps^2*G[0, -1, t^2] + 8*eps^2*G[0, 0, r] + 
   24*eps^2*G[0, 0, t] - 14*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 
   4*eps^2*G[0, I, r] + 8*eps^2*G[0, -r^(-1), t] + 8*eps^2*G[0, -r, t] + 
   8*eps^2*G[-I, 0, r] + 8*eps^2*G[I, 0, r] + 2*eps^2*G[1, -1, t^2] - 
   2*eps^2*G[1, 0, t^2] + 4*eps^2*G[-r^(-1), 0, t] + 
   4*eps^2*G[-r^(-1), -r^(-1), t] + 5*eps^2*G[-r^(-1), -r, t] + 
   4*eps^2*G[r^(-1), 0, t] - 4*eps^2*G[r^(-1), -r^(-1), t] - 
   3*eps^2*G[r^(-1), -r, t] + 6*eps^2*G[-r, 0, t] + 
   5*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 2*eps^2*G[r, 0, t] - 
   eps^2*G[r, -r^(-1), t] - 2*eps^2*G[r, -r, t] + 2*eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   2*eps^2*G[r, t]*Log[2] - 12*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-8*eps - 12*eps^2*Log[2]) + 
   G[-r^(-1), t]*(2*eps - 4*eps^2*Log[2]) + 
   G[0, t^2]*(-4*eps - 2*eps^2*Log[2]) + G[-r, t]*(2*eps - 2*eps^2*Log[2]) + 
   (eps^2*(Pi^2 + 66*Log[2]^2))/6 + (eps^2*(Pi^2 + 72*Log[2]^2))/6, 
 H[1, IF6] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF6] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF6] -> (5*eps^2*Pi^2)/24 + G[0, t]*((-5*eps)/2 - 6*eps^2*G[-I, r] - 
     6*eps^2*G[I, r]) + G[-I, r]*((-3*eps)/2 - (3*eps^2*G[-r, t])/2 - 
     (3*eps^2*G[r, t])/2) + G[I, r]*((-3*eps)/2 - (3*eps^2*G[-r, t])/2 - 
     (3*eps^2*G[r, t])/2) + G[0, r]*(-1/2*eps - 4*eps^2*G[0, t] - 
     (eps^2*G[-r, t])/2 + (3*eps^2*G[r, t])/2) + (23*eps^2*G[-1, -1, t^2])/
    2 + (5*eps^2*G[-1, 0, t^2])/2 + (5*eps^2*G[0, -1, t^2])/2 + 
   eps^2*G[0, 0, r] - 11*eps^2*G[0, 0, t] + 5*eps^2*G[0, 0, t^2] - 
   3*eps^2*G[0, -I, r] - 3*eps^2*G[0, I, r] - (3*eps^2*G[0, -r^(-1), t])/2 - 
   (5*eps^2*G[0, -r, t])/2 - 3*eps^2*G[-I, 0, r] - 3*eps^2*G[-I, -I, r] - 
   3*eps^2*G[-I, I, r] - 3*eps^2*G[I, 0, r] - 3*eps^2*G[I, -I, r] - 
   3*eps^2*G[I, I, r] + eps^2*G[1, -1, t^2] - (5*eps^2*G[-r, 0, t])/2 - 
   eps^2*G[-r, -r, t] - (3*eps^2*G[r, 0, t])/2 + (3*eps^2*G[r, -r^(-1), t])/
    2 + (eps^2*G[r, -r, t])/2 - (3*eps*Log[2])/2 - eps^2*G[1, t^2]*Log[2] - 
   (eps^2*G[r, t]*Log[2])/2 + (eps^2*Log[2]^2)/4 + 
   G[-r, t]*(-1/2*eps + (eps^2*Log[2])/2) + 
   G[0, t^2]*(eps + (3*eps^2*Log[2])/2) + 
   G[-1, t^2]*((7*eps)/2 + (5*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 - 48*Log[2]^2))/12, 
 H[4, IF6] -> (eps^2*Pi^2)/16 + G[-I, r]*(-eps - (13*eps^2*G[-r^(-1), t])/8 - 
     (19*eps^2*G[r^(-1), t])/8 + (11*eps^2*G[-r, t])/8 + 
     (5*eps^2*G[r, t])/8) + G[I, r]*(-eps - (13*eps^2*G[-r^(-1), t])/8 - 
     (19*eps^2*G[r^(-1), t])/8 + (11*eps^2*G[-r, t])/8 + 
     (5*eps^2*G[r, t])/8) + (11*eps^2*G[-1, -1, t^2])/4 + 
   (eps^2*G[-1, 0, t^2])/4 - (7*eps^2*G[0, -1, t^2])/4 + 6*eps^2*G[0, 0, r] + 
   (eps^2*G[0, 0, t])/2 - (25*eps^2*G[0, 0, t^2])/4 + 4*eps^2*G[0, -I, r] + 
   4*eps^2*G[0, I, r] + (3*eps^2*G[0, -r^(-1), t])/4 + 
   (19*eps^2*G[0, -r, t])/4 - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (19*eps^2*G[r^(-1), -r, t])/8 + 
   (33*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (11*eps^2*G[-r, -r, t])/4 + (5*eps^2*G[r, 0, t])/8 - 
   (5*eps^2*G[r, -r^(-1), t])/8 - (5*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] - (3*eps^2*G[r^(-1), t]*Log[2])/8 + 
   (5*eps^2*G[r, t]*Log[2])/8 - (eps^2*Log[2]^2)/16 + 
   G[0, t^2]*((-5*eps)/4 - (13*eps^2*Log[2])/4) + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r, t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*((5*eps)/2 + 9*eps^2*G[0, t] + (41*eps^2*G[-r^(-1), t])/8 + 
     (35*eps^2*G[r^(-1), t])/8 + (33*eps^2*G[-r, t])/8 - 
     (5*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - (eps^2*Log[2])/2) + 
   G[-r^(-1), t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   (eps^2*(-2*Pi^2 + Log[2]^2))/4 + (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF6] -> -4*eps^2*G[0, t]*G[I, r] - eps^2*G[0, r]*G[r^(-1), t] + 
   G[I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] + eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   5*eps^2*G[-1, -1, t^2] - 3*eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] + 
   3*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   3*eps^2*G[-r^(-1), 0, t] + 2*eps^2*G[-r^(-1), -r^(-1), t] + 
   2*eps^2*G[-r^(-1), -r, t] + eps^2*G[r^(-1), 0, t] - 
   eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[r, -r^(-1), t] - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r^(-1), t]*Log[2] + 
   G[-1, t^2]*(eps - eps^2*Log[2]) + G[-r^(-1), t]*
    (eps + 3*eps^2*G[0, r] - eps^2*Log[2]) + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF6] -> -1/4*(eps^2*Pi^2) - 4*eps^2*G[0, t]*G[I, r] + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] - 
     5*eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] - 2*eps^2*G[-r^(-1), t] + 
     4*eps^2*G[r^(-1), t] - 5*eps^2*G[-r, t] + eps^2*G[r, t]) + 
   19*eps^2*G[-1, -1, t^2] - eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] - 
   8*eps^2*G[0, 0, r] + 7*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 
   8*eps^2*G[0, I, r] + 4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 
   2*eps^2*G[-I, -I, r] - 2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 
   2*eps^2*G[I, -I, r] - 2*eps^2*G[I, I, r] + 4*eps^2*G[1, -1, t^2] - 
   4*eps^2*G[1, 0, t^2] - eps^2*G[-r^(-1), 0, t] - 
   2*eps^2*G[-r^(-1), -r^(-1), t] - 3*eps^2*G[-r^(-1), -r, t] + 
   5*eps^2*G[r^(-1), 0, t] - 5*eps^2*G[r^(-1), -r^(-1), t] - 
   4*eps^2*G[r^(-1), -r, t] - 4*eps^2*G[-r, 0, t] - 
   3*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 4*eps^2*G[r, 0, t] - 
   eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - eps*Log[2] - 
   4*eps^2*G[1, t^2]*Log[2] + 5*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 8*eps^2*Log[2]^2 + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + G[-1, t^2]*(5*eps + eps^2*Log[2]) + 
   G[-r^(-1), t]*(-eps + 3*eps^2*Log[2]) + 
   G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[0, r]*(-2*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t] - 
     4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 8*eps^2*Log[2]) + 
   (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + (eps^2*(Pi^2 - 24*Log[2]^2))/6 + 
   (eps^2*(Pi^2 + 15*Log[2]^2))/2, 
 H[7, IF6] -> (eps^2*Pi^2)/2 - 4*eps^2*G[0, t]*G[I, r] + 
   G[I, r]*(-eps + 4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] - 
     5*eps^2*G[-r, t] - 5*eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] + 4*eps^2*G[-r^(-1), t] + 
     4*eps^2*G[r^(-1), t] - 5*eps^2*G[-r, t] - 5*eps^2*G[r, t]) + 
   G[0, r]*(2*eps - 2*eps^2*G[-1, t] - 2*eps^2*G[1, t] + 
     9*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t] + 4*eps^2*G[-r, t] + 
     4*eps^2*G[r, t]) + eps^2*G[-1, -1, t^2] - 2*eps^2*G[-1, 0, t] - 
   7*eps^2*G[-1, 0, t^2] + 2*eps^2*G[-1, -r^(-1), t] - 2*eps^2*G[-1, -r, t] - 
   9*eps^2*G[0, -1, t^2] + 8*eps^2*G[0, 0, r] - eps^2*G[0, 0, t^2] - 
   8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 4*eps^2*G[0, -r^(-1), t] - 
   2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 2*eps^2*G[-I, I, r] - 
   2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 2*eps^2*G[I, I, r] + 
   6*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t] + 2*eps^2*G[1, -r^(-1), t] - 
   2*eps^2*G[1, -r, t] + 7*eps^2*G[-r^(-1), 0, t] + 
   6*eps^2*G[-r^(-1), -r^(-1), t] + 7*eps^2*G[-r^(-1), -r, t] + 
   5*eps^2*G[r^(-1), 0, t] - 5*eps^2*G[r^(-1), -r^(-1), t] - 
   4*eps^2*G[r^(-1), -r, t] - 4*eps^2*G[-r, 0, t] + 
   5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[r, 0, t] + 
   5*eps^2*G[r, -r^(-1), t] - eps*Log[2] - 6*eps^2*G[1, t^2]*Log[2] + 
   5*eps^2*G[r^(-1), t]*Log[2] + 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-eps - 5*eps^2*Log[2]) + G[-r^(-1), t]*
    (3*eps - 5*eps^2*Log[2]) + G[0, t^2]*(-eps + 5*eps^2*Log[2]) + 
   (eps^2*(-Pi^2 - 24*Log[2]^2))/6 + (eps^2*(-Pi^2 + 21*Log[2]^2))/6, 
 H[1, IF7] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF7] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF7] -> (5*eps^2*Pi^2)/24 + G[0, t]*((-5*eps)/2 - 6*eps^2*G[-I, r] - 
     6*eps^2*G[I, r]) + G[-I, r]*((-3*eps)/2 - (3*eps^2*G[-r^(-1), t])/2 - 
     (3*eps^2*G[r^(-1), t])/2) + 
   G[I, r]*((-3*eps)/2 - (3*eps^2*G[-r^(-1), t])/2 - 
     (3*eps^2*G[r^(-1), t])/2) + G[0, r]*(-1/2*eps - 4*eps^2*G[0, t] - 
     (eps^2*G[-r^(-1), t])/2 + (3*eps^2*G[r^(-1), t])/2) + 
   (23*eps^2*G[-1, -1, t^2])/2 + (9*eps^2*G[-1, 0, t^2])/2 + 
   (9*eps^2*G[0, -1, t^2])/2 + eps^2*G[0, 0, r] - 11*eps^2*G[0, 0, t] + 
   5*eps^2*G[0, 0, t^2] - 3*eps^2*G[0, -I, r] - 3*eps^2*G[0, I, r] - 
   (5*eps^2*G[0, -r^(-1), t])/2 - (3*eps^2*G[0, -r, t])/2 - 
   3*eps^2*G[-I, 0, r] - 3*eps^2*G[-I, -I, r] - 3*eps^2*G[-I, I, r] - 
   3*eps^2*G[I, 0, r] - 3*eps^2*G[I, -I, r] - 3*eps^2*G[I, I, r] + 
   eps^2*G[1, -1, t^2] - (5*eps^2*G[-r^(-1), 0, t])/2 - 
   eps^2*G[-r^(-1), -r^(-1), t] - (3*eps^2*G[r^(-1), 0, t])/2 + 
   (eps^2*G[r^(-1), -r^(-1), t])/2 + (3*eps^2*G[r^(-1), -r, t])/2 - 
   (3*eps*Log[2])/2 - eps^2*G[1, t^2]*Log[2] - (eps^2*G[r^(-1), t]*Log[2])/
    2 + (eps^2*Log[2]^2)/4 + G[0, t^2]*(eps - (eps^2*Log[2])/2) + 
   G[-r^(-1), t]*(-1/2*eps + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((7*eps)/2 + (5*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 - 48*Log[2]^2))/12, 
 H[4, IF7] -> (eps^2*Pi^2)/16 + G[-I, r]*(-eps - (13*eps^2*G[-r^(-1), t])/8 - 
     (19*eps^2*G[r^(-1), t])/8 + (11*eps^2*G[-r, t])/8 + 
     (5*eps^2*G[r, t])/8) + G[I, r]*(-eps - (13*eps^2*G[-r^(-1), t])/8 - 
     (19*eps^2*G[r^(-1), t])/8 + (11*eps^2*G[-r, t])/8 + 
     (5*eps^2*G[r, t])/8) + (11*eps^2*G[-1, -1, t^2])/4 + 
   (eps^2*G[-1, 0, t^2])/4 - (7*eps^2*G[0, -1, t^2])/4 + 6*eps^2*G[0, 0, r] + 
   (eps^2*G[0, 0, t])/2 - (25*eps^2*G[0, 0, t^2])/4 + 4*eps^2*G[0, -I, r] + 
   4*eps^2*G[0, I, r] + (3*eps^2*G[0, -r^(-1), t])/4 + 
   (19*eps^2*G[0, -r, t])/4 - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (19*eps^2*G[r^(-1), -r, t])/8 + 
   (33*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (11*eps^2*G[-r, -r, t])/4 + (5*eps^2*G[r, 0, t])/8 - 
   (5*eps^2*G[r, -r^(-1), t])/8 - (5*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] - (3*eps^2*G[r^(-1), t]*Log[2])/8 + 
   (5*eps^2*G[r, t]*Log[2])/8 - (eps^2*Log[2]^2)/16 + 
   G[0, t^2]*((-5*eps)/4 - (13*eps^2*Log[2])/4) + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r, t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*((5*eps)/2 + 9*eps^2*G[0, t] + (41*eps^2*G[-r^(-1), t])/8 + 
     (35*eps^2*G[r^(-1), t])/8 + (33*eps^2*G[-r, t])/8 - 
     (5*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - (eps^2*Log[2])/2) + 
   G[-r^(-1), t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   (eps^2*(-2*Pi^2 + Log[2]^2))/4 + (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF7] -> -4*eps^2*G[0, t]*G[I, r] - eps^2*G[0, r]*G[r^(-1), t] + 
   G[I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] + eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   5*eps^2*G[-1, -1, t^2] - 3*eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] + 
   3*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   3*eps^2*G[-r^(-1), 0, t] + 2*eps^2*G[-r^(-1), -r^(-1), t] + 
   2*eps^2*G[-r^(-1), -r, t] + eps^2*G[r^(-1), 0, t] - 
   eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[r, -r^(-1), t] - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r^(-1), t]*Log[2] + 
   G[-1, t^2]*(eps - eps^2*Log[2]) + G[-r^(-1), t]*
    (eps + 3*eps^2*G[0, r] - eps^2*Log[2]) + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF7] -> -1/4*(eps^2*Pi^2) - 4*eps^2*G[0, t]*G[I, r] + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] - 
     5*eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] - 2*eps^2*G[-r^(-1), t] + 
     4*eps^2*G[r^(-1), t] - 5*eps^2*G[-r, t] + eps^2*G[r, t]) + 
   19*eps^2*G[-1, -1, t^2] - eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] - 
   8*eps^2*G[0, 0, r] + 7*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 
   8*eps^2*G[0, I, r] + 4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 
   2*eps^2*G[-I, -I, r] - 2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 
   2*eps^2*G[I, -I, r] - 2*eps^2*G[I, I, r] + 4*eps^2*G[1, -1, t^2] - 
   4*eps^2*G[1, 0, t^2] - eps^2*G[-r^(-1), 0, t] - 
   2*eps^2*G[-r^(-1), -r^(-1), t] - 3*eps^2*G[-r^(-1), -r, t] + 
   5*eps^2*G[r^(-1), 0, t] - 5*eps^2*G[r^(-1), -r^(-1), t] - 
   4*eps^2*G[r^(-1), -r, t] - 4*eps^2*G[-r, 0, t] - 
   3*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 4*eps^2*G[r, 0, t] - 
   eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - eps*Log[2] - 
   4*eps^2*G[1, t^2]*Log[2] + 5*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 8*eps^2*Log[2]^2 + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + G[-1, t^2]*(5*eps + eps^2*Log[2]) + 
   G[-r^(-1), t]*(-eps + 3*eps^2*Log[2]) + 
   G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[0, r]*(-2*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t] - 
     4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 8*eps^2*Log[2]) + 
   (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + (eps^2*(Pi^2 - 24*Log[2]^2))/6 + 
   (eps^2*(Pi^2 + 15*Log[2]^2))/2, 
 H[7, IF7] -> (eps^2*Pi^2)/2 + (-3*eps^2*G[-I, r] - 3*eps^2*G[I, r])*
    G[-r^(-1), t] + G[0, r]*(2*eps + 2*eps^2*G[-1, t] + 2*eps^2*G[1, t] + 
     2*eps^2*G[-r^(-1), t] + 2*eps^2*G[r^(-1), t] + 4*eps^2*G[-r, t] - 
     4*eps^2*G[r, t]) + G[-I, r]*(-3*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] + 
     3*eps^2*G[r, t]) + G[I, r]*(-3*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] + 
     3*eps^2*G[r, t]) - 4*eps^2*G[-1, -1, t^2] - 2*eps^2*G[-1, 0, t] + 
   4*eps^2*G[-1, 0, t^2] - 2*eps^2*G[-1, -r^(-1), t] + 2*eps^2*G[-1, -r, t] + 
   4*eps^2*G[0, -1, t^2] + 8*eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t^2] + 
   4*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t] + 2*eps^2*G[1, 0, t^2] - 
   2*eps^2*G[1, -r^(-1), t] + 2*eps^2*G[1, -r, t] - 
   4*eps^2*G[-r^(-1), 0, t] + 3*eps^2*G[-r^(-1), -r, t] - 
   4*eps^2*G[r^(-1), 0, t] + 3*eps^2*G[r^(-1), -r, t] + 4*eps^2*G[-r, 0, t] + 
   5*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 4*eps^2*G[r, 0, t] - 
   3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   4*eps^2*G[0, t^2]*Log[2] - 4*eps^2*G[1, t^2]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] + 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-2*eps - 4*eps^2*Log[2]) + G[-r, t]*(2*eps - 4*eps^2*Log[2]) + 
   (eps^2*(-Pi^2 - 24*Log[2]^2))/6 + (eps^2*(-Pi^2 + 8*Log[2]^2))/2, 
 H[1, IF8] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF8] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF8] -> -1/2*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(2*eps + 8*eps^2*G[0, t] + 
     4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - 
     eps^2*G[r, t]) + G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] + 4*eps^2*G[0, 0, r] - 
   5*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   2*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), -r, t] + 
   3*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + 
   eps^2*G[r, 0, t] - eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - 
   eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[4, IF8] -> -4*eps^2*G[0, t]*G[I, r] - eps^2*G[0, r]*G[r^(-1), t] + 
   G[I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] + eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   5*eps^2*G[-1, -1, t^2] - 3*eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] + 
   3*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   3*eps^2*G[-r^(-1), 0, t] + 2*eps^2*G[-r^(-1), -r^(-1), t] + 
   2*eps^2*G[-r^(-1), -r, t] + eps^2*G[r^(-1), 0, t] - 
   eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[r, -r^(-1), t] - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r^(-1), t]*Log[2] + 
   G[-1, t^2]*(eps - eps^2*Log[2]) + G[-r^(-1), t]*
    (eps + 3*eps^2*G[0, r] - eps^2*Log[2]) + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[5, IF8] -> -1/4*(eps^2*Pi^2) + G[-I, r]*(3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(3*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   14*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t^2] - 8*eps^2*G[0, 0, r] + 
   4*eps^2*G[0, 0, t^2] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] + 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(4*eps + 2*eps^2*Log[2]) + G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r^(-1), t]*(-2*eps - 3*eps^2*G[-I, r] - 3*eps^2*G[I, r] + 
     4*eps^2*Log[2]) + G[0, r]*(-2*eps - 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 
     8*eps^2*Log[2]) + (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + 
   (eps^2*(Pi^2 - 24*Log[2]^2))/3, 
 H[6, IF8] -> (5*eps^2*Pi^2)/6 + 4*eps*G[0, t^2] + 
   G[0, t]*(-10*eps - 24*eps^2*G[-I, r] - 24*eps^2*G[I, r]) + 
   G[-I, r]*(-6*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] - 3*eps^2*G[r, t]) + 
   G[I, r]*(-6*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] - 3*eps^2*G[r, t]) + 
   G[0, r]*(-4*eps - 16*eps^2*G[0, t] - 6*eps^2*G[-r^(-1), t] + 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] + 4*eps^2*G[r, t]) + 
   50*eps^2*G[-1, -1, t^2] + 14*eps^2*G[-1, 0, t^2] + 
   16*eps^2*G[0, -1, t^2] - 40*eps^2*G[0, 0, t] + 20*eps^2*G[0, 0, t^2] - 
   12*eps^2*G[0, -I, r] - 12*eps^2*G[0, I, r] - 8*eps^2*G[0, -r^(-1), t] - 
   8*eps^2*G[0, -r, t] - 12*eps^2*G[-I, 0, r] - 12*eps^2*G[-I, -I, r] - 
   12*eps^2*G[-I, I, r] - 12*eps^2*G[I, 0, r] - 12*eps^2*G[I, -I, r] - 
   12*eps^2*G[I, I, r] - 2*eps^2*G[1, -1, t^2] + 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] - 4*eps^2*G[r^(-1), 0, t] + 
   4*eps^2*G[r^(-1), -r^(-1), t] + 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] - 
   4*eps^2*G[r, 0, t] + 3*eps^2*G[r, -r^(-1), t] + 4*eps^2*G[r, -r, t] - 
   6*eps*Log[2] + 2*eps^2*G[1, t^2]*Log[2] - 4*eps^2*G[r^(-1), t]*Log[2] - 
   4*eps^2*G[r, t]*Log[2] + 20*eps^2*Log[2]^2 + 
   G[-r^(-1), t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-1, t^2]*(16*eps + 14*eps^2*Log[2]) + (eps^2*(-Pi^2 - 120*Log[2]^2))/3, 
 H[1, IF9] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF9] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF9] -> (eps^2*Pi^2)/6 + G[0, t]*(-4*eps - 12*eps^2*G[-I, r] - 
     12*eps^2*G[I, r]) + 5*eps^2*G[0, r]*G[r^(-1), t] + 
   G[-I, r]*(-3*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t]) + 
   G[I, r]*(-3*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t]) + 
   23*eps^2*G[-1, -1, t^2] + 7*eps^2*G[-1, 0, t^2] + 5*eps^2*G[0, -1, t^2] - 
   16*eps^2*G[0, 0, t] + 5*eps^2*G[0, 0, t^2] - 4*eps^2*G[0, -r^(-1), t] - 
   6*eps^2*G[-I, 0, r] - 6*eps^2*G[-I, -I, r] - 6*eps^2*G[-I, I, r] - 
   6*eps^2*G[I, 0, r] - 6*eps^2*G[I, -I, r] - 6*eps^2*G[I, I, r] + 
   2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 3*eps^2*G[-r^(-1), 0, t] - 
   2*eps^2*G[-r^(-1), -r^(-1), t] - eps^2*G[r^(-1), 0, t] + 
   eps^2*G[r^(-1), -r^(-1), t] + 3*eps^2*G[r^(-1), -r, t] - 3*eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] - eps^2*G[r^(-1), t]*Log[2] - 
   (47*eps^2*Log[2]^2)/2 + G[0, t^2]*(eps - eps^2*Log[2]) + 
   G[-r^(-1), t]*(-eps + eps^2*G[0, r] + eps^2*Log[2]) + 
   G[-1, t^2]*(7*eps + 5*eps^2*Log[2]) + (eps^2*(-Pi^2 + 16*Log[2]^2))/2 + 
   (eps^2*(Pi^2 + 24*Log[2]^2))/3, 
 H[4, IF9] -> (eps^2*Pi^2)/16 + G[-I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + G[I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + 
     (5*eps^2*G[r^(-1), t])/8 - (13*eps^2*G[-r, t])/8 - 
     (19*eps^2*G[r, t])/8) + (11*eps^2*G[-1, -1, t^2])/4 - 
   (15*eps^2*G[-1, 0, t^2])/4 - (23*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 + (7*eps^2*G[0, 0, t^2])/4 - 
   8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + (19*eps^2*G[0, -r^(-1), t])/4 + 
   (3*eps^2*G[0, -r, t])/4 - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (33*eps^2*G[-r^(-1), 0, t])/8 + (11*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 + (5*eps^2*G[r^(-1), 0, t])/8 - 
   (5*eps^2*G[r^(-1), -r^(-1), t])/8 - (5*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (19*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + (5*eps^2*G[r^(-1), t]*Log[2])/8 - 
   (3*eps^2*G[r, t]*Log[2])/8 + (3*eps^2*Log[2]^2)/16 + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r^(-1), t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*(eps/2 + eps^2*G[0, t] + (33*eps^2*G[-r^(-1), t])/8 - 
     (5*eps^2*G[r^(-1), t])/8 + (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - 
     eps^2*Log[2]) + G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - 
     (eps^2*Log[2])/2) + G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[0, t^2]*((-5*eps)/4 + (3*eps^2*Log[2])/4) + 
   (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF9] -> -1/4*(eps^2*Pi^2) + G[-I, r]*(3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(3*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   14*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t^2] - 8*eps^2*G[0, 0, r] + 
   4*eps^2*G[0, 0, t^2] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(4*eps + 2*eps^2*Log[2]) + G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r^(-1), t]*(-2*eps - 3*eps^2*G[-I, r] - 3*eps^2*G[I, r] + 
     4*eps^2*Log[2]) + G[0, r]*(-2*eps - 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 
     8*eps^2*Log[2]) + (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + 
   (eps^2*(Pi^2 - 24*Log[2]^2))/6 + (eps^2*(Pi^2 + 24*Log[2]^2))/6, 
 H[6, IF9] -> (-5*eps^2*Pi^2)/6 + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(4*eps + 16*eps^2*G[0, t] + 
     8*eps^2*G[-r^(-1), t] + 4*eps^2*G[-r, t] - 4*eps^2*G[r, t]) + 
   G[-I, r]*(2*eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] + 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(2*eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] + 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) - 20*eps^2*G[-1, -1, t^2] - 
   12*eps^2*G[-1, 0, t^2] - 14*eps^2*G[0, -1, t^2] + 24*eps^2*G[0, 0, t] - 
   14*eps^2*G[0, 0, t^2] + 12*eps^2*G[0, -I, r] + 12*eps^2*G[0, I, r] + 
   8*eps^2*G[0, -r^(-1), t] + 8*eps^2*G[0, -r, t] + 8*eps^2*G[-I, 0, r] + 
   8*eps^2*G[I, 0, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   6*eps^2*G[-r^(-1), 0, t] + 4*eps^2*G[-r^(-1), -r^(-1), t] + 
   5*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), 0, t] - 
   2*eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   4*eps^2*G[-r, 0, t] + 5*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] + 
   2*eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + 2*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] - 12*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-8*eps - 12*eps^2*Log[2]) + 
   G[-r, t]*(2*eps - 4*eps^2*Log[2]) + G[0, t^2]*(-4*eps - 2*eps^2*Log[2]) + 
   G[-r^(-1), t]*(2*eps - 2*eps^2*Log[2]) + (eps^2*(Pi^2 + 66*Log[2]^2))/6 + 
   (eps^2*(Pi^2 + 72*Log[2]^2))/6, H[1, IF10] -> 
  (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF10] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF10] -> (5*eps^2*Pi^2)/24 + G[0, t]*((-5*eps)/2 - 6*eps^2*G[-I, r] - 
     6*eps^2*G[I, r]) + G[-I, r]*((-3*eps)/2 - (3*eps^2*G[-r, t])/2 - 
     (3*eps^2*G[r, t])/2) + G[I, r]*((-3*eps)/2 - (3*eps^2*G[-r, t])/2 - 
     (3*eps^2*G[r, t])/2) + G[0, r]*(-1/2*eps - 4*eps^2*G[0, t] - 
     (eps^2*G[-r, t])/2 + (3*eps^2*G[r, t])/2) + (23*eps^2*G[-1, -1, t^2])/
    2 + (5*eps^2*G[-1, 0, t^2])/2 + (5*eps^2*G[0, -1, t^2])/2 + 
   eps^2*G[0, 0, r] - 11*eps^2*G[0, 0, t] + 5*eps^2*G[0, 0, t^2] - 
   3*eps^2*G[0, -I, r] - 3*eps^2*G[0, I, r] - (3*eps^2*G[0, -r^(-1), t])/2 - 
   (5*eps^2*G[0, -r, t])/2 - 3*eps^2*G[-I, 0, r] - 3*eps^2*G[-I, -I, r] - 
   3*eps^2*G[-I, I, r] - 3*eps^2*G[I, 0, r] - 3*eps^2*G[I, -I, r] - 
   3*eps^2*G[I, I, r] + eps^2*G[1, -1, t^2] - (5*eps^2*G[-r, 0, t])/2 - 
   eps^2*G[-r, -r, t] - (3*eps^2*G[r, 0, t])/2 + (3*eps^2*G[r, -r^(-1), t])/
    2 + (eps^2*G[r, -r, t])/2 - (3*eps*Log[2])/2 - eps^2*G[1, t^2]*Log[2] - 
   (eps^2*G[r, t]*Log[2])/2 + (eps^2*Log[2]^2)/4 + 
   G[-r, t]*(-1/2*eps + (eps^2*Log[2])/2) + 
   G[0, t^2]*(eps + (3*eps^2*Log[2])/2) + 
   G[-1, t^2]*((7*eps)/2 + (5*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 - 48*Log[2]^2))/12, 
 H[4, IF10] -> (eps^2*Pi^2)/16 + 
   G[-I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + (5*eps^2*G[r^(-1), t])/8 - 
     (13*eps^2*G[-r, t])/8 - (19*eps^2*G[r, t])/8) + 
   G[I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + (5*eps^2*G[r^(-1), t])/8 - 
     (13*eps^2*G[-r, t])/8 - (19*eps^2*G[r, t])/8) + 
   (11*eps^2*G[-1, -1, t^2])/4 - (15*eps^2*G[-1, 0, t^2])/4 - 
   (23*eps^2*G[0, -1, t^2])/4 + 2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 + 
   (7*eps^2*G[0, 0, t^2])/4 - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   (19*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 - 
   2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 2*eps^2*G[-I, I, r] - 
   2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 2*eps^2*G[I, I, r] + 
   2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (33*eps^2*G[-r^(-1), 0, t])/8 + (11*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 + (5*eps^2*G[r^(-1), 0, t])/8 - 
   (5*eps^2*G[r^(-1), -r^(-1), t])/8 - (5*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (19*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + (5*eps^2*G[r^(-1), t]*Log[2])/8 - 
   (3*eps^2*G[r, t]*Log[2])/8 + (3*eps^2*Log[2]^2)/16 + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r^(-1), t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*(eps/2 + eps^2*G[0, t] + (33*eps^2*G[-r^(-1), t])/8 - 
     (5*eps^2*G[r^(-1), t])/8 + (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - 
     eps^2*Log[2]) + G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - 
     (eps^2*Log[2])/2) + G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[0, t^2]*((-5*eps)/4 + (3*eps^2*Log[2])/4) + 
   (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF10] -> -1/2*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(2*eps + 8*eps^2*G[0, t] + 
     4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - 
     eps^2*G[r, t]) + G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] + 4*eps^2*G[0, 0, r] - 
   5*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   2*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), -r, t] + 
   3*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + 
   eps^2*G[r, 0, t] - eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - 
   eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF10] -> -1/4*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[-I, r]*(-eps - 5*eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] + 4*eps^2*G[r, t]) + 
   G[I, r]*(-eps - 5*eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] + 4*eps^2*G[r, t]) + 19*eps^2*G[-1, -1, t^2] + 
   3*eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] - 4*eps^2*G[0, 0, r] - 
   eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 4*eps^2*G[1, -1, t^2] - 4*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   3*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] - 
   eps^2*G[-r, 0, t] - 3*eps^2*G[-r, -r^(-1), t] - 2*eps^2*G[-r, -r, t] + 
   5*eps^2*G[r, 0, t] - 4*eps^2*G[r, -r^(-1), t] - 5*eps^2*G[r, -r, t] - 
   eps*Log[2] - 4*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   5*eps^2*G[r, t]*Log[2] - 8*eps^2*Log[2]^2 + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(5*eps + eps^2*Log[2]) + 
   G[-r, t]*(-eps + 3*eps^2*Log[2]) + G[-r^(-1), t]*
    (-2*eps + 4*eps^2*Log[2]) + G[0, r]*(8*eps^2*G[0, t] - 
     2*eps^2*G[-r^(-1), t] + 2*eps^2*G[r^(-1), t] - eps^2*G[-r, t] - 
     5*eps^2*G[r, t] + 8*eps^2*Log[2]) + (eps^2*(-13*Pi^2 - 48*Log[2]^2))/
    12 + (eps^2*(Pi^2 - 24*Log[2]^2))/6 + (eps^2*(Pi^2 + 15*Log[2]^2))/2, 
 H[7, IF10] -> G[0, t]*(-4*eps^2*G[-I, r] - 4*eps^2*G[I, r]) + 
   G[-I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[0, r]*(4*eps - 2*eps^2*G[-1, t] + 8*eps^2*G[0, t] - 2*eps^2*G[1, t] + 
     10*eps^2*G[-r^(-1), t] + 2*eps^2*G[r^(-1), t] + 7*eps^2*G[-r, t] + 
     3*eps^2*G[r, t]) + eps^2*G[-1, -1, t^2] - 2*eps^2*G[-1, 0, t] - 
   3*eps^2*G[-1, 0, t^2] + 2*eps^2*G[-1, -r^(-1), t] - 2*eps^2*G[-1, -r, t] - 
   5*eps^2*G[0, -1, t^2] + 12*eps^2*G[0, 0, r] - 9*eps^2*G[0, 0, t^2] + 
   4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 4*eps^2*G[0, -r, t] - 
   2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 2*eps^2*G[-I, I, r] - 
   2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 2*eps^2*G[I, I, r] + 
   6*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t] + 2*eps^2*G[1, -r^(-1), t] - 
   2*eps^2*G[1, -r, t] + 4*eps^2*G[-r^(-1), 0, t] + 
   4*eps^2*G[-r^(-1), -r^(-1), t] + 7*eps^2*G[-r^(-1), -r, t] + 
   4*eps^2*G[r^(-1), 0, t] - 4*eps^2*G[r^(-1), -r^(-1), t] - 
   eps^2*G[r^(-1), -r, t] - eps^2*G[-r, 0, t] + 5*eps^2*G[-r, -r^(-1), t] + 
   2*eps^2*G[-r, -r, t] - 3*eps^2*G[r, 0, t] + 2*eps^2*G[r, -r^(-1), t] - 
   eps^2*G[r, -r, t] - eps*Log[2] - 6*eps^2*G[1, t^2]*Log[2] + 
   4*eps^2*G[r^(-1), t]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[-1, t^2]*(-eps - 5*eps^2*Log[2]) + G[-r^(-1), t]*
    (2*eps - 4*eps^2*Log[2]) + G[-r, t]*(eps - eps^2*Log[2]) + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + (eps^2*(Pi^2 - 3*Log[2]^2))/6 + 
   (eps^2*(-Pi^2 + 8*Log[2]^2))/2, H[1, IF11] -> 
  (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF11] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF11] -> (5*eps^2*Pi^2)/24 + G[0, t]*((-5*eps)/2 - 6*eps^2*G[-I, r] - 
     6*eps^2*G[I, r]) + G[-I, r]*((-3*eps)/2 - (3*eps^2*G[-r^(-1), t])/2 - 
     (3*eps^2*G[r^(-1), t])/2) + 
   G[I, r]*((-3*eps)/2 - (3*eps^2*G[-r^(-1), t])/2 - 
     (3*eps^2*G[r^(-1), t])/2) + G[0, r]*(-1/2*eps - 4*eps^2*G[0, t] - 
     (eps^2*G[-r^(-1), t])/2 + (3*eps^2*G[r^(-1), t])/2) + 
   (23*eps^2*G[-1, -1, t^2])/2 + (9*eps^2*G[-1, 0, t^2])/2 + 
   (9*eps^2*G[0, -1, t^2])/2 + eps^2*G[0, 0, r] - 11*eps^2*G[0, 0, t] + 
   5*eps^2*G[0, 0, t^2] - 3*eps^2*G[0, -I, r] - 3*eps^2*G[0, I, r] - 
   (5*eps^2*G[0, -r^(-1), t])/2 - (3*eps^2*G[0, -r, t])/2 - 
   3*eps^2*G[-I, 0, r] - 3*eps^2*G[-I, -I, r] - 3*eps^2*G[-I, I, r] - 
   3*eps^2*G[I, 0, r] - 3*eps^2*G[I, -I, r] - 3*eps^2*G[I, I, r] + 
   eps^2*G[1, -1, t^2] - (5*eps^2*G[-r^(-1), 0, t])/2 - 
   eps^2*G[-r^(-1), -r^(-1), t] - (3*eps^2*G[r^(-1), 0, t])/2 + 
   (eps^2*G[r^(-1), -r^(-1), t])/2 + (3*eps^2*G[r^(-1), -r, t])/2 - 
   (3*eps*Log[2])/2 - eps^2*G[1, t^2]*Log[2] - (eps^2*G[r^(-1), t]*Log[2])/
    2 + (eps^2*Log[2]^2)/4 + G[0, t^2]*(eps - (eps^2*Log[2])/2) + 
   G[-r^(-1), t]*(-1/2*eps + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((7*eps)/2 + (5*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 - 48*Log[2]^2))/12, 
 H[4, IF11] -> (eps^2*Pi^2)/16 + 
   G[-I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + (5*eps^2*G[r^(-1), t])/8 - 
     (13*eps^2*G[-r, t])/8 - (19*eps^2*G[r, t])/8) + 
   G[I, r]*(-eps + (11*eps^2*G[-r^(-1), t])/8 + (5*eps^2*G[r^(-1), t])/8 - 
     (13*eps^2*G[-r, t])/8 - (19*eps^2*G[r, t])/8) + 
   (11*eps^2*G[-1, -1, t^2])/4 - (15*eps^2*G[-1, 0, t^2])/4 - 
   (23*eps^2*G[0, -1, t^2])/4 + 2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 + 
   (7*eps^2*G[0, 0, t^2])/4 - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   (19*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 - 
   2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 2*eps^2*G[-I, I, r] - 
   2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 2*eps^2*G[I, I, r] + 
   2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   (33*eps^2*G[-r^(-1), 0, t])/8 + (11*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (11*eps^2*G[-r^(-1), -r, t])/4 + (5*eps^2*G[r^(-1), 0, t])/8 - 
   (5*eps^2*G[r^(-1), -r^(-1), t])/8 - (5*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (11*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (19*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + (5*eps^2*G[r^(-1), t]*Log[2])/8 - 
   (3*eps^2*G[r, t]*Log[2])/8 + (3*eps^2*Log[2]^2)/16 + 
   G[-1, t^2]*(eps/4 - (7*eps^2*Log[2])/4) + 
   G[-r^(-1), t]*((11*eps)/8 - (11*eps^2*Log[2])/8) + 
   G[0, r]*(eps/2 + eps^2*G[0, t] + (33*eps^2*G[-r^(-1), t])/8 - 
     (5*eps^2*G[r^(-1), t])/8 + (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - 
     eps^2*Log[2]) + G[0, t]*(eps/4 - 4*eps^2*G[-I, r] - 4*eps^2*G[I, r] - 
     (eps^2*Log[2])/2) + G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[0, t^2]*((-5*eps)/4 + (3*eps^2*Log[2])/4) + 
   (eps^2*(16*Pi^2 + 21*Log[2]^2))/48, 
 H[5, IF11] -> -1/2*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(2*eps + 8*eps^2*G[0, t] + 
     4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - 
     eps^2*G[r, t]) + G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] + 4*eps^2*G[0, 0, r] - 
   5*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   2*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), -r, t] + 
   3*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + 
   eps^2*G[r, 0, t] - eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - 
   eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF11] -> -1/4*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[-I, r]*(-eps - 5*eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] + 4*eps^2*G[r, t]) + 
   G[I, r]*(-eps - 5*eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] + 4*eps^2*G[r, t]) + 19*eps^2*G[-1, -1, t^2] + 
   3*eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] - 4*eps^2*G[0, 0, r] - 
   eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 4*eps^2*G[1, -1, t^2] - 4*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   3*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] - 
   eps^2*G[-r, 0, t] - 3*eps^2*G[-r, -r^(-1), t] - 2*eps^2*G[-r, -r, t] + 
   5*eps^2*G[r, 0, t] - 4*eps^2*G[r, -r^(-1), t] - 5*eps^2*G[r, -r, t] - 
   eps*Log[2] - 4*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   5*eps^2*G[r, t]*Log[2] - 8*eps^2*Log[2]^2 + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(5*eps + eps^2*Log[2]) + 
   G[-r, t]*(-eps + 3*eps^2*Log[2]) + G[-r^(-1), t]*
    (-2*eps + 4*eps^2*Log[2]) + G[0, r]*(8*eps^2*G[0, t] - 
     2*eps^2*G[-r^(-1), t] + 2*eps^2*G[r^(-1), t] - eps^2*G[-r, t] - 
     5*eps^2*G[r, t] + 8*eps^2*Log[2]) + (eps^2*(-13*Pi^2 - 48*Log[2]^2))/
    12 + (eps^2*(Pi^2 - 24*Log[2]^2))/6 + (eps^2*(Pi^2 + 15*Log[2]^2))/2, 
 H[7, IF11] -> (eps^2*Pi^2)/2 + (-3*eps^2*G[-I, r] - 3*eps^2*G[I, r])*
    G[-r^(-1), t] + G[0, r]*(2*eps + 2*eps^2*G[-1, t] + 2*eps^2*G[1, t] + 
     2*eps^2*G[-r^(-1), t] + 2*eps^2*G[r^(-1), t] + 4*eps^2*G[-r, t] - 
     4*eps^2*G[r, t]) + G[-I, r]*(-3*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] + 
     3*eps^2*G[r, t]) + G[I, r]*(-3*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] + 
     3*eps^2*G[r, t]) - 4*eps^2*G[-1, -1, t^2] - 2*eps^2*G[-1, 0, t] + 
   4*eps^2*G[-1, 0, t^2] - 2*eps^2*G[-1, -r^(-1), t] + 2*eps^2*G[-1, -r, t] + 
   4*eps^2*G[0, -1, t^2] + 8*eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t^2] + 
   4*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t] + 2*eps^2*G[1, 0, t^2] - 
   2*eps^2*G[1, -r^(-1), t] + 2*eps^2*G[1, -r, t] - 
   4*eps^2*G[-r^(-1), 0, t] + 3*eps^2*G[-r^(-1), -r, t] - 
   4*eps^2*G[r^(-1), 0, t] + 3*eps^2*G[r^(-1), -r, t] + 4*eps^2*G[-r, 0, t] + 
   5*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 4*eps^2*G[r, 0, t] - 
   3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   4*eps^2*G[0, t^2]*Log[2] - 4*eps^2*G[1, t^2]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] + 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-2*eps - 4*eps^2*Log[2]) + G[-r, t]*(2*eps - 4*eps^2*Log[2]) + 
   (eps^2*(-Pi^2 - 24*Log[2]^2))/6 + (eps^2*(-Pi^2 + 8*Log[2]^2))/2, 
 H[1, IF12] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF12] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF12] -> -4*eps^2*G[0, t]*G[I, r] - eps^2*G[0, r]*G[r^(-1), t] + 
   G[I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] + eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   5*eps^2*G[-1, -1, t^2] - 3*eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] + 
   3*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   3*eps^2*G[-r^(-1), 0, t] + 2*eps^2*G[-r^(-1), -r^(-1), t] + 
   2*eps^2*G[-r^(-1), -r, t] + eps^2*G[r^(-1), 0, t] - 
   eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[r, -r^(-1), t] - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r^(-1), t]*Log[2] + 
   G[-1, t^2]*(eps - eps^2*Log[2]) + G[-r^(-1), t]*
    (eps + 3*eps^2*G[0, r] - eps^2*Log[2]) + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[4, IF12] -> -1/2*(eps^2*Pi^2) + G[0, t]*(-4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(2*eps + 8*eps^2*G[0, t] + 
     4*eps^2*G[-r^(-1), t] + 4*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - 
     eps^2*G[r, t]) + G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] + eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   eps^2*G[-1, 0, t^2] - eps^2*G[0, -1, t^2] + 4*eps^2*G[0, 0, r] - 
   5*eps^2*G[0, 0, t^2] + 4*eps^2*G[0, -I, r] + 4*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   2*eps^2*G[-r^(-1), -r, t] + 2*eps^2*G[r^(-1), -r, t] + 
   3*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + 
   eps^2*G[r, 0, t] - eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - 
   eps*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r, t]*Log[2] + 
   G[0, t^2]*(-eps - 3*eps^2*Log[2]) + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[5, IF12] -> -1/4*(eps^2*Pi^2) + G[-I, r]*(3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   G[I, r]*(3*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + 3*eps^2*G[r, t]) + 
   14*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t^2] - 8*eps^2*G[0, 0, r] + 
   4*eps^2*G[0, 0, t^2] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] + 4*eps^2*G[r^(-1), 0, t] - 
   4*eps^2*G[r^(-1), -r^(-1), t] - 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] + 
   4*eps^2*G[r, 0, t] - 3*eps^2*G[r, -r^(-1), t] - 4*eps^2*G[r, -r, t] - 
   2*eps^2*G[1, t^2]*Log[2] + 4*eps^2*G[r^(-1), t]*Log[2] + 
   4*eps^2*G[r, t]*Log[2] + 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(4*eps + 2*eps^2*Log[2]) + G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r^(-1), t]*(-2*eps - 3*eps^2*G[-I, r] - 3*eps^2*G[I, r] + 
     4*eps^2*Log[2]) + G[0, r]*(-2*eps - 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] - 4*eps^2*G[r, t] + 
     8*eps^2*Log[2]) + (eps^2*(-7*Pi^2 - 48*Log[2]^2))/12 + 
   (eps^2*(Pi^2 - 24*Log[2]^2))/3, H[6, IF12] -> 
  (5*eps^2*Pi^2)/6 + 4*eps*G[0, t^2] + 
   G[0, t]*(-10*eps - 24*eps^2*G[-I, r] - 24*eps^2*G[I, r]) + 
   G[-I, r]*(-6*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] - 3*eps^2*G[r, t]) + 
   G[I, r]*(-6*eps - 3*eps^2*G[-r^(-1), t] - 3*eps^2*G[r^(-1), t] - 
     3*eps^2*G[-r, t] - 3*eps^2*G[r, t]) + 
   G[0, r]*(-4*eps - 16*eps^2*G[0, t] - 6*eps^2*G[-r^(-1), t] + 
     2*eps^2*G[r^(-1), t] - 4*eps^2*G[-r, t] + 4*eps^2*G[r, t]) + 
   50*eps^2*G[-1, -1, t^2] + 14*eps^2*G[-1, 0, t^2] + 
   16*eps^2*G[0, -1, t^2] - 40*eps^2*G[0, 0, t] + 20*eps^2*G[0, 0, t^2] - 
   12*eps^2*G[0, -I, r] - 12*eps^2*G[0, I, r] - 8*eps^2*G[0, -r^(-1), t] - 
   8*eps^2*G[0, -r, t] - 12*eps^2*G[-I, 0, r] - 12*eps^2*G[-I, -I, r] - 
   12*eps^2*G[-I, I, r] - 12*eps^2*G[I, 0, r] - 12*eps^2*G[I, -I, r] - 
   12*eps^2*G[I, I, r] - 2*eps^2*G[1, -1, t^2] + 2*eps^2*G[1, 0, t^2] - 
   4*eps^2*G[-r^(-1), 0, t] - 4*eps^2*G[-r^(-1), -r^(-1), t] - 
   5*eps^2*G[-r^(-1), -r, t] - 4*eps^2*G[r^(-1), 0, t] + 
   4*eps^2*G[r^(-1), -r^(-1), t] + 3*eps^2*G[r^(-1), -r, t] - 
   4*eps^2*G[-r, 0, t] - 5*eps^2*G[-r, -r^(-1), t] - 4*eps^2*G[-r, -r, t] - 
   4*eps^2*G[r, 0, t] + 3*eps^2*G[r, -r^(-1), t] + 4*eps^2*G[r, -r, t] - 
   6*eps*Log[2] + 2*eps^2*G[1, t^2]*Log[2] - 4*eps^2*G[r^(-1), t]*Log[2] - 
   4*eps^2*G[r, t]*Log[2] + 20*eps^2*Log[2]^2 + 
   G[-r^(-1), t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-r, t]*(-2*eps + 4*eps^2*Log[2]) + 
   G[-1, t^2]*(16*eps + 14*eps^2*Log[2]) + (eps^2*(-Pi^2 - 120*Log[2]^2))/3, 
 H[1, IF13] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF13] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF13] -> -1/4*(eps^2*Pi^2) - eps*G[0, t] + eps*G[0, t^2] + 
   G[0, r]*(eps + 2*eps^2*G[-r, t] + 2*eps^2*G[r, t]) + 
   2*eps^2*G[-1, 0, t^2] + 4*eps^2*G[0, -1, t^2] + 6*eps^2*G[0, 0, r] - 
   6*eps^2*G[0, 0, t] - 3*eps^2*G[0, 0, t^2] + 6*eps^2*G[0, -I, r] + 
   6*eps^2*G[0, I, r] - 3*eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] + 
   2*eps^2*G[1, 0, t^2] - 2*eps^2*G[-r, 0, t] - 2*eps^2*G[r, 0, t], 
 H[4, IF13] -> (eps^2*Pi^2)/2 + G[0, t]*(4*eps^2*G[-I, r] + 
     4*eps^2*G[I, r]) + G[-I, r]*(eps + 2*eps^2*G[-r^(-1), t] + 
     2*eps^2*G[r^(-1), t] - eps^2*G[-r, t] - eps^2*G[r, t]) + 
   G[I, r]*(eps + 2*eps^2*G[-r^(-1), t] + 2*eps^2*G[r^(-1), t] - 
     eps^2*G[-r, t] - eps^2*G[r, t]) + 
   G[0, r]*(-2*eps - 8*eps^2*G[0, t] - 4*eps^2*G[-r^(-1), t] - 
     4*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + eps^2*G[r, t]) - 
   5*eps^2*G[-1, -1, t^2] - eps^2*G[-1, 0, t^2] + eps^2*G[0, -1, t^2] - 
   4*eps^2*G[0, 0, r] + 5*eps^2*G[0, 0, t^2] - 4*eps^2*G[0, -I, r] - 
   4*eps^2*G[0, I, r] - 4*eps^2*G[0, -r, t] + 2*eps^2*G[-I, 0, r] + 
   2*eps^2*G[-I, -I, r] + 2*eps^2*G[-I, I, r] + 2*eps^2*G[I, 0, r] + 
   2*eps^2*G[I, -I, r] + 2*eps^2*G[I, I, r] - 2*eps^2*G[1, -1, t^2] + 
   2*eps^2*G[1, 0, t^2] - 2*eps^2*G[-r^(-1), -r, t] - 
   2*eps^2*G[r^(-1), -r, t] - 3*eps^2*G[-r, 0, t] - 
   2*eps^2*G[-r, -r^(-1), t] - 2*eps^2*G[-r, -r, t] - eps^2*G[r, 0, t] + 
   eps^2*G[r, -r^(-1), t] + eps^2*G[r, -r, t] + eps*Log[2] + 
   2*eps^2*G[1, t^2]*Log[2] - eps^2*G[r, t]*Log[2] + 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-eps + eps^2*Log[2]) + G[-r, t]*(-eps + eps^2*Log[2]) + 
   G[0, t^2]*(eps + 3*eps^2*Log[2]) + (eps^2*(-2*Pi^2 - 21*Log[2]^2))/6, 
 H[5, IF13] -> -4*eps^2*G[0, t]*G[I, r] - eps^2*G[0, r]*G[r^(-1), t] + 
   G[I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] + eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   5*eps^2*G[-1, -1, t^2] - 3*eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] + 
   3*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   3*eps^2*G[-r^(-1), 0, t] + 2*eps^2*G[-r^(-1), -r^(-1), t] + 
   2*eps^2*G[-r^(-1), -r, t] + eps^2*G[r^(-1), 0, t] - 
   eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[r, -r^(-1), t] - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r^(-1), t]*Log[2] + 
   G[-1, t^2]*(eps - eps^2*Log[2]) + G[-r^(-1), t]*
    (eps + 3*eps^2*G[0, r] - eps^2*Log[2]) + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF13] -> (-7*eps^2*Pi^2)/6 + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(2*eps + 2*eps^2*G[-1, t] + 
     16*eps^2*G[0, t] + 2*eps^2*G[1, t] + 2*eps^2*G[-r, t] - 
     6*eps^2*G[r, t]) + G[-I, r]*(2*eps + 4*eps^2*G[-r, t] + 
     4*eps^2*G[r, t]) + G[I, r]*(2*eps + 4*eps^2*G[-r, t] + 
     4*eps^2*G[r, t]) - 16*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t] - 
   8*eps^2*G[-1, 0, t^2] - 2*eps^2*G[-1, -r^(-1), t] + 2*eps^2*G[-1, -r, t] - 
   10*eps^2*G[0, -1, t^2] - 4*eps^2*G[0, 0, r] + 28*eps^2*G[0, 0, t] - 
   12*eps^2*G[0, 0, t^2] + 8*eps^2*G[0, -I, r] + 8*eps^2*G[0, I, r] + 
   6*eps^2*G[0, -r^(-1), t] + 10*eps^2*G[0, -r, t] + 8*eps^2*G[-I, 0, r] + 
   8*eps^2*G[I, 0, r] - 2*eps^2*G[1, -1, t^2] + 2*eps^2*G[1, 0, t] - 
   4*eps^2*G[1, 0, t^2] - 2*eps^2*G[1, -r^(-1), t] + 2*eps^2*G[1, -r, t] + 
   10*eps^2*G[-r, 0, t] + 2*eps^2*G[-r, -r^(-1), t] + 4*eps^2*G[-r, -r, t] + 
   6*eps^2*G[r, 0, t] - 4*eps^2*G[r, -r^(-1), t] - 2*eps^2*G[r, -r, t] + 
   2*eps*Log[2] + 2*eps^2*G[1, t^2]*Log[2] + 2*eps^2*G[r, t]*Log[2] + 
   G[-1, t^2]*(-6*eps - 8*eps^2*Log[2]) + 
   G[0, t^2]*(-4*eps - 6*eps^2*Log[2]) + G[-r, t]*(2*eps - 2*eps^2*Log[2]) + 
   (eps^2*(Pi^2 - 3*Log[2]^2))/3 + (2*eps^2*(Pi^2 + 12*Log[2]^2))/3, 
 H[1, IF14] -> (eps^2*Pi^2)/16 + G[-I, r]*((-3*eps^2*G[r^(-1), t])/8 + 
     (3*eps^2*G[-r, t])/8 - (3*eps^2*G[r, t])/8) + 
   G[I, r]*((-3*eps^2*G[r^(-1), t])/8 + (3*eps^2*G[-r, t])/8 - 
     (3*eps^2*G[r, t])/8) - (9*eps^2*G[-1, -1, t^2])/4 - 
   (3*eps^2*G[-1, 0, t^2])/4 - (3*eps^2*G[0, -1, t^2])/4 + 
   2*eps^2*G[0, 0, r] + (eps^2*G[0, 0, t])/2 - (5*eps^2*G[0, 0, t^2])/4 + 
   (3*eps^2*G[0, -r^(-1), t])/4 + (3*eps^2*G[0, -r, t])/4 + 
   (9*eps^2*G[-r^(-1), 0, t])/8 + (3*eps^2*G[-r^(-1), -r^(-1), t])/4 + 
   (3*eps^2*G[-r^(-1), -r, t])/4 - (3*eps^2*G[r^(-1), 0, t])/8 + 
   (3*eps^2*G[r^(-1), -r^(-1), t])/8 + (3*eps^2*G[r^(-1), -r, t])/8 + 
   (9*eps^2*G[-r, 0, t])/8 + (3*eps^2*G[-r, -r^(-1), t])/4 + 
   (3*eps^2*G[-r, -r, t])/4 - (3*eps^2*G[r, 0, t])/8 + 
   (3*eps^2*G[r, -r^(-1), t])/8 + (3*eps^2*G[r, -r, t])/8 - 
   (3*eps^2*G[r^(-1), t]*Log[2])/8 - (3*eps^2*G[r, t]*Log[2])/8 + 
   (9*eps^2*Log[2]^2)/8 + G[0, r]*(eps/2 + eps^2*G[0, t] + 
     (9*eps^2*G[-r^(-1), t])/8 + (3*eps^2*G[r^(-1), t])/8 + 
     (9*eps^2*G[-r, t])/8 + (3*eps^2*G[r, t])/8 - eps^2*Log[2]) + 
   G[-1, t^2]*((-3*eps)/4 - (3*eps^2*Log[2])/4) + 
   G[0, t]*(eps/4 - (eps^2*Log[2])/2) + 
   G[-r, t]*((3*eps)/8 - (3*eps^2*Log[2])/8) + 
   G[-r^(-1), t]*((3*eps)/8 + (3*eps^2*G[-I, r])/8 + (3*eps^2*G[I, r])/8 - 
     (3*eps^2*Log[2])/8) + G[0, t^2]*(-1/4*eps - (eps^2*Log[2])/4), 
 H[2, IF14] -> (eps^2*Pi^2)/6 + G[0, t]*(-eps - 2*eps^2*G[-I, r] - 
     2*eps^2*G[I, r]) + G[-I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - 
     (eps^2*G[r^(-1), t])/4 - (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[I, r]*(-1/2*eps - (eps^2*G[-r^(-1), t])/4 - (eps^2*G[r^(-1), t])/4 - 
     (eps^2*G[-r, t])/4 - (eps^2*G[r, t])/4) + 
   G[0, r]*(-1/2*eps - 2*eps^2*G[0, t] - (3*eps^2*G[-r^(-1), t])/4 + 
     (eps^2*G[r^(-1), t])/4 - (3*eps^2*G[-r, t])/4 + (eps^2*G[r, t])/4) + 
   (9*eps^2*G[-1, -1, t^2])/2 + (3*eps^2*G[-1, 0, t^2])/2 + 
   (3*eps^2*G[0, -1, t^2])/2 - eps^2*G[0, 0, r] - 4*eps^2*G[0, 0, t] + 
   (5*eps^2*G[0, 0, t^2])/2 - eps^2*G[0, -I, r] - eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] - eps^2*G[0, -r, t] - eps^2*G[-I, 0, r] - 
   eps^2*G[-I, -I, r] - eps^2*G[-I, I, r] - eps^2*G[I, 0, r] - 
   eps^2*G[I, -I, r] - eps^2*G[I, I, r] - (3*eps^2*G[-r^(-1), 0, t])/4 - 
   (eps^2*G[-r^(-1), -r^(-1), t])/2 - (eps^2*G[-r^(-1), -r, t])/2 - 
   (eps^2*G[r^(-1), 0, t])/4 + (eps^2*G[r^(-1), -r^(-1), t])/4 + 
   (eps^2*G[r^(-1), -r, t])/4 - (3*eps^2*G[-r, 0, t])/4 - 
   (eps^2*G[-r, -r^(-1), t])/2 - (eps^2*G[-r, -r, t])/2 - 
   (eps^2*G[r, 0, t])/4 + (eps^2*G[r, -r^(-1), t])/4 + 
   (eps^2*G[r, -r, t])/4 - (eps*Log[2])/2 - (eps^2*G[r^(-1), t]*Log[2])/4 - 
   (eps^2*G[r, t]*Log[2])/4 - (15*eps^2*Log[2]^2)/4 + 
   G[-r^(-1), t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[-r, t]*(-1/4*eps + (eps^2*Log[2])/4) + 
   G[0, t^2]*(eps/2 + (eps^2*Log[2])/2) + 
   G[-1, t^2]*((3*eps)/2 + (3*eps^2*Log[2])/2) + 
   (eps^2*(-Pi^2 + 16*Log[2]^2))/8, 
 H[3, IF14] -> (eps^2*Pi^2)/4 + G[0, t]*(-eps - 4*eps^2*G[-I, r] - 
     4*eps^2*G[I, r]) + G[0, r]*(eps + 2*eps^2*G[-r^(-1), t] + 
     2*eps^2*G[r^(-1), t] + 3*eps^2*G[-r, t] - eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 
   G[I, r]*(-eps - 2*eps^2*G[-r^(-1), t] - 2*eps^2*G[r^(-1), t] + 
     eps^2*G[-r, t] + eps^2*G[r, t]) + 5*eps^2*G[-1, -1, t^2] + 
   3*eps^2*G[-1, 0, t^2] + 3*eps^2*G[0, -1, t^2] + 6*eps^2*G[0, 0, r] - 
   6*eps^2*G[0, 0, t] - 2*eps^2*G[0, -I, r] - 2*eps^2*G[0, I, r] - 
   eps^2*G[0, -r^(-1), t] + eps^2*G[0, -r, t] - 2*eps^2*G[-I, 0, r] - 
   2*eps^2*G[-I, -I, r] - 2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 
   2*eps^2*G[I, -I, r] - 2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 
   2*eps^2*G[-r^(-1), 0, t] + 2*eps^2*G[-r^(-1), -r, t] - 
   2*eps^2*G[r^(-1), 0, t] + 2*eps^2*G[r^(-1), -r, t] + 3*eps^2*G[-r, 0, t] + 
   2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[-r, -r, t] + eps^2*G[r, 0, t] - 
   eps^2*G[r, -r^(-1), t] - eps^2*G[r, -r, t] - eps*Log[2] - 
   3*eps^2*G[0, t^2]*Log[2] - 2*eps^2*G[1, t^2]*Log[2] + 
   eps^2*G[r, t]*Log[2] + G[-1, t^2]*(eps - eps^2*Log[2]) + 
   G[-r, t]*(eps - eps^2*Log[2]) + (eps^2*(-Pi^2 - 3*Log[2]^2))/6, 
 H[4, IF14] -> (eps^2*Pi^2)/2 + G[0, t]*(4*eps^2*G[-I, r] + 
     4*eps^2*G[I, r]) + G[-I, r]*(eps + 2*eps^2*G[-r^(-1), t] + 
     2*eps^2*G[r^(-1), t] - eps^2*G[-r, t] - eps^2*G[r, t]) + 
   G[I, r]*(eps + 2*eps^2*G[-r^(-1), t] + 2*eps^2*G[r^(-1), t] - 
     eps^2*G[-r, t] - eps^2*G[r, t]) + 
   G[0, r]*(-2*eps - 8*eps^2*G[0, t] - 4*eps^2*G[-r^(-1), t] - 
     4*eps^2*G[r^(-1), t] - 3*eps^2*G[-r, t] + eps^2*G[r, t]) - 
   5*eps^2*G[-1, -1, t^2] - eps^2*G[-1, 0, t^2] + eps^2*G[0, -1, t^2] - 
   4*eps^2*G[0, 0, r] + 5*eps^2*G[0, 0, t^2] - 4*eps^2*G[0, -I, r] - 
   4*eps^2*G[0, I, r] - 4*eps^2*G[0, -r, t] + 2*eps^2*G[-I, 0, r] + 
   2*eps^2*G[-I, -I, r] + 2*eps^2*G[-I, I, r] + 2*eps^2*G[I, 0, r] + 
   2*eps^2*G[I, -I, r] + 2*eps^2*G[I, I, r] - 2*eps^2*G[1, -1, t^2] + 
   2*eps^2*G[1, 0, t^2] - 2*eps^2*G[-r^(-1), -r, t] - 
   2*eps^2*G[r^(-1), -r, t] - 3*eps^2*G[-r, 0, t] - 
   2*eps^2*G[-r, -r^(-1), t] - 2*eps^2*G[-r, -r, t] - eps^2*G[r, 0, t] + 
   eps^2*G[r, -r^(-1), t] + eps^2*G[r, -r, t] + eps*Log[2] + 
   2*eps^2*G[1, t^2]*Log[2] - eps^2*G[r, t]*Log[2] + 4*eps^2*Log[2]^2 + 
   G[-1, t^2]*(-eps + eps^2*Log[2]) + G[-r, t]*(-eps + eps^2*Log[2]) + 
   G[0, t^2]*(eps + 3*eps^2*Log[2]) + (eps^2*(-2*Pi^2 - 21*Log[2]^2))/6, 
 H[5, IF14] -> -4*eps^2*G[0, t]*G[I, r] - eps^2*G[0, r]*G[r^(-1), t] + 
   G[I, r]*(-eps + eps^2*G[-r^(-1), t] + eps^2*G[r^(-1), t] - 
     2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   G[-I, r]*(-eps - 4*eps^2*G[0, t] + eps^2*G[-r^(-1), t] + 
     eps^2*G[r^(-1), t] - 2*eps^2*G[-r, t] - 2*eps^2*G[r, t]) + 
   5*eps^2*G[-1, -1, t^2] - 3*eps^2*G[-1, 0, t^2] - 5*eps^2*G[0, -1, t^2] + 
   3*eps^2*G[0, 0, t^2] - 8*eps^2*G[0, -I, r] - 8*eps^2*G[0, I, r] + 
   4*eps^2*G[0, -r^(-1), t] - 2*eps^2*G[-I, 0, r] - 2*eps^2*G[-I, -I, r] - 
   2*eps^2*G[-I, I, r] - 2*eps^2*G[I, 0, r] - 2*eps^2*G[I, -I, r] - 
   2*eps^2*G[I, I, r] + 2*eps^2*G[1, -1, t^2] - 2*eps^2*G[1, 0, t^2] + 
   3*eps^2*G[-r^(-1), 0, t] + 2*eps^2*G[-r^(-1), -r^(-1), t] + 
   2*eps^2*G[-r^(-1), -r, t] + eps^2*G[r^(-1), 0, t] - 
   eps^2*G[r^(-1), -r^(-1), t] - eps^2*G[r^(-1), -r, t] + 
   2*eps^2*G[-r, -r^(-1), t] + 2*eps^2*G[r, -r^(-1), t] - eps*Log[2] - 
   2*eps^2*G[1, t^2]*Log[2] + eps^2*G[r^(-1), t]*Log[2] + 
   G[-1, t^2]*(eps - eps^2*Log[2]) + G[-r^(-1), t]*
    (eps + 3*eps^2*G[0, r] - eps^2*Log[2]) + 
   G[0, t^2]*(-eps + eps^2*Log[2]) + (eps^2*(2*Pi^2 - 3*Log[2]^2))/6, 
 H[6, IF14] -> (-7*eps^2*Pi^2)/6 + G[0, t]*(6*eps + 8*eps^2*G[-I, r] + 
     8*eps^2*G[I, r]) + G[0, r]*(2*eps - 2*eps^2*G[-1, t] + 
     16*eps^2*G[0, t] - 2*eps^2*G[1, t] + 6*eps^2*G[-r^(-1), t] - 
     2*eps^2*G[r^(-1), t]) + G[-I, r]*(2*eps + 4*eps^2*G[-r^(-1), t] + 
     4*eps^2*G[r^(-1), t]) + G[I, r]*(2*eps + 4*eps^2*G[-r^(-1), t] + 
     4*eps^2*G[r^(-1), t]) - 16*eps^2*G[-1, -1, t^2] + 2*eps^2*G[-1, 0, t] - 
   16*eps^2*G[-1, 0, t^2] + 2*eps^2*G[-1, -r^(-1), t] - 
   2*eps^2*G[-1, -r, t] - 18*eps^2*G[0, -1, t^2] - 4*eps^2*G[0, 0, r] + 
   28*eps^2*G[0, 0, t] - 12*eps^2*G[0, 0, t^2] + 8*eps^2*G[0, -I, r] + 
   8*eps^2*G[0, I, r] + 10*eps^2*G[0, -r^(-1), t] + 6*eps^2*G[0, -r, t] + 
   8*eps^2*G[-I, 0, r] + 8*eps^2*G[I, 0, r] - 2*eps^2*G[1, -1, t^2] + 
   2*eps^2*G[1, 0, t] - 4*eps^2*G[1, 0, t^2] + 2*eps^2*G[1, -r^(-1), t] - 
   2*eps^2*G[1, -r, t] + 10*eps^2*G[-r^(-1), 0, t] + 
   4*eps^2*G[-r^(-1), -r^(-1), t] + 2*eps^2*G[-r^(-1), -r, t] + 
   6*eps^2*G[r^(-1), 0, t] - 2*eps^2*G[r^(-1), -r^(-1), t] - 
   4*eps^2*G[r^(-1), -r, t] + 2*eps*Log[2] + 2*eps^2*G[1, t^2]*Log[2] + 
   2*eps^2*G[r^(-1), t]*Log[2] + G[-1, t^2]*(-6*eps - 8*eps^2*Log[2]) + 
   G[-r^(-1), t]*(2*eps - 2*eps^2*Log[2]) + 
   G[0, t^2]*(-4*eps + 2*eps^2*Log[2]) + (eps^2*(Pi^2 - 3*Log[2]^2))/3 + 
   (2*eps^2*(Pi^2 + 12*Log[2]^2))/3}
