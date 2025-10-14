(* Created with the Wolfram Language : www.wolfram.com *)
((CF^2*((9/4 - (2*Pi^2)/3)*delta[1 - y] + (9/4 - (2*Pi^2)/3)*delta[y]))/
    ep^2 + (CF^2*((-9/4 + (2*Pi^2)/3)*delta[1 - y] + 
      (-9/4 + (2*Pi^2)/3)*delta[y]))/ep)*delta[1 - z] + 
 CF^2*
  ((-(((-1 + z)*(1 + z)^2*(y + z - y*z + Sqrt[(z*(y + z - y*z))/
           (1 + y*(-1 + z))]))/((y + z - y*z)^2*(z + y*(-1 + z)*z))) + 
     DD[0, y]*((2*(1 + z)*(y + z - y*z + Sqrt[(z*(y + z - y*z))/
            (1 + y*(-1 + z))]))/((1 + y*(-1 + z))*(y*(-1 + z) - z)*z) - 
       (4*(y + z - y*z + Sqrt[(z*(y + z - y*z))/(1 + y*(-1 + z))])*
         DD[0, 1 - z])/((y*(-1 + z) - z)*z)) + 
     DD[0, 1 - y]*((-2*(1 + z)*(y + z - y*z + Sqrt[(z*(y + z - y*z))/
            (1 + y*(-1 + z))]))/(z*(y + z - y*z)^2) - 
       (4*(y + z - y*z + Sqrt[(z*(y + z - y*z))/(1 + y*(-1 + z))])*
         DD[0, 1 - z])/((y*(-1 + z) - z)*z)) + 
     DD[1, 1 - z]*((8*delta[1 - y])/z + (8*delta[y])/z) + 
     ((1 + z)*delta[1 - y]*(-3 + Log[16] - 4*Log[1 - z] + 4*Log[z] - 
        4*Log[1 + z]))/z + ((1 + z)*delta[y]*(-3 + Log[16] - 4*Log[1 - z] + 
        4*Log[z] - 4*Log[1 + z]))/z + DD[0, 1 - z]*
      ((delta[1 - y]*(6 - 8*Log[2] - 8*Log[z] + 8*Log[1 + z]))/z + 
       (delta[y]*(6 - 8*Log[2] - 8*Log[z] + 8*Log[1 + z]))/z))/ep^2 + 
   (((-1 + z)*(1 + z)^2*(y + z - y*z + Sqrt[(z*(y + z - y*z))/
          (1 + y*(-1 + z))]))/((y + z - y*z)^2*(z + y*(-1 + z)*z)) + 
     DD[0, y]*((-2*(1 + z)*(y + z - y*z + Sqrt[(z*(y + z - y*z))/
            (1 + y*(-1 + z))]))/((1 + y*(-1 + z))*(y*(-1 + z) - z)*z) + 
       (4*(y + z - y*z + Sqrt[(z*(y + z - y*z))/(1 + y*(-1 + z))])*
         DD[0, 1 - z])/((y*(-1 + z) - z)*z)) + 
     DD[0, 1 - y]*((2*(1 + z)*(y + z - y*z + Sqrt[(z*(y + z - y*z))/
            (1 + y*(-1 + z))]))/(z*(y + z - y*z)^2) + 
       (4*(y + z - y*z + Sqrt[(z*(y + z - y*z))/(1 + y*(-1 + z))])*
         DD[0, 1 - z])/((y*(-1 + z) - z)*z)) + 
     DD[1, 1 - z]*((-8*delta[1 - y])/z - (8*delta[y])/z) - 
     ((1 + z)*delta[1 - y]*(-3 + Log[16] - 4*Log[1 - z] + 4*Log[z] - 
        4*Log[1 + z]))/z - ((1 + z)*delta[y]*(-3 + Log[16] - 4*Log[1 - z] + 
        4*Log[z] - 4*Log[1 + z]))/z + DD[0, 1 - z]*
      ((delta[1 - y]*(-6 + Log[256] - 8*(-Log[z] + Log[1 + z])))/z + 
       (delta[y]*(-6 + Log[256] - 8*(-Log[z] + Log[1 + z])))/z))/ep)
