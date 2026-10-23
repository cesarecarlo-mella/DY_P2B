# Plan: RV (NNLO) and RVV (N3LO)

Status 2026-10-23: RV done to step 06 (Code_RV); RVV 1x1 = Code_RVV_1L1L (production on newton4, reduction with
Reduze); RVV 2x0 = Code_RVV_2L (prototype tested on Vqqbg, to be added to the repo). Details in section 5.

## 0. Kinematics: the phase space collapses

One emission r1. The cuts r1^2 = 0, (p1+p2-r1)^2 = m2 = z s and the rapidity constraint q.p1 = u q.p2 fix r1:

    2 r1.p1 = s (1 - u z)/(1 + u),    2 r1.p2 = s (u - z)/(1 + u)

(physical momenta). Every invariant is a function of (s, z, u); only the trivial transverse angle is left. The
phase-space "integral" is a Jacobian J(z, u, eps) (factors like [(1-uz)(u-z)]^(-eps)), and the loop integrals are
ordinary one- and two-loop 2 -> 2 integrals with one massive leg, evaluated at the point (z, u).

**Decision: the loop integrals are handled separately from the phase space.** RV/RVV families are loop-only (no cut
propagators). Step 05 substitutes the kinematics; the Prop(cut, ...) and Den(cut, ...) become the Jacobian. Kira
reduces in the loop momenta only, at fixed s, t, m2.

Caveat (boundaries z -> 1 soft, u -> z and u -> 1/z collinear): the result is a distribution in z and u. Each master
behaves as (boundary)^(-a eps) x regular near a boundary: keep the exponents exactly before expanding; the delta
terms of the plus-distribution expansion need one order higher in eps at the boundary (soft current, splitting
amplitudes, exact in eps).

## 1. Products and complex conjugation

| product | amplitude | conjugate | cross section |
|---|---|---|---|
| RV (NNLO) | one loop (set 1) | tree (set 0) | 2 Re(A1 A0*) |
| RVV 2x0 | two loops (set 2) | tree (set 0) | 2 Re(A2 A0*) |
| RVV 1x1 | one loop (set 1, k1) | one loop (set 1, k2) | A1 A1* |

- 1x1: the conjugate's loop integrals are complex conjugated (-i0). No tag is needed: the conjugate's loop momentum
  is k2 (step 03: k1 -> k2), the families are box(k1) x box(k2) x (k1+k2)^2, and the reduction (Reduze, sector
  relations and symmetries off, notes oneloop_squared.tex) gives ordered products M_a(k1) M_b(k2); at the insertion
  every master becomes ML1(M_a) ML1C(M_b), ML1C = complex conjugate. Step 03 also flips the explicit i_ and eps.
- 1x1 pairs (i, j) and (j, i) are complex conjugates (checked: X_ji = X_ij^* for all partner pieces); all pairs are
  computed (the check needs both), X_ij + X_ji = 2 Re X_ij.
- RV, RVV 2x0 (and RRV): the pipeline computes A_L A0* only; take 2 Re after the masters are evaluated (explicit i's
  and imaginary parts of the masters both contribute).
- The two RVV products are kept apart: two Code folders, Code_RVV_1L1L and Code_RVV_2L.

## 2. Code

1. `Code_RV`: Code_R channels (one emission) with the RRV two-set plumbing (set 1 x set 0), closed-loop handling of
   Code_RRV (spinlines.h block, Quark2 filter, SpinL in step 04, PS pieces), step 05 with the kinematic substitution
   and loop-only families.
2. `Code_RVV_1L1L` (product 1x1): one-loop set only; step 03 conjugates it (k1 -> k2, closed-loop trace reversed,
   gvPS, gaPS -> cgvPS, cgaPS); step 04 with the conjugate's closed loop as trace 4; 40 pieces (v, a, v2, a2, vPS,
   aPS on both sides + 4 X). Channels: q qb g and crossings (6) and the loop-induced g g -> V g (Vggg) with its 6
   ghost channels (gluon polarisation sums; ghost |M|^2 subtracted at assembly). spinlines.h unchanged.
3. `Code_RVV_2L` (product 2x0): two-loop set (QGRAF loops = 2, set label 2) x tree; q qb g channels only (g g -> V g
   has no tree; 2L x 1L of g g -> V g is N4LO). spinlines.h change (approved 2026-10-23): up to two closed quark loops
   (Spin(3), Spin(4); e.g. a quark bubble on the s-channel gluon of the V-g-g triangle), Nf per closed loop without V.
   Per two-loop diagram, family and loop-momentum shift from Reduze find_diagram_shifts, applied in step 01 with the
   tag L2F(f).

## 3. Families (loop-only)

- RV: one-loop box with legs p1, p2, r1, q (3 orderings), propagators of k1.
- RVV 1x1: box A in k1 x box B in k2 x (k1+k2)^2 (9 families topo1..9 = rvvAB); k1.k2 is removed by the reduction
  (Lorentz covariance), the masters are products of one-loop masters (needed to higher order in eps).
- RVV 2x0: two-loop four-point, one off-shell leg, families PL and NPL of Hjet2L (Code/Scripts/Templates/common.py)
  and their 6 crossings of p1, p2, r1 (12 families, 10 used); masters: Hjet2L ancillary files (canonical basis,
  solutions to weight 6).
- Reference: H_P2B/nnlo_setup/RV (Higgs NNLO RV families), H_P2B/nnlo_setup/VV.

## 4. Masters, renormalisation

- Kira at fixed kinematics (two scales); masters from differential equations in (z, u) with exact boundary exponents,
  or from the literature with their boundary expansions.
- Two-loop UV, Larin Z5 and Z_a^ns at O(a^2); Z_s differs from Z_ns from O(a^2) (D3 b remainder, see RRV_plan.md).

## 5. Status (2026-10-23)

- RV (Code_RV): steps qgraf..06, families and matching done (6 channels); vPSv = vPSa = 0 (Furry: two gluons on the
  loop), aPSa, aPSv non-zero. Reduction and masters not done.
- RVV 1x1 (Code_RVV_1L1L): 6 q qb g channels run on newton4 (0 failed); 11441 integrals in 9 families (s <= 4, no
  dots). Checks on Vqqbg: conjugation X_ji = X_ij^*, Furry (all vPS pieces with two gluons on the loop vanish),
  Reduze reduction = Gram projection as ordered products (notes oneloop_squared.tex). Reduction: RVV_reductions/
  (Reduze per family, no symmetries), tables and insertion (to_form.py, tools/insert_reductions.py) tested on Vqqbg
  aPSaPS. g g -> V g channels tested (Vggg: vPSvPS and aPSaPS non-zero, mixed pieces zero, d^abc f^abc = 0; ghost
  channel: only aPSaPS); not yet in the repo.
- RVV 2x0 (Code_RVV_2L, prototype): Vqqbg 229 two-loop diagrams (300 before the Quark2 filter, 4 zero by colour),
  Reduze matches 300/300 checked independently; step 04 23 pairs (157 CPU min); step 05 checked numerically against
  step 04 (check05). Vector PS pieces do not vanish pair by pair: V on a closed loop with three gluons (box) survives
  with d^abc, the triangle parts cancel only after the reduction.
- RRV (for comparison, RRV_plan.md): there the vector PS piece does NOT vanish either: the box (V + 3 gluons on the
  loop) survives with d^abc d^abc (summed vPSv = 0 only at Nc = 2).

## 6. Order of work

1. RV, validated against the known NNLO DY rapidity distribution (Anastasiou-Dixon-Melnikov-Petriello, hep-ph/0312266).
2. RVV 1x1 (one-loop masters only).
3. RVV 2x0.
