# Code notes: how the pipeline handles couplings, gamma5 and the pieces of assembly.pdf

Internal notes (not physics). Physics: `Larin.pdf` (when aa = vv), `assembly.pdf` (all contributions + counterterms).

## Coupling labels and pieces

- `FORMroutines/spinlines.h`: V vertex `gv`, `ga` on **flavour-1** lines (`Quark`), `Gv`, `Ga` on **flavour-2** lines
  (`Quark2`); the conjugate carries `cgv`, `cga`, `cGv`, `cGa`. Labels are by **flavour**, not by line (see below).
- Step 04 (`4_square_ampl.frm`) splits into 16 pieces, name = amplitude coupling + conjugate coupling:
  `vv` = v v*, `va` = v a*, `vv2` = v v2*, `aa2` = a a2*, `v2v` = v2 v*, ... (same order as `assembly.pdf`,
  amplitude first).
- Projectors (step 05, `05_run_contractPj.py`): `L1.inc` = q^mu q^nu - q^2 g^{mu nu} for the parity-even pieces
  (vv, aa, vv2, aa2, v2v, a2a, v2v2, a2a2), `L6.inc` (epsilon) for the parity-odd ones (va, av, va2, av2, v2a, a2v,
  v2a2, a2v2).
- Larin vertex: `spinlines.h`, `GA(ti)*eps(nu1,rho1,rho2,rho3)/6*Spin(LINE,rho1,rho2,rho3,...)`; all axial vertices
  are Larin in the code (the choice "aa = vv" is applied by not computing aa).
- `SKIPAA` (default 1): aa and a2a2 are written as 0 (to be taken = vv, v2v2 at assembly). aa2, a2a (cross-line) and
  all parity-odd pieces are always computed with Larin. `SKIPAA=0` computes aa, a2a2 too (expensive in RRR).
- Loops (future RV, RRV, RVV runs): the code computes conjugate(lower) x higher per piece; assembly takes 2Re. For
  1L x 1L all ordered pairs are needed (sum is real). V on a closed quark loop (PS) needs its own labels (e.g.
  `gvL`, `gaL`, coupling sum_f v_f, sum_f a_f), like `Gv`/`Ga` for the second line.

## What to compute, contribution by contribution (minimal set)

Piece name = amplitude label (with its loop order) x conjugate label, as in the code (`va` = v a*). (L) = Larin.

Rules:
1. Same line, parity even: only `vv` (aa = vv, also at loop level).
2. Tree x tree and 1L x 1L: one piece per mirror pair (X Y* = (Y X*)*, real) -> take 2Re.
3. Loop x tree: every ordered pair (loop label, tree label) is a different piece: `va` = v^(1) a^(0)* and
   `av` = a^(1) v^(0)* are both needed (different loop amplitude, different Z).
4. PS labels (vPS, aPS) appear only in loop amplitudes: on the amplitude side of loop x tree, on both sides of 1L x 1L.
5. Counterterms reuse the lower pieces of the same pair, in the same scheme; one extra Larin tree piece: `aa` (L) of
   the one-line channels (B, R) for the z_s term of VV, RVV (a_q sum a_f).

| contribution | parity even (L1) | parity odd (L6), all (L) |
|---|---|---|
| tree, one line (B, R, RR, RRR) | vv | va |
| tree, two lines (RR, RRR) | vv, v2v2, vv2, aa2 (L) | va, v2a2, va2, av2 |
| 1L x tree, one line (V, RV, RRV) | vv; vPS.v (RRV only), aPS.a (L) | va, av; aPS.v, vPS.a (RRV only) |
| 1L x tree, two lines (RRV) | vv, v2v2, vv2, v2v, aa2 (L), a2a (L); aPS.a, aPS.a2 (L) | va, av, v2a2, a2v2, va2, a2v, av2, v2a; aPS.v, aPS.v2 |
| 2L x tree, one line (VV, RVV) | vv; vPS.v (RVV only), aPS.a (L) | va, av; aPS.v, vPS.a (RVV only) |
| 1L x 1L, one line (VV, RVV) | vv; aPS.a (L), aPS.aPS (L) | va; aPS.v |
| 1L x 1L, gg -> Vg | vPS.vPS, aPS.aPS (L) | none (d^abc f^abc = 0) |
| Larin trees for counterterms | aa (L) one line, for B and R | (already in the list) |

(xPS.y = PS loop amplitude x conjugate tree/loop on line y. Vector PS with two gluons on the loop vanishes (Furry),
so vPS.* is absent for V, RV, VV and four-quark RRV.) Identical quarks: same as two lines once couplings are per line.

## Mirror pieces are redundant at tree level

X Y* and Y X* are complex conjugates; at tree level (no absorptive parts) and after L1/L6 the coefficient is real, so
they are equal. Checked INT by INT, exactly in d (2026-10-20): Code_R Vqqbg, Vqgq va = av; Code_RR VqQ2qQ2
va = av, vv2 = v2v, aa2 = a2a, va2 = a2v, av2 = v2a, v2a2 = a2v2. So at tree level (LO, R, RR, RRR) only
vv, va, v2v2, v2a2, vv2, aa2, va2, av2 are needed (8 of the 14 computed), the others are 2 x their mirror.
Not done yet in step 04/05 (they are still all computed). At loop level v^(1) a^(0)* and a^(1) v^(0)* are NOT
mirrors (different loop amplitude, different Z): both needed; the 2Re supplies a^(0) v^(1)* etc.

## Open issue: identical-quark channels

- In q qb -> V q qb (Code_RR `physical_qqbqqb`, Code_RRR `physical_qqbqqbg`) both lines are flavour 1, so the `aa`
  piece contains same-line AND cross-line products (and the exchange interference). aa = vv is wrong there.
- RRR production (`Code_RRR/integrals/quarks/sources.txt`): the 8 `physical_qqbqqbg` channels have only vv, va, av;
  the 14 `physical_qqbQ2Q2bg` channels have all 14 pieces (aa2, a2a included); one-line channels vv, va, av (fine).
- The missing aa pieces may bring integrals not yet in the Kira lists of these families.
- These channels were run with `SKIPAA=1`, including the RRR quark production on newton1: their aa is missing.
- Fix (proposed, not done): label the V coupling by **line** (e.g. by the external quark the line starts from)
  instead of by flavour, so same-line products go to `vv` (aa = vv) and cross-line ones to separate pieces computed
  with Larin (like `aa2`). Alternative: `SKIPAA=0` for these channels (then the same-line part is Larin).

## Larin lower-order pieces needed as counterterms (assembly.pdf, "Reading the tables")

Computed even though the lower order itself uses aa = vv:
- RR: a a2*, a2 a* (L) for RRV a_q a_Q -- already computed (aa2, a2a).
- R: a a* (L) for RVV a_q sum a_f (z_s term) -- needs `SKIPAA=0` on Code_R (cheap; done 2026-10-19 for Vqqbg, Vqgq).
- B: a a* (L) for VV a_q sum a_f -- `SKIPAA=0` on Code_LO (cheap; done).
- RV: a_PS^(1) a^(0)* (L) for RVV.
- All parity-odd pieces (Larin anyway).

## Ghosts

Ghost channels give +|M_ghost|^2 (QGRAF's (-1) per diagram squares away; `feynman_rules.h`: sign NOT included).
Subtract by hand at assembly: final-state ghost pair (e.g. Vqqbccb) -> subtract it and its r1 <-> r2 image;
initial-state ghost leg -> both orientations are separate channels (e.g. Vqcqc, Vqcbqcb), subtract each once.

## Notebook `../renormalization.nb`

- PS amplitudes are multiplied by the same `ga`/`gv` as NS; `cga ga -> 0, cgv gv -> vvPaa` then treats PS as aa = vv
  (wrong for PS): give PS its own couplings (sum_f v_f, sum_f a_f).
- Four-quark RRV needs per-line couplings.
- `Coefficient[lo, ...]` with `lo` undefined in two cells; RR chapter collects on `AR[...]` instead of `ARR[...]`;
  some `Print` labels say NNLO for N3LO.

## Checks (`checks/`)

Larin outputs exact in d (`SKIPAA=0`), compared INT by INT at z = 3/17, u = 5/7, Nc = 3 (`checks/aa_vs_vv.wl`,
log `checks/checks.log`):

| channel | comparison | INTs | != 0 at d=4 | != 0 in d |
|---|---|---|---|---|
| Born (Code_LO Vqqb) | aa/vv = (1-2eps)(1-2eps^2/3) (`lo_ratio.wl`) | 1 | 0 | 1 |
| VqQ2qQ2 (Code_RR) | aa vs vv (same line) | 86 | 0 | 86 |
| | a2a2 vs v2v2 (same line) | 81 | 0 | 81 |
| | aa2 vs vv2 (cross-line) | 377 | 347 | 377 |
| q qb -> V q qb (scratch copy, identical quarks) | aa vs vv (mixed) | 1022 | 332 | 1012 |

Furry test (`checks/furry_swap.sh`, log `checks/furry_swap.log`, 2026-10-20): RR q qb -> V Q Qb (VqqbQ2Q2b) step-04
pieces x L1 at a rational point, exact in d: vv, v2v2, aa2, a2a symmetric under r1 <-> r2; vv2 antisymmetric ->
vv2 integrates to 0 (cut Q loop with three vector vertices), aa2 does not (a_q a_Q, cancels in sum_Q a_Q except b).

INTs are not reduced: "0 different" proves equality, "different" is strong evidence, not proof.
Run from the repo root: `bash notes_Larin/checks/run_checks.sh [unreduced folder of an identical-quark channel]`;
needs Code_LO Vqqb and Code_RR VqQ2qQ2 step-06 outputs with `SKIPAA=0` (not in git).
