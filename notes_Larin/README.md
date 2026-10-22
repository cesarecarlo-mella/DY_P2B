# notes_Larin: gamma5, Larin's scheme, assembly of all contributions

- `assembly.pdf` (`assembly.tex`): how to assemble every contribution up to N3LO (B, R, V, RR, RV, VV, RRR, RRV,
  RVV 2Lx0L and 1Lx1L, gg -> Vg), per coupling piece (same line, cross-line, PS = pure singlet), parity-even (L1) and
  parity-odd (L6) tables, with the UV counterterms written explicitly (beta0, beta1, Larin Z_a^ns, Z_s).
- `Larin.pdf` (`Larin.tex`): why aa = vv on the same open quark line and not otherwise; Larin's prescription and
  constants; pure singlet.
- `oneloop_squared.pdf` (`oneloop_squared.tex`): one loop x one loop (RVV 1x1): factorisable two-loop families
  (12 propagators), why the k1.k2 numerators reduce to products of one-loop integrals (Lorentz covariance = IBP),
  complex conjugation of the k2 factor, no k1 <-> k2 symmetries.
- `RRV_plan.md`: plan for RRV and what RR needs (classes by trace: S, X, P; tags; decisions).
- `RVV_plan.md`: plan for RV (NNLO) and RVV (2x0, 1x1): collapsed single-emission phase space, loop-only
  families, complex conjugation of the loop integrals in 1x1, 2 Re for the interferences.
- `code_notes.md`: how the code handles all this (coupling labels, SKIPAA, projectors, identical-quark issue, Larin
  lower-order pieces needed, ghost sign, notebook issues, checks).
- `checks/`: scripts and log of the aa vs vv checks (see `code_notes.md`).

Build: `latexmk -pdf assembly.tex Larin.tex oneloop_squared.tex`.
