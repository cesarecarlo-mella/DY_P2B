****************************************************************************************
* Spin lines, generic for every PROC.
*
* In QGRAF all legs are incoming, so every open quark line runs from an external
* Qbar-type field to an external Quark-type field. External legs (after parser.h):
* 99 = p1, 97 = p2 (initial), 93 = r1, 91 = r2, 89 = r3 (final).
*
* Line numbering:
*   line 1 = first flavour-1 Qbar leg in the order 99,97,93,91,89
*   line 2 = next flavour-1 Qbar leg, otherwise the Qbar2 leg
* Couplings to V: gv, ga on flavour-1 lines, Gv, Ga on flavour-2 lines.
*
* Spin(k, p_Quark, ..., p_Qbar): Lorentz indices and momenta in order along the line.
* Initial-state pol(...) of the end points are dropped (spin sum = momentum in the chain);
* final-state ones are kept: they mark the cut legs, pol*pol(Cut...) = Prop(cut,v) in feynman_rules.h.
****************************************************************************************

#do LINE = 1,2
#do F = 1,2

#if 'F' == 1
#define QB "Qbar"
#define QQ "Quark"
#define GV "gv"
#define GA "ga"
#else
#define QB "Qbar2"
#define QQ "Quark2"
#define GV "Gv"
#define GA "Ga"
#endif

* start: first 'QB' leg, if line 'LINE' is not started yet
#do n = {99,97,93,91,89}
if ( match(Spin('LINE',?a)) == 0 );
#if 'n' >= 97
  id pol('QB'('n',mom1?,i'n')) = Search('n')*Spin('LINE',mom1);
#else
  id pol('QB'('n',mom1?,i'n')) = Search('n')*Spin('LINE',mom1)*'QB'('n',mom1);
#endif
endif;
#enddo

* walk along the line
repeat;
id Search(n1?)*vQQg(mu1?,n1?,n2?)*Spin('LINE',?x2) = Save(vQQg(mu1,n1,n2))*Search(n2)*Spin('LINE',mu1,?x2);
id Search(n1?)*vQQV(n1?,nu1?,n2?)*Spin('LINE',?z2) = Save(vQQV(n1,nu1,n2))*Search(n2)
   *('GV'(ti)*Spin('LINE',nu1,?z2) + 'GA'(ti)*eps(nu1,rho1,rho2,rho3)/6*Spin('LINE',rho1,rho2,rho3,?z2));
id Search(n1?)*pQuark(n1?,mom1?,n2?)*Spin('LINE',?x2) = Save(pQuark(n1,mom1,n2))*Search(n2)*Spin('LINE',mom1,?x2);
endrepeat;

* close on the 'QQ' leg
#do n = {99,97,93,91,89}
#if 'n' >= 97
id Search('n')*pol('QQ'('n',mom1?,i'n'))*Spin('LINE',?z2) = Spin('LINE',mom1,?z2);
#else
id Search('n')*pol('QQ'('n',mom1?,i'n'))*Spin('LINE',?z2) = Spin('LINE',mom1,?z2)*'QQ'('n',mom1);
#endif
#enddo
.sort

#enddo
#enddo

#message spinlines done

* every quark vertex must be on a closed line
if ( count(Search,1,vQQg,1,vQQV,1) > 0 ) exit "spinlines.h: open spin line";

id Save(pQuark(?x)) = pQuark(?x);
id Save(?x) = 1;

* restore final-state pol(...): marks the cut legs
#do n = {93,91,89}
id Qbar('n',mom1?)   = pol(Qbar('n',mom1,i'n'));
id Quark('n',mom1?)  = pol(Quark('n',mom1,i'n'));
id Qbar2('n',mom1?)  = pol(Qbar2('n',mom1,i'n'));
id Quark2('n',mom1?) = pol(Quark2('n',mom1,i'n'));
#enddo
.sort
