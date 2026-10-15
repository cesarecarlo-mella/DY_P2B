# Code_RR: double-real (two emissions r1, r2) with the Code_RRR pipeline

Same machinery as Code_RRR: FORM routines, QGRAF files, steps 01-06, Scripts/run_all.py, adapted to two
emissions:
- kinematics kin5point (q = -p1-p2-r1-r2); 4 cut propagators (r1^2, r2^2, q^2 - m2, rapidity) D1..D4, regular D5..D13
  (p1+r1, p2+r1, p1+r2, p2+r2, p1+r1+r2, p2+r1+r2, r1+r2, p1+p2+r1, p1+p2+r2); INT(topoN, 1,1,1,1, n1,n2,n3)
- Families/: the 41 RR families of nnlo_rr/integrals/Families_Identification (dens.inc, fammatch.inc, fams1..41.inc,
  reconstruct.inc, integralfamilies.rr.m) and its partial fractions 1..49 + extra_1 (= 50) + extra_2 (= 51);
  no relabelling rules (fams/symm_loop_crossings.inc empty). Tables by isp_table.py (generic: also writes
  fams/isp_apply.inc, included by step 05) and fammatch_table.py.
- run_all.py: NCUT = 4, NPROP = 7; no coverage.py; the selftest and tools/check05.py (verify) are not adapted yet.

Channel: Scripts/physical_qqbgg/Vqqbgg (q qb -> V g g, 8 diagrams).
    cd Code_RR && source setenv.sh && export QGRAF=...
    python3 Scripts/run_all.py run --channels Vqqbgg --jobs 3

Test against the old Code/Scripts/Vqqbgg (2026-10-15): QGRAF output byte-identical; step-04 tensor (summed) exactly
identical to the old tmp/Htensor in vv, va, av and aa (aa with SKIPAA=0); unreduced integrals after steps 05/06
exactly identical to the old tmp/unreduced (vv with L1; va, av with L6; aa with L1), compared per integral with the
whole coefficient as one rational function (m2 = 1); controls (different pieces) come out different.
Not computed by default, as in RRR: aa (= vv), and the parity-odd pieces with L1 / even with L6 (the old code had
non-zero va, av with L1: terms with the Levi-Civita tensor of four momenta, which vanish after integration).
