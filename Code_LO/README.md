# Code_LO: Born q qb -> V with the Code_RRR pipeline

Same machinery as Code_RRR, Code_RR, Code_R (FORM routines, QGRAF files, steps 01-06, `Scripts/run_all.py`), with no
emission. Created 2026-10-19 like `../Code_R` (see its README); changed only where the number of emissions enters.

## Physics

Q = p1 + p2: delta+(Q^2 - m2) delta(Q.p1 - u Q.p2) = delta(s12 - m2) delta(s12 (1-u)/2), i.e. z = 1 and u = 1:

    INT(topo1,1,1) = Phi_0 = delta(s12 - m2) delta(Q.p1 - u Q.p2) = (2/m2^2) delta(1-z) delta(1-u)

The coefficient is computed with s12 = m2/z as in R, RR, RRR, so it must be evaluated at z = 1 (u does not appear).
Exact in d. Example (vv, L1, m2 = 1): Nc (d-2) z^-3 = 4 Nc q^2 (d-2) (p1.p2)^2: the trace of L1 with the q qb tensor,
4 q^2 (d-2) p1.p2, times the cut factor (-q.p2) = p1.p2 and the colour sum Nc.

## What differs from Code_RR

- `Families/`: one family topo1 = the 2 cut propagators D1 = (p1+p2)^2 - m2, D2 = rapidity; no scalar products with
  emitted momenta (isp tables empty), no regular propagators, `reconstruct.inc` -> INT(topo1,1,1).
- Channel `utils/4_square_ampl.frm` and `utils/template_contractPj.frm`: kinematics q = -p1-p2, p1.p2 = s12/2 written
  inline (invariants.h kin3point sets p1.p2 = m2/2; FORMroutines are kept identical to Code_RRR's); family matching
  replaced by `multiply TOPO(1)`.
- Channel `utils/02_run_sum_diags_group.py`: a group of one diagram is written `#do cycle = 1,1` (FORM rejects the
  one-element list `{1}`; NDIAG = 1 only here).
- `Scripts/run_all.py`: NCUT = NPROP = 2, GLUON_GROUPS = {physical_qqb}, INT pattern also closed by ")".

Channels: Vqqb (q qb -> V), partner Vqbq; 1 diagram each.

## Run

    cd Code_LO && source setenv.sh && export QGRAF=~/Software/qgraf-3.4.2/qgraf
    python3 Scripts/run_all.py run --set all --jobs 1

## Checks (2026-10-19)

- QGRAF output identical to the old `Code/Scripts/Vqq/Vqq_LO/external/Vqq.0.inc`.
- vv, va, av, aa (SKIPAA=0) against the old `Code/Scripts/Vqq/Vqq_LO/tmp/reduced{1,6}.m` at z = 1: **new = - old**
  in every piece (`Scripts/tools/cmp_old.wl`). The new sign is the physical one: vv = Nc (d-2) > 0 in d = 4 (see
  above), the old file has Nc (2-d) < 0. The old Vqq_LO output dates from the first version of the old code (2025-03);
  the old NLO and NNLO outputs agree with Code_R and Code_RR including the sign.
