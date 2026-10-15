# Phase space at fixed rapidity (NLO, NNLO, N3LO)

`phase_space.pdf` (source `phase_space.tex`): the integral with only the cut propagators,
Phi_n(z,u) = int prod d^dk_i delta+(k_i^2) delta+(Q^2-m2) delta(Q.p1 - u Q.p2), for n = 1, 2, 3 real partons, in closed
form (one 2F1), derived step by step; eps expansion, soft limit, comparison with nnlo_rr/integrals/IF1/boundaries.nb.
For the triple real it is INT(topoN,1,1,1,1,1,0,...,0), the same for every family.

Checks (light, seconds to a minute):
```
cd checks
wolframscript -file checks.wl > checks.log     # closed form, eps expansion, NNLO soft master, notebook formula, symmetry
python3 rest_frame.py > rest_frame.log          # independent rest-frame derivation, absolute normalisation
wolframscript -file notebook_integrand.wl > notebook_integrand.log   # the NNLO notebook INTEGRAND, both deltas
wolframscript -file admp.wl > admp.log          # hep-ph/0312266 eq. (3.8) (ADMP I[0]) = our Phi_2
```
Build: `pdflatex phase_space.tex` (twice, for the table of contents).
