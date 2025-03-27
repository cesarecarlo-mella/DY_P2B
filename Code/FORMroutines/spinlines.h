***one external quark-qbar initial-initial line
id pol(Qbar(97,p2,i97))=Search(97)*Spin(1,p2);
repeat;
id Search(n1?)*vQQg(mu1?,n1?,n2?)*Spin(1,?x2) =  Save(vQQg(mu1,n1,n2)) * Search(n2) * Spin(1,mu1,?x2);
id Search(n1?)*vQQV(n1?,nu1?,n2?)*Spin(1,?z2)  = Save(vQQV(n1,nu1,n2))*Search(n2) *(gv(ti)*Spin(1,nu1,?z2) + ga(ti)*eps(nu1,rho1,rho2,rho3)/6 *Spin(1,rho1,rho2,rho3,?z2));
id Search(n1?)*pQuark(n1?,mom1?,n2?)*Spin(1,?x2)  =  Save(pQuark(n1,mom1,n2)) *Search(n2) * Spin(1,mom1,?x2) ;
endrepeat;
id Search(99)*pol(Quark(99, p1, i99))*Spin(1,?z2) = Spin(1,p1,?z2);
.sort
id Save(pQuark(?x))=pQuark(?x);
id Save(?x) = 1;
.sort



***one external qbar-qbar  initial-final line
*id pol(Qbar(99,p1,i99))=Search(99)*Spin(1,p1);
*repeat;
*id Search(n1?)*vQQg(mu1?,n1?,n2?)*Spin(1,?x2) =  Save(vQQg(mu1,n1,n2)) * Search(n2) * Spin(1,mu1,?x2);
*id Search(n1?)*vQQV(n1?,nu1?,n2?)*Spin(1,?z2)  = Save(vQQV(n1,nu1,n2))*Search(n2) *(gv(ti)*Spin(1,nu1,?z2) + ga(ti)*eps(nu1,rho1,rho2,rho3)/6 *Spi*n(1,rho1,rho2,rho3,?z2));
*id Search(n1?)*pQuark(n1?,mom1?,n2?)*Spin(1,?x2)  =  Save(pQuark(n1,mom1,n2)) *Search(n2) * Spin(1,mom1,?x2) ;
*endrepeat;
*id Search(93)*pol(Quark(93, r1, i93))*Spin(1,?z2) = Spin(1,r1,?z2)*Quark(93,r1,i93);
*.sort
*id Save(pQuark(?x))=pQuark(?x);
*** necessary for final state sum
*id Quark(93,r1,i93) = pol(Quark(93,r1,i93));
*id Save(?x) = 1;
*.sort



***one external quark-qbar initial-final  state line
id pol(Qbar(93,r1,i93))=Search(93)*Spin(1,r1)*Qbar(93,r1,i93);
repeat;
id Search(n1?)*vQQg(mu1?,n1?,n2?)*Spin(1,?x2) =  Save(vQQg(mu1,n1,n2)) * Search(n2) * Spin(1,mu1,?x2);
id Search(n1?)*vQQV(n1?,nu1?,n2?)*Spin(1,?z2)  = Save(vQQV(n1,nu1,n2))*Search(n2) *(gv(ti)*Spin(1,nu1,?z2) + ga(ti)*eps(nu1,rho1,rho2,rho3)/6 *Spin(1,rho1,rho2,rho3,?z2));
id Search(n1?)*pQuark(n1?,mom1?,n2?)*Spin(1,?x2)  =  Save(pQuark(n1,mom1,n2)) *Search(n2) * Spin(1,mom1,?x2) ;
endrepeat;
id Search(99)*pol(Quark(99, p1, i99))*Spin(1,?z2) = Spin(1,p1,?z2);
.sort
id Save(pQuark(?x))=pQuark(?x);
** necessary for final state sum 
id Qbar(93,r1,i93) = pol(Qbar(93,r1,i93));
id Save(?x) = 1;
.sort
