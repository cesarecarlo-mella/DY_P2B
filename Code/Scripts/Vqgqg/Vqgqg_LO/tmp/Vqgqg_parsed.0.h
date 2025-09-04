id diag1 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i1,i2,1,p1 + p2,2)*pQuark(
      i3,i4,3, - q - r1,4)*vQQg(i2,a97,i99,2,mu97,99)*vQQg(i4,a91,i1,4,mu91,1)
      *vQQV(i93,i3,93,mu95,3);

id diag2 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i1,i2,1,p1 + p2,2)*pQuark(
      i3,i4,3, - r1 - r2,4)*vQQg(i93,a91,i3,93,mu91,3)*vQQg(i2,a97,i99,2,mu97,
      99)*vQQV(i4,i1,4,mu95,1);

id diag3 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i1,i2,1,q + p1,2)*pQuark(
      i3,i4,3, - p2 - r1,4)*vQQg(i93,a97,i3,93,mu97,3)*vQQg(i4,a91,i1,4,mu91,1
      )*vQQV(i2,i99,2,mu95,99);

id diag4 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i1,i2,1,q + p1,2)*pgluon(
      a3,a4,mu3,mu4, - p2 - r2)*vQQg(i93,a4,i1,93,mu4,1)*vQQV(i2,i99,2,mu95,99
      )*vggg(a97,a91,a3,mu97,mu91,mu3,p2,r2, - p2 - r2);

id diag5 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i1,i2,1,q + p1,2)*pQuark(
      i3,i4,3, - r1 - r2,4)*vQQg(i93,a91,i3,93,mu91,3)*vQQg(i4,a97,i1,4,mu97,1
      )*vQQV(i2,i99,2,mu95,99);

id diag6 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i1,i2,1,p1 + r2,2)*pQuark(
      i3,i4,3, - p2 - r1,4)*vQQg(i93,a97,i3,93,mu97,3)*vQQg(i2,a91,i99,2,mu91,
      99)*vQQV(i4,i1,4,mu95,1);

id diag7 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i1,i2,1,p1 + r2,2)*pQuark(
      i3,i4,3, - q - r1,4)*vQQg(i2,a91,i99,2,mu91,99)*vQQg(i4,a97,i1,4,mu97,1)
      *vQQV(i93,i3,93,mu95,3);

id diag8 = pol(V(mu95,q))*pol(gluon(mu97,p2,a97))*pol(gluon(mu91,r2,a91))*pol(
      Quark(99,p1,i99))*pol(Qbar(93,r1,i93))*pQuark(i3,i4,3, - q - r1,4)*
      pgluon(a1,a2,mu1,mu2, - p2 - r2)*vQQg(i4,a2,i99,4,mu2,99)*vQQV(i93,i3,93
      ,mu95,3)*vggg(a97,a91,a1,mu97,mu91,mu1,p2,r2, - p2 - r2);

