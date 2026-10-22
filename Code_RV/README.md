# Code_RV: real-virtual at NNLO (one loop x tree, one emission r1) -- steps qgraf..06 done

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

Step 05 (2026-10-22, the Code_RRV machinery):
- Scripts/tools/collect_dens.py on the 6 channels -> Families/rv/sets_union.txt (30 sets, 12 loop parts, every one a
  subset of a box). The k1-free regular propagators (p1+r1)^2, (p2+r1)^2 are constants on the cut (Code_R
  partial_fraction), so only the loop part decides the family.
- Families/rv_families.py: 3 families = the box orderings q-p1-p2-r1, q-p1-r1-p2, q-p2-p1-r1; propagators D1..D3
  cuts (Code_R topo1) + 4 box props (k1, k1+a, k1+a+b, k1+a+b+c), global D4..D11 = (k1 + S)^2 for the subsets S of
  {p1, p2, r1}; INT(topoN, 1,1,1, n1..n4); no irreducible numerator (4 props for k1.k1, k1.p1, k1.p2, k1.r1).
  Tables: fams/rv_loopcodes.inc, rv_match_table.inc (loop part -> RVT(family)*LSHIFT(shift)), rv_shifts.inc,
  rv_loopdens.inc, rv_isp_table.inc / rv_isp_apply.inc (k1.x in the box DD's, then p1.r1, p2.r1 by isp_table.inc),
  rv_reconstruct.inc. Mathematica: integralfamilies_r.rv.m ({families as DD lists, DD[n] -> Den[...]}),
  rv_topsectors.m (top sector 127 = all 7 props in every family). `wolframscript -file Families/check_rv_families.wl`:
  rank 7, loop ISP modulo the cuts, every table entry lands in its family, rv_reconstruct.inc = the .m file.
  Removed (unused): fams/fammatch_table.inc, fams/reconstruct.inc.
- utils/template_contractPj.frm (6 channels): after dens.inc, loop codes -> table -> k1 shift -> kinematics again ->
  D4..D11 -> loop ISP, Code_R ISP -> rv_reconstruct.inc. run_all.py: NPROP = 7, RV leftovers, version files.
- Test (laptop, all 6 channels, steps qgraf..06, 0 failed, 3 min): every piece in topo1..3, nothing left;
  vPSv = vPSa = 0 (Furry, two gluons on the loop), aPSa, aPSv non-zero.
Not done: reduction (Kira, 3 box families), masters, 2 Re(A1 A0*) after the masters, renormalisation.

----------------------------------------------------------------------------------------------------------------------

