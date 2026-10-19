collect Num ;
.sort

id Num(n1?) = Ratio(n1,1);
id Den(n1?) = Ratio(1,n1);
.sort


Polyratfun Ratio;
.sort
Polyratfun;
.sort
id Ratio(n1?,n2?) = Num(n1)*Den(n2);
.sort
*if Polyratfun throws unexpected errors, comment out the following two lines
factarg Num ;
factarg Den ;

chainout Num ;
chainout Den ;
.sort
repeat id Den(n1?number_) = 1/n1 ;
repeat id Den(n1?symbol_) = 1/n1 ;
repeat id Num(n1?number_) = n1 ;
repeat id Num(n1?symbol_) = n1 ;
