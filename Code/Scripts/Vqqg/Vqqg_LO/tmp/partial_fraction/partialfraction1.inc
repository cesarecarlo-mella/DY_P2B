repeat;
id INT(PL3,n1?,n2?,n3?,n4?{>0},n5?{>0}) = Den(s12-m2)*(-INT(PL3,n1,n2,n3,n4-1,n5)-INT(PL3,n1,n2,n3,n4,n5-1));
id INT(PL3, n1?, n2?, n3?, 0, n5?) = INT(PL2, n1,n2,n3,n5);
id INT(PL3, n1?, n2?, n3?, n4?,0) = INT(PL1, n1,n2,n3,n4);
id INT(PL3,n1?,n2?,n3?,n4?{<0},n5?)=(m2-s12)*INT(PL3,n1,n2,n3,n4+1,n5)-INT(PL3,n1,n2,n3,n4+1,n5-1);
id INT(PL3,n1?,n2?,n3?,n4?,n5?{<0})=(m2-s12)*INT(PL3,n1,n2,n3,n4,n5+1)-INT(PL3,n1,n2,n3,n4-1,n5+1);
endrepeat;
