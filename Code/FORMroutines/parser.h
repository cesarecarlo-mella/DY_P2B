#if 'PROC' == Vqq;
argument pol, v3, v4, v5;
id Quark(-1,v?) = Quark(99,v);
id Qbar(-3,v?) = Qbar(97,v);
id V(-5,v?) = V(95, v);
endargument;
#endif

#if 'PROC' == Vqqg;
argument pol, v3, v4, v5;
id Quark(-1,v?) = Quark(99,v);
id Qbar(-3,v?) = Qbar(97,v);
id V(-5,v?) = V(95,v);
id gluon(-7,v?) = gluon(93, v);
endargument;
#endif


#if 'PROC' == Vqgq;
argument pol, v3, v4, v5;
id Quark(-1,v?) = Quark(99,v);
id gluon(-3,v?) = gluon(97,v);
id V(-5,v?) = V(95,v);
id Qbar(-7,v?) = Qbar(93, v);
endargument;
#endif


#if 'PROC' == Vqbgqb;
argument pol, v3, v4, v5;
id Quark(-7,v?) = Quark(93,v);
id gluon(-3,v?) = gluon(97,v);
id V(-5,v?) = V(95,v);
id Qbar(-1,v?) = Qbar(99, v);
endargument;
#endif



 


* Give to gluons all the properties they need: if more gluon increase cycle ...unlikely
argument pol, v3, v4, v5;
#do j1 =  99,92,-2
    id gluon('j1', p1?) = gluon(mu'j1', p1, a'j1');
    id Quark('j1', p1?) = Quark('j1', p1, i'j1');
    id Qbar('j1', p1?) = Qbar('j1',p1, i'j1');
    id photon('j1', p1?) = photon(mu'j1', p1);
    id V('j1', p1?) = V(mu'j1', p1);
#enddo
#do j1 = 1,20,1
    id gluon('j1', p1?) = gluon(mu'j1', p1, a'j1');
    id ghost('j1', p1?) = ghost(p1, a'j1');
    id Ghost('j1', p1?) = Ghost(p1, a'j1');
    id Quark('j1', p1?) = Quark('j1', p1, i'j1');
    id Qbar('j1', p1?) = Qbar('j1',p1, i'j1');
    id photon('j1', p1?) = photon(mu'j1', p1);
#enddo
endargument;
.sort

*This is a nested loop over all the nodes
#do j1=1,20,1
#do j2=1,20,1
id prop(Quark('j1','j2',v?)) = pQuark(i'j1',i'j2','j1',v,'j2');
id prop(gluon('j1','j2',v?)) = pgluon(a'j1',a'j2',mu'j1',mu'j2',v);
id prop(ghost('j1','j2',v?)) = pghost(a'j1',a'j2',v);
#enddo
#enddo
.sort



id v3(Qbar(n1?,mom1?,i1?),gluon(mu2?,mom2?,a2?),Quark(n3?,mom3?,i3?)) = 
    vQQg(i1,a2,i3,n1,mu2,n3);
id v3(Qbar(n1?,mom1?,i1?),Z(?x),Quark(n3?,mom3?,i3?)) = 
    vQQZ(i1,i3,n1,mu95,n3);
id v3(Qbar(n1?,mom1?,i1?), photon(mu2?,mom2?),Quark(n3?,mom3?,i3?)) =
    vQQp(i1,i3,n1,mu2,n3);
id v3(Qbar(n1?,mom1?,i1?), V(mu2?,mom2?),Quark(n3?,mom3?,i3?)) =
  vQQV(i1,i3,n1,mu2,n3);
id v3(gluon(mu1?,mom1?,a1?),gluon(mu2?,mom2?,a2?),gluon(mu3?,mom3?,a3?)) = 
    vggg(a1,a2,a3,mu1,mu2,mu3,mom1,mom2,mom3);
id v3(Ghost(mom1?,a1?),gluon(mu2?,mom2?,a2?),ghost(mom3?,a3?)) = 
    vGGg(a1,a2,a3,mu2,mom1);


id v4(gluon(mu1?,mom1?,a1?),gluon(mu2?,mom2?,a2?),gluon(mu3?,mom3?,a3?),
      gluon(mu4?,mom4?,a4?)) = 
    vgggg(a1,a2,a3,a4,mu1,mu2,mu3,mu4);

id v3(gluon(mu1?,mom1?,a1?),gluon(mu2?,mom2?,a2?),H(n1? v?)) =
    vHgg(a1,a2,mu1,mu2,mom1,mom2);

id v4(gluon(mu1?,mom1?,a1?),gluon(mu2?,mom2?,a2?),gluon(mu3?,mom3?,a3?),
      H(n1? v?)) = 
    vHggg(a1,a2,a3,mu1,mu2,mu3,mom1,mom2,mom3);

id v5(gluon(mu1?,mom1?,a1?),gluon(mu2?,mom2?,a2?),gluon(mu3?,mom3?,a3?),
      gluon(mu4?,mom4?,a4?),H(n1? v?)) =
    vHgggg(a1,a2,a3,a4,mu1,mu2,mu3,mu4);

id v3(gluon(mu1?,mom1?,a1?),gluon(mu2?,mom2?,a2?),A(n1? v?)) =
    vAgg(a1,a2,mu1,mu2,mom1,mom2);

id v4(gluon(mu1?,mom1?,a1?),gluon(mu2?,mom2?,a2?),gluon(mu3?,mom3?,a3?),
      A(n1? v?)) = 
    vAggg(a1,a2,a3,mu1,mu2,mu3,mom1,mom2,mom3);
.sort
