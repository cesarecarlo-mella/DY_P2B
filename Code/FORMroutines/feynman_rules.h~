id vggg(mu1?,mu2?,mu3?,mom1?,mom2?,mom3?) = (    d_(mu1,mu2)*(mom2(mu3)-mom1(mu3))
                                         + d_(mu2,mu3)*(mom3(mu1)-mom2(mu1))
					 + d_(mu3,mu1)*(mom1(mu2)-mom3(mu2))  );


id vgggg(mu1?,mu2?,mu3?,mu4?) = d_(mu1,mu3)*d_(mu2,mu4)-d_(mu1,mu4)*d_(mu2,mu3);

***Effective Higgs vertices
id vHgg(mu1?,mu2?,mom1?,mom2?) = d_(mu1, mu2)*mom1.mom2 - mom1(mu2)*mom2(mu1);
id vHggg(mu1?,mu2?,mu3?,mom1?,mom2?,mom3?) = (   d_(mu1,mu2)*(mom2(mu3)-mom1(mu3))
                                         + d_(mu2,mu3)*(mom3(mu1)-mom2(mu1))
                                         + d_(mu3,mu1)*(mom1(mu2)-mom3(mu2))  );
id vHgggg(mu1?,mu2?,mu3?,mu4?) = d_(mu1,mu3)*d_(mu2,mu4)-d_(mu1,mu4)*d_(mu2,mu3);

***pseudoscalar Higgs vertices
id vAgg(mu1?,mu2?,mom1?,mom2?) = e_(mu1,mu2,nu1,nu2)*mom1(nu1)*mom2(nu2);
id vAggg(mu1?,mu2?,mu3?,mom1?,mom2?,mom3?) = e_(mu1,mu2,mu3,nu1)*(mom1(nu1)+mom2(nu1)+mom3(nu1));

id vQQZ(?x) = 1;
id vQQg(mu3?,n1?,n2?) = 1;
id vQQp(mu3?,n1?,n2?) = 1;
id vGGg(mu1?,mom1?) = mom1(mu1);

id pgluon(mu1?,mu2?,v?) = d_(mu1, mu2)*Prop(v);
id pQuark(n1?,v?,n2?) = Prop(v);
id pghost(v?) = Prop(v);


****cut final state, axial gauge for gluons, rapidity distribution delta, indices for the vector boson V will close with the leptonic current. 
*id pol(gluon(mu93,v?,a1?))*pol(Cutgluon(nu93,v?,a1?)) = Prop(cut,v)*(- d_(mu93,nu93) + (p1(mu93)*v(nu93) + v(mu93)*p1(nu93))*Den(v.p1));
id pol(gluon(mu99, v?,a1?))*pol(gluon(nu99,v?,a1?)) = (- d_(mu99,nu99));
id pol(gluon(mu97, v?,a1?))*pol(gluon(nu97,v?,a1?)) = (- d_(mu97,nu97));


**cut 
id pol(gluon(mu93,v?,a1?))*pol(Cutgluon(nu93,v?,a1?)) = Prop(cut,v)*(- d_(mu93,nu93));
id pol(gluon(mu91,v?,a1?))*pol(Cutgluon(nu91,v?,a1?)) = Prop(cut,v)*(- d_(mu91,nu91));
id pol(gluon(mu89, v?,a1?))*pol(Cutgluon(nu89,v?,a1?)) = Prop(cut,v)*(- d_(mu89,nu89));
id pol(Qbar(93,v?,i1?))*pol(CutQbar(93,v?,i1?)) = Prop(cut,v);
id pol(Quark(93,v?,i1?))*pol(CutQuark(93,v?,i1?)) = Prop(cut,v);
id pol(Qbar(91,v?,i1?))*pol(CutQbar(91,v?,i1?)) = Prop(cut,v);
id pol(Quark(91,v?,i1?))*pol(CutQuark(91,v?,i1?)) = Prop(cut,v);
id pol(Qbar2(93,v?,i1?))*pol(CutQbar2(93,v?,i1?)) = Prop(cut,v);
id pol(Quark2(93,v?,i1?))*pol(CutQuark2(93,v?,i1?)) = Prop(cut,v);
id pol(Qbar2(91,v?,i1?))*pol(CutQbar2(91,v?,i1?)) = Prop(cut,v);
id pol(Quark2(91,v?,i1?))*pol(CutQuark2(91,v?,i1?)) = Prop(cut,v);
id pol(V(mu95,v?))*pol(CutV(nu95, v?)) = Prop(cut, -v, m2)*(-v.p2)*Den(cut, - v.p1 + u*v.p2);
.sort
