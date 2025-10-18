(* Created with the Wolfram Language : www.wolfram.com *)
CF*Nf*((10*DD[0, 1 - z]*delta[1 - y])/9 + 
   ((2*DD[0, 1 - z]*delta[1 - y])/3 + delta[1 - y]*((-1 + z^(-1))/3 + 
       delta[1 - z]/2))/ep^2 + delta[1 - y]*(((3 + 4*Pi^2)*delta[1 - z])/36 - 
     (11*(-1 + z)^2 + 3*(1 + z^2)*Log[z])/(9*(-1 + z)*z)) + 
   ((-16*DD[0, 1 - z]*delta[1 - y])/9 + delta[1 - y]*
      ((-7/12 - Pi^2/9)*delta[1 - z] + (14*(-1 + z)^2 + 3*(1 + z^2)*Log[z])/
        (9*(-1 + z)*z)))/ep) + 
 CA*CF*(((-67 + 3*Pi^2)*DD[0, 1 - z]*delta[1 - y])/9 + 
   ((-11*DD[0, 1 - z]*delta[1 - y])/3 + delta[1 - y]*
      ((11*(-1 + z))/(6*z) - (11*delta[1 - z])/4))/ep^2 + 
   (((100 - 3*Pi^2)*DD[0, 1 - z]*delta[1 - y])/9 + 
     delta[1 - y]*(((148 + 3*Pi^2*(-1 + z) - 157*z)*(-1 + z) - 
         3*(2 + 11*z^2)*Log[z] + 18*(1 + z^2)*PolyLog[2, 1 - z])/
        (18*(-1 + z)*z) + delta[1 - z]*(83/24 + (11*Pi^2)/18 - 3*Zeta[3])))/
    ep + delta[1 - y]*((-((115 + 3*Pi^2*(-1 + z) - 124*z)*(-1 + z)) + 
       (6 + 33*z^2)*Log[z] - 18*(1 + z^2)*PolyLog[2, 1 - z])/
      (18*(-1 + z)*z) + delta[1 - z]*(-17/24 - (11*Pi^2)/18 + 3*Zeta[3]))) + 
 CF^2*((6*DD[0, 1 - z]*delta[1 - y] + 8*DD[1, 1 - z]*delta[1 - y] + 
     delta[1 - y]*((9/4 - (2*Pi^2)/3)*delta[1 - z] + 
       (-(-1 + z)^2 - 4*(-1 + z)^2*Log[1 - z] + (1 + 3*z^2)*Log[z])/
        ((-1 + z)*z)))/ep^2 + delta[1 - y]*
    ((6 - 10*z + 4*z^2 - 4*(-1 + z + (1 + z^2)*Log[1 - z])*Log[z] + 
       (1 + 3*z^2)*Log[z]^2 + 4*(1 + z^2)*PolyLog[2, 1 - z])/(2*(-1 + z)*z) + 
     delta[1 - z]*(-3/8 + Pi^2/2 - 6*Zeta[3])) + 
   (-6*DD[0, 1 - z]*delta[1 - y] - 8*DD[1, 1 - z]*delta[1 - y] + 
     delta[1 - y]*(-1/2*(4 - 6*z + 2*z^2 + 6*Log[z] - 4*z*Log[z] + 
          6*z^2*Log[z] + Log[z]^2 + 3*z^2*Log[z]^2 - 4*Log[1 - z]*
           (2*(-1 + z)^2 + (1 + z^2)*Log[z]) + 4*(1 + z^2)*PolyLog[2, 1 - z])/
         ((-1 + z)*z) + delta[1 - z]*(-15/8 + Pi^2/6 + 6*Zeta[3])))/ep)
