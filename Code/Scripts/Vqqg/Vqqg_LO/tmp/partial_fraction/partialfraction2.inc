repeat;
id INT(PL1,n1?,n2?,n3?,n4?{>0}) = Den(s12-m2*u)*(-1-u)*INT(PL1,n1,n2,n3,n4-1);
id INT(PL1,n1?,n2?,n3?,0)=INT(PL1,n1,n2,n3);
id INT(PL1,n1?,n2?,n3?,n4?{<0})=INT(PL2,n1,n2,n3,n4+1)*(-s12+m2* u)*Den(1+u);
id INT(PL2,n1?,n2?,n3?,n4?{>0}) = Den(-m2+s12*u)*(-1-u)*INT(PL2,n1,n2,n3,n4-1);
id INT(PL2,n1?,n2?,n3?,0)=INT(PL1,n1,n2,n3);
id INT(PL2,n1?,n2?,n3?,n4?{<0})=INT(PL2,n1,n2,n3,n4+1)*(m2-s12*u)*Den(1+u);
endrepeat;
