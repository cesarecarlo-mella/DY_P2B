#procedure coloralgebra

id f(a1?,a2?,a3?)*f(a4?,a2?,a3?) = Nc*d_(a1,a4);
id T(a1?,i1?,i2?)*T(a2?,i2?,i1?) = d_(a1,a2)/2;
id T(a1?,i1?,i2?)*T(a2?,i2?,i1?)*f(a1?,a2?,a3?) = 0;


#do ii=1,100,10
id once f(b1?,b2?,b3?) = -2*i_*(   T(b1,j'ii',j{'ii'+1})*T(b2,j{'ii'+1},j{'ii'+2})*T(b3,j{'ii'+2},j'ii')
                                 - T(b1,j'ii',j{'ii'+1})*T(b3,j{'ii'+1},j{'ii'+2})*T(b2,j{'ii'+2},j'ii') );

#enddo

.sort

id T(b1?,j1?,j2?)*T(b1?,j3?,j4?) = 1/2*(d_(j1,j4)*d_(j3,j2) - d_(j1,j2)*d_(j3,j4)/Nc);

id T(a1?, j1?, j1?) = 0;

.sort

*Trade back T's for f's for the 3g amps
id T(a1?,i1?,i2?)*T(a2?,i2?,i1?) = d_(a1,a2)/2;
id T(a1?,i1?,i2?)*T(a2?,i2?,i3?)*T(a3?,i3?,i1?) = 1/4*(i_*f(a1,a2,a3)+s(a1,a2,a3));
id T(a1?,i1?,i2?)*T(a2?,i2?,i3?)*T(a3?,i3?,i4?)*T(a4?,i4?,i1?) = 
1/4/Nc *d_(a1,a2)*d_(a3,a4) + 1/8*(i_*f(a1,a2,a200)+s(a1,a2,a200))*(i_*f(a3,a4,a200)+s(a3,a4,a200));
#endprocedure
