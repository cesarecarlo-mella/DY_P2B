(* Created with the Wolfram Language : www.wolfram.com *)
((CF^2*((9/4 - (2*Pi^2)/3)*delta[1 - y] + (9/4 - (2*Pi^2)/3)*delta[y]))/
    ep^2 + (CF^2*((-9/4 + (2*Pi^2)/3)*delta[1 - y] + 
      (-9/4 + (2*Pi^2)/3)*delta[y]))/ep)*delta[1 - z] + 
 (CF^2*(-(((-1 + z)*(1 + z)^2*(y*(-1 + z) - z - 
        Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))]))/
      ((y + z - y*z)^2*(z + y*(-1 + z)*z))) + 
    P[y, 0]*((2*(1 + z)*(y*(-1 + z) - z - Sqrt[z]*
          Sqrt[(y + z - y*z)/(1 + y*(-1 + z))]))/((1 + y*(-1 + z))*
        (y*(-1 + z) - z)*z) - 
      (4*(y + z - y*z + Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))])*
        P[1 - z, 0])/(z*(y + z - y*z))) + 
    P[1 - y, 0]*((-2*(1 + z)*(y*(-1 + z) - z - 
         Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))]))/(z*(y + z - y*z)^2) - 
      (4*(y + z - y*z + Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))])*
        P[1 - z, 0])/(z*(y + z - y*z))) + 
    delta[y]*(((1 + z)*(3 + 4*Log[1 - z] + 4*(-Log[2] - Log[z] + 
           Log[1 + z])))/z + ((-6 + 8*Log[2] - 8*(-Log[z] + Log[1 + z]))*
        P[1 - z, 0])/z - (8*P[1 - z, 1])/z) + 
    delta[1 - y]*((3*(1 + z) + 4*(1 + z)*Log[1 - z] + 
        4*(1 + z)*(-Log[2] - Log[z] + Log[1 + z]))/z + 
      ((-6 + 8*Log[2] - 8*(-Log[z] + Log[1 + z]))*P[1 - z, 0])/z - 
      (8*P[1 - z, 1])/z)))/ep + 
 (CF^2*(((-1 + z)*(1 + z)^2*(y*(-1 + z) - z - 
       Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))]))/
     ((y + z - y*z)^2*(z + y*(-1 + z)*z)) + 
    P[1 - y, 0]*((2*(1 + z)*(y*(-1 + z) - z - 
         Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))]))/(z*(y + z - y*z)^2) + 
      (4*(y + z - y*z + Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))])*
        P[1 - z, 0])/(z*(y + z - y*z))) + 
    P[y, 0]*((2*(1 + z)*(y*(-1 + z) - z - Sqrt[z]*
          Sqrt[(y + z - y*z)/(1 + y*(-1 + z))]))/((1 + y*(-1 + z))*z*
        (y + z - y*z)) + 
      (4*(y + z - y*z + Sqrt[z]*Sqrt[(y + z - y*z)/(1 + y*(-1 + z))])*
        P[1 - z, 0])/(z*(y + z - y*z))) + 
    delta[y]*(((1 + z)*(-3 + 4*Log[2] - 4*Log[1 - z] - 
         4*(-Log[z] + Log[1 + z])))/z + 
      ((6 + 8*(-Log[2] - Log[z] + Log[1 + z]))*P[1 - z, 0])/z + 
      (8*P[1 - z, 1])/z) + delta[1 - y]*
     (-((3*(1 + z) + 4*(1 + z)*Log[1 - z] + 4*(1 + z)*(-Log[2] - Log[z] + 
           Log[1 + z]))/z) + ((6 + 8*(-Log[2] - Log[z] + Log[1 + z]))*
        P[1 - z, 0])/z + (8*P[1 - z, 1])/z)))/ep^2
