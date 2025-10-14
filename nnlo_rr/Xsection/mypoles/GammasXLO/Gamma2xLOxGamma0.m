(* Created with the Wolfram Language : www.wolfram.com *)
CF*Nf*((delta[1 - y]*((z*(1 + z))/3 - (2*z*DD[0, 1 - z])/3 - delta[1 - z]/2))/
    ep + (delta[1 - y]*(-1/3*(z*(1 + z)) + (2*z*DD[0, 1 - z])/3 + 
      delta[1 - z]/2))/ep^2) + 
 CF^2*((delta[1 - y]*(6*z*DD[0, 1 - z] + 8*z*DD[1, 1 - z] + 
      ((27 - 8*Pi^2)*delta[1 - z])/12 - 
      (z*(-5 + 4*z + z^2 - 4*Log[1 - z] + 4*z^2*Log[1 - z] - Log[z] - 
         3*z^2*Log[z]))/(-1 + z)))/ep^2 + 
   delta[1 - y]*((z*(6 - 10*z + 4*z^2 + 4*Log[z] - 4*z*Log[z] - 
        4*Log[1 - z]*Log[z] - 4*z^2*Log[1 - z]*Log[z] + Log[z]^2 + 
        3*z^2*Log[z]^2 + 4*PolyLog[2, 1 - z] + 4*z^2*PolyLog[2, 1 - z]))/
      (2*(-1 + z)) + (delta[1 - z]*(-3 + 4*Pi^2 - 48*Zeta[3]))/8) + 
   (delta[1 - y]*(-6*z*DD[0, 1 - z] - 8*z*DD[1, 1 - z] + 
      (z*(-16 + 18*z - 2*z^2 - 8*Log[1 - z] + 8*z^2*Log[1 - z] - 6*Log[z] + 
         4*z*Log[z] - 6*z^2*Log[z] + 4*Log[1 - z]*Log[z] + 
         4*z^2*Log[1 - z]*Log[z] - Log[z]^2 - 3*z^2*Log[z]^2 - 
         4*PolyLog[2, 1 - z] - 4*z^2*PolyLog[2, 1 - z]))/(2*(-1 + z)) + 
      (delta[1 - z]*(-45 + 4*Pi^2 + 144*Zeta[3]))/24))/ep) + 
 CA*CF*((delta[1 - y]*((11*z*(1 + z))/6 - (11*z*DD[0, 1 - z])/3 - 
      (11*delta[1 - z])/4))/ep^2 + 
   (delta[1 - y]*(-1/9*((-100 + 3*Pi^2)*z*DD[0, 1 - z]) + 
      (z*(52 - 3*Pi^2 + 105*z - 157*z^2 + 3*Pi^2*z^2 - 6*Log[z] - 
         33*z^2*Log[z] + 18*PolyLog[2, 1 - z] + 18*z^2*PolyLog[2, 1 - z]))/
       (18*(-1 + z)) + (delta[1 - z]*(249 + 44*Pi^2 - 216*Zeta[3]))/72))/ep + 
   delta[1 - y]*(((-67 + 3*Pi^2)*z*DD[0, 1 - z])/9 - 
     (z*(19 - 3*Pi^2 + 105*z - 124*z^2 + 3*Pi^2*z^2 - 6*Log[z] - 
        33*z^2*Log[z] + 18*PolyLog[2, 1 - z] + 18*z^2*PolyLog[2, 1 - z]))/
      (18*(-1 + z)) + (delta[1 - z]*(-51 - 44*Pi^2 + 216*Zeta[3]))/72))
