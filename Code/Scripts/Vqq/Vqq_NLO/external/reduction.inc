id INT(PL,0,0,1) = 
 + 0
;

id INT(PL,1,1,0) = 
 + 0
;

id INT(PL,1,0,1) = 
 + 0
;

id INT(PL,0,1,0) = 
 + 0
;

id INT(PL,1,0,0) = 
 + 0
;

id INT(PL,0,1,1) = 
 + INT(PL,0,2,1)*(Num(-m2)*Den(d-3))
;

id INT(PL,-1,1,1) = 
 + INT(PL,0,2,1)*(Num(m2^2)*Den(2*d-6))
;

id INT(PL,1,1,1) = 
 + INT(PL,0,2,1)*(Num(2)*Den(d-4))
;
