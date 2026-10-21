# Plan: RV (NNLO) and RVV (N3LO)

Status 2026-10-21: plan only, no code yet. RRV production (step 04, all channels) running on newton4.

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

- 1x1: the conjugate's loop integrals are complex conjugated (-i0): conjugate-side integrals tagged (e.g. INTC), and
  after the reduction each master -> M*. Step 03 already flips the explicit i_ and eps; this is on top of it.
- 1x1 pairs (i, j) and (j, i) are complex conjugates: compute i <= j, X_ij + X_ji = 2 Re X_ij.
- RV, RVV 2x0 (and RRV): the pipeline computes A_L A0* only; take 2 Re after the masters are evaluated (explicit i's
  and imaginary parts of the masters both contribute).
- The two RVV products are kept apart: own pair lists, run states and output folders (e.g. squared_diagrams/p20/,
  squared_diagrams/p11/).

## 2. Code

1. `Code_RV`: Code_R channels (one emission) with the RRV two-set plumbing (set 1 x set 0), closed-loop handling of
   Code_RRV (spinlines.h block, Quark2 filter, SpinL in step 04, PS pieces), step 05 with the kinematic substitution
   and loop-only families.
2. `Code_RVV`: products 2x0 and 1x1.
   - QGRAF loops = 2 set; conjugate of set 1 in step 03 with k1 -> k2 and the integral tag.
   - spinlines.h (changes to be approved): up to two closed quark loops (Spin(3), Spin(4)), each through SpinL in
     step 04; Nf, Nf^2; diagrams with any closed Quark2 loop dropped.
   - Classes: V on a closed loop in the amplitude, in the conjugate, in both (PS x PS in 1x1: (sum v_f)^2, (sum a_f)^2);
     at two loops V on a closed loop with an extra gluon, light-by-light-type singlet pieces.

## 3. Families (loop-only)

- RV, RVV 1x1: one-loop box with legs p1, p2, r1, q (3 orderings), propagators of k1 (and k2 for the conjugate);
  1x1 is a product of one-loop integrals (needed to higher order in eps).
- RVV 2x0: two-loop four-point, one off-shell leg, 9 propagators (planar and non-planar double boxes; masters known,
  Gehrmann-Remiddi, 2dHPLs). Matching as in RRV: shift the loop momenta onto the canonical family.
- Reference: H_P2B/nnlo_setup/RV (Higgs NNLO RV families), H_P2B/nnlo_setup/VV.

## 4. Masters, renormalisation

- Kira at fixed kinematics (two scales); masters from differential equations in (z, u) with exact boundary exponents,
  or from the literature with their boundary expansions.
- Two-loop UV, Larin Z5 and Z_a^ns at O(a^2); Z_s differs from Z_ns from O(a^2) (D3 b remainder, see RRV_plan.md).

## 5. Order of work

1. RV, validated against the known NNLO DY rapidity distribution (Anastasiou-Dixon-Melnikov-Petriello, hep-ph/0312266).
2. RVV 1x1 (one-loop masters only).
3. RVV 2x0.
