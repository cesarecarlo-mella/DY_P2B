#!/usr/bin/env python3
"""Independent check of Phi_n(z,u) (phase_space.pdf) in the partonic rest frame, absolute normalisation.

    python3 rest_frame.py > rest_frame.log        (pure Python, a few seconds per point)

Phi_n = int dM^2 Phi_2(P -> Q + K) Phi_n^massless(M^2) delta(Q.p1 - u Q.p2), with K^2 = M^2 and, in d = 4 - 2 eps,
  Phi_2 = Omega_{d-2} p^{d-3}/(4 sqrt(s)) int dc (1-c^2)^(-eps)     (c = cos of the angle of Q to p1)
  Phi_n^massless(M^2) = pi^((n-1)(1-eps)) Gamma(1-eps)^n / (2^(n-1) Gamma((n-1)(1-eps)) Gamma(n(1-eps))) (M^2)^(n-2-(n-1)eps)
  delta(Q.p1 - u Q.p2) = delta(c - c_u) |dc/du| / Q.p2.
This is a different route from the light-cone derivation of the pdf (no a, Q_T variables); compared with the closed form.
"""
import math


def hyp2f1(a, b, c, x, terms=400):
    """Gauss series, |x| < 1 (here x >= 0 small or moderate; for x > 0.9 use a transformation -- not needed below)"""
    s, t = 1.0, 1.0
    for m in range(terms):
        t *= (a + m) * (b + m) / ((c + m) * (m + 1)) * x
        s += t
        if abs(t) < 1e-17 * abs(s):
            break
    return s


def closed(n, e, s, z, u):
    """the closed form of the pdf, eq. (main)"""
    G = math.gamma
    cn = math.pi ** (n * (1 - e)) * G(1 - e) ** n / (2 ** (n - 1) * G(n * (1 - e)) ** 2)
    a0, a1 = math.sqrt(z / u), (1 + z) / (1 + u)
    w, x = (1 + u) * (a1 - a0), (a1 - a0) / (2 * a0)
    gn = (1 + x) ** e * hyp2f1(e, 1 - e, n - n * e, -x)
    return (cn * s ** (n - 2 - n * e) * w ** ((n - 1) * (1 - e)) / (1 + u)
            * ((u - z) * (1 - u * z) / (1 + u) ** 2) ** (-e) * gn)


def rest(n, e, s, z, u, steps=400000):
    G = math.gamma
    m2 = z * s
    rs = math.sqrt(s)
    omega = 2 * math.pi ** (1 - e) / G(1 - e)                       # Omega_{d-2}
    cmass = math.pi ** ((n - 1) * (1 - e)) * G(1 - e) ** n / (2 ** (n - 1) * G((n - 1) * (1 - e)) * G(n * (1 - e)))
    # c(M2) = +-1 at E = sqrt(m2)(1+u)/(2 sqrt(u)): the end of the M2 range for this u
    hi = s + m2 - 2 * rs * math.sqrt(m2) * (1 + u) / (2 * math.sqrt(u))
    tot = 0.0
    for i in range(steps):
        t = (i + 0.5) / steps
        M2 = hi * t * t * (3 - 2 * t)                                # smooth at both ends (M2 -> 0, |c| -> 1)
        dM2 = hi * 6 * t * (1 - t) / steps
        E = (s + m2 - M2) / (2 * rs)
        p = math.sqrt(max(E * E - m2, 0.0))
        c = E * (1 - u) / (p * (1 + u))                              # Q.p1/Q.p2 = (E - p c)/(E + p c) = u
        if abs(c) >= 1:
            continue
        jac = (E + p * c) ** 2 / (2 * p * E)                         # |dc/du|
        qp2 = rs / 2 * (E + p * c)
        tot += (dM2 * omega * p ** (1 - 2 * e) / (4 * rs) * (1 - c * c) ** (-e) * jac / qp2
                * cmass * M2 ** (n - 2 - (n - 1) * e))
    return tot


if __name__ == "__main__":
    print("n  eps    s     z      u      rest frame          closed form         rel. diff")
    for n in (2, 3):
        for e in (0.0, 0.3, -0.2):
            for s, z, u in ((1.0, 0.2, 0.7), (3.0, 1 / 3, 2.0), (1.0, 0.05, 0.3)):
                r, c = rest(n, e, s, z, u), closed(n, e, s, z, u)
                print(f"{n}  {e:+.1f}  {s:.1f}  {z:.3f}  {u:.3f}  {r:.12e}  {c:.12e}  {r / c - 1:+.1e}", flush=True)
