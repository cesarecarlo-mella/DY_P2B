# Code notes: how the pipeline handles couplings, gamma5 and the pieces of assembly.pdf

Internal notes (not physics). Physics: `Larin.pdf` (when aa = vv), `assembly.pdf` (all contributions + counterterms).

## Coupling labels and pieces

- `FORMroutines/spinlines.h`: V vertex `gv`, `ga` on **flavour-1** lines (`Quark`), `Gv`, `Ga` on **flavour-2** lines
  (`Quark2`); the conjugate carries `cgv`, `cga`, `cGv`, `cGa`. Labels are by **flavour**, not by line (see below).
- Step 04 (`4_square_ampl.frm`) splits into pieces, name = amplitude coupling + conjugate coupling:
  `vv` = v v*, `va` = v a*, `vv2` = v v2*, `aa2` = a a2*, `v2v` = v2 v*, ... (same order as `assembly.pdf`,
  amplitude first).

Labels (one letter group per side; the conjugate's coupling has a `c` in front):

| label | amplitude | conjugate | V vertex on | coupling |
|---|---|---|---|---|
| `v`, `a` | `gv(ti)`, `ga(ti)` | `cgv(tj)`, `cga(tj)` | a flavour-1 open line (q) | v_q, a_q |
| `v2`, `a2` | `Gv(ti)`, `Ga(ti)` | `cGv(tj)`, `cGa(tj)` | a flavour-2 open line (Q) | v_Q, a_Q |
| `vPS`, `aPS` | `gvPS(ti)`, `gaPS(ti)` | `cgvPS(tj)`, `cgaPS(tj)` | a closed quark loop | sum_f v_f, sum_f a_f |

Trace classes (where the two V vertices of the cut diagram end up; `Larin.pdf` for the physics):

| class | V vertices of amplitude and conjugate | gamma5 | pieces | code |
|---|---|---|---|---|
| S (same trace) | in one trace (same open line; also identical-quark direct x exchange) | aa = vv (anticommuting) | `vv`, `va`, `av`, `aa`, `v2v2`, `a2a2`, ... | no tag; `SKIPAA=1` writes `aa`, `a2a2` = 0 |
| X (crossed: two traces) | on different traces, one gamma5 each | Larin | `vvX`, `vaX`, `avX`, `aaX` (flavour 1, identical quarks: tag `trX`); `vv2`, `aa2`, `v2v`, `a2a`, ... (different flavours: always two traces) | `trX` from `Vline`/`cVline` |
| P (pure singlet) | at least one on a closed quark loop | Larin | `vPS*`, `aPS*` on either side | couplings `gvPS`, `gaPS` (`cgvPS`, `cgaPS`) |

Pieces per product (all with the projector L1 when both couplings are vector or both axial, L6 otherwise):
- tree x tree (LO, R, RR, RRR): 16 (`v a v2 a2` x `v a v2 a2`) + 4 X;
- loop x tree (RV, RRV, RVV 2L x tree): 16 + 4 X + 8 PS (`vPS`/`aPS` x `v a v2 a2`);
- 1L x 1L (Code_RVV_1L1L): 36 (`v a v2 a2 vPS aPS` on both sides) + 4 X, e.g. `vvPS`, `aPSaPS`.
- Projectors (step 05, `05_run_contractPj.py`): `L1.inc` = q^mu q^nu - q^2 g^{mu nu} for the parity-even pieces
  (vv, aa, vv2, aa2, v2v, a2a, v2v2, a2a2), `L6.inc` (epsilon) for the parity-odd ones (va, av, va2, av2, v2a, a2v,
  v2a2, a2v2).
- Larin vertex: `spinlines.h`, `GA(ti)*eps(nu1,rho1,rho2,rho3)/6*Spin(LINE,rho1,rho2,rho3,...)`; all axial vertices
  are Larin in the code (the choice "aa = vv" is applied by not computing aa).
- `SKIPAA` (default 1): the class-S `aa` and `a2a2` are written as 0 (to be taken = vv, v2v2 at assembly). The X and
  P pieces and all parity-odd pieces are always computed with Larin. `SKIPAA=0` computes `aa`, `a2a2` too (expensive
  in RRR). Full Larin (under discussion, 2026-10-23) = `SKIPAA=0` everywhere: an addition (the other pieces do not
  change), but step 04 computes all pieces of a pair in one job (an `ONLYAA` option could skip the others), the aa
  pieces may add integrals to the reduction lists, and at assembly aa_S needs Z5^ns Z_MS^ns instead of aa_S = vv.
- Loops: the code computes conjugate(lower) x higher per piece; assembly takes 2Re. For 1L x 1L all ordered pairs
  (i, j) of diagram groups are computed; (j, i) is the complex conjugate of (i, j) (checked: X_ji[Q] = X_ij[P]^* with
  Q = P mirrored, `Code_RVV_1L1L/README.md`).

## Closed quark loops in the code

- `spinlines.h` walks the open lines, then the closed quark loops: trace `Spin(3,...)`, and in `Code_RVV_2L` also
  `Spin(4,...)` (two closed loops at two loops: a quark bubble on the s-channel gluon of the V-g-g triangle, e.g.
  Vqqbg QGRAF diagrams 134, 138). Each loop: factor Nf if V is not on it (`Vline(L)` absent), couplings `gvPS`,
  `gaPS` and `Vline(L)` if V is on it. Diagrams with a closed `Quark2` loop are dropped after QGRAF
  (`Scripts/tools/drop_quark2_loops.py`): the closed `Quark` loop stands for any light flavour.
- Step 04: the closed loops go into commuting holders while the open lines are combined (`SpinL` -> trace 3,
  `SpinL4` -> trace 4 in 2L x tree; in 1L x 1L the conjugate's loop `SpinC(3, reversed)` -> `SpinLC` -> trace 4).
- 1L x 1L conjugation (step 03): k1 -> k2, `Spin(3, x1..xn)` -> `SpinC(3, xn..x1)` (trace of the reversed product),
  `gvPS`, `gaPS` -> `cgvPS`, `cgaPS`; the Larin eps changes sign with i_.
- 2L x tree (`Code_RVV_2L`, in progress): every two-loop diagram gets its loop-momentum shift onto a family (PL, NPL
  and crossings, Reduze `find_diagram_shifts`) and the tag `L2F(f)` in step 01 (`Families/rvv2l_shifts.py`).

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

## Identical-quark channels: trace tag (done 2026-10-21, all four Code folders)

Step 04 tags the terms with the two V vertices in different traces (`trX`): amplitude line i, conjugate line j != i,
two traces. New pieces vvX, vaX, avX, aaX (flavour-1 couplings, class X, Larin); vv, va, av, aa are then the
same-trace parts (class S; the direct x exchange interference is always one trace, so it is S). SKIPAA zeroes only
the S part of aa (aa_S = vv_S). Markers: Vline(LINE) in spinlines.h, cVline in step 03. For q != Q channels the X
pieces are 0 and the 16 old pieces are unchanged. Checks: new S + X = old (RR Vqqbqqb, RRR Vqqbqqbg pair 1_1, exact);
S: aa - vv = 0 at d = 4, != 0 in d; X: aa - vv != 0 at d = 4; LO and R outputs byte-identical.

## (Former) open issue: identical-quark channels

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
