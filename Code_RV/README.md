# Code_RV: real-virtual at NNLO (one loop x tree, one emission r1) -- IN PREPARATION

Created 2026-10-21 from the tracked Code_R files plus the Code_RR -> Code_RRV changes (scratchpad build script
build_rv.py; plan: notes_Larin/RVV_plan.md):
- Two diagram sets per channel: qgraf/ (tree, external/PROC.0.inc) and qgraf/loop/ (one loop, PROC.1.inc, then
  Scripts/tools/drop_quark2_loops.py). process_header.h: NDIAG0, NDIAG1 (after the filter), NLOOP from the command
  line. run_all.py: qgraf, 01, 02 run both sets, 03 the tree, step 04 = one-loop group i x conjugate tree group j.
- FORMroutines/spinlines.h, all_header.h as Code_RRV (closed quark loops: Nf, or gvPS/gaPS with V on the loop);
  step 04 with SpinL (closed loop out of the way while the lines are combined) and the PS pieces vPSv ... aPSa2.
- Scripts/tools/collect_dens.{py,frm}: distinct propagator sets of the step-04 output.
- One-loop diagrams per channel after the filter: 13 (2 closed Quark2 loops dropped); tree: 2.
Test (laptop, Vqqbg, steps qgraf..04, 8 s): nonzero vv, va, av (both pairs) and vPSv, vPSa, aPSv, aPSa (pair 1_1:
the closed quark loop with V); no Spin left; no Nf (no internal gluon at one loop).

Not done: step 05 for RV. The single-emission phase space collapses (kinematics fixed by z, u; Phi_1 below), so the
families are loop-only: substitute p1.r1, p2.r1, keep INT(topo1,1,1,1) = Phi_1 as in Code_R, and match the k1
propagators to one-loop boxes (legs p1, p2, r1, q: 3 orderings). Step 05 is still Code_R's (it stops at the k1
propagators). Then: 2 Re(A1 A0*) after the masters are evaluated; renormalisation.

----------------------------------------------------------------------------------------------------------------------

