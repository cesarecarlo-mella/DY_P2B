# Code_RVV_1L1L: real-virtual-virtual at N3LO, product 1L x 1L (one-loop amplitude x conjugate one-loop amplitude)

Built 2026-10-22 from the tracked Code_RV files (build scripts: ~/Documents/GitHub/DY_P2B_work/2026-10-22/code_rvv_build/build_rvv11.py, build_rvv11_05.py;
method: notes_Larin/oneloop_squared.tex, plan: notes_Larin/RVV_plan.md). The product 2L x tree is not in here.

Same channels as Code_RV (physical_qqbg: V + q qb g and crossings, 6 channels), same pipeline (Scripts/run_all.py).

Steps qgraf..04
- One diagram set: the one-loop amplitude (qgraf/loop/, external/PROC.1.inc after Scripts/tools/drop_quark2_loops.py);
  qgraf, 01, 02 run only this set. Step 03 conjugates it (utils/template_03_complex_conj_diags.frm, written by the
  step-02 runner for the one-loop set): besides the tree-level rules (colour, indices, couplings, spin lines, eps and
  i_ signs) the loop momentum k1 -> k2, the closed quark loop Spin(3, x1..xn) -> SpinC(3, xn..x1) (Tr(...)^* = trace
  of the reversed product), and gvPS, gaPS -> cgvPS, cgaPS (FORMroutines/all_header.h).
- Step 04 (utils/4_square_ampl.frm): one-loop group i (k1) x conjugate one-loop group j (k2), all pairs i, j. The
  closed loop of the conjugate goes through SpinLC into trace 4. Pieces: amplitude coupling + conjugate coupling, each
  of v, a, v2, a2, vPS, aPS (36) + vvX, vaX, avX, aaX; projector L1 when both couplings are vector or both axial, L6
  otherwise (run_all.py COUPLINGS, EVEN).
- spinlines.h is unchanged: each diagram set is parsed alone and has at most one closed quark loop; the second one
  (PS x PS) only appears in the product.

Step 05 (utils/template_contractPj.frm, Families/rvv_families.py)
- Global propagators: D1..D3 cuts, D4..D11 = (k1 + S)^2, D12..D19 = (k2 + S)^2, D20 = (k1 + k2)^2.
- The two loops are matched separately with the RV tables (k1: fams/rv_loopcodes.inc, rv_match_table.inc,
  rv_shifts.inc; k2: fams/rvv_loopcodes.inc, rvv_shifts2.inc = the same with k1 -> k2): box family A of k1 (RVTA),
  box family B of k2 (RVTB), each with its own shift. k1.k2 -> (D20 - k1.k1 - k2.k2)/2, then the k1 and k2 scalar
  products in the box propagators (rv_isp_table.inc, rvv_isp_table2.inc), then p1.r1, p2.r1 (isp_table.inc).
- Families topoN, N = 3 (A - 1) + B (9): INT(topoN, 1,1,1, n1..n4 (k1 box A), n5..n8 (k2 box B), n9 ((k1+k2)^2)),
  = the Reduze families rvvAB of the 1L x 1L test (~/Documents/GitHub/DY_P2B_work/2026-10-22/rvv_reduze: rvv12 =
  topo2). Mathematica: Families/integralfamilies_r.rvv.m, rvv_families.txt, rvv_topsectors.m.
- No symmetries between families or between the loops: the conjugation (-i0) acts on the k2 factor. Reduce with
  sector relations and symmetries off (notes_Larin/oneloop_squared.tex).

Checks (laptop, Vqqbg, 2026-10-22)
- qgraf..04: 13 one-loop diagrams, 2 groups, 4 pairs, 11 min, 0 failed.
- Conjugation: X_ji[Q] = (X_ij[P])^* for every partner pair of pieces (Q = P with amplitude and conjugate couplings
  swapped; k1 <-> k2, mu95 <-> nu95, i_ -> -i_, e_ -> -e_): vv, va/av, vPSv/vvPS, vPSa/avPS, aPSv/vaPS, aPSa/aaPS,
  vPSvPS, vPSaPS/aPSvPS, aPSaPS all identical; two wrong pairings (va/va, vPSv/vPSv) different.
- Step 05: every piece with V vector-coupled to a closed loop vanishes (Furry: vPSv, vvPS, vPSa, avPS, vPSvPS,
  vPSaPS, aPSvPS); aPSv = vaPS, aPSa = aaPS, aPSaPS non-zero; all 9 families occur, nothing left.

Not done: the other 5 channels, reduction (Reduze, relations and symmetries off), masters (products of one-loop
masters, k2 factor conjugated), assembly (pairs (i, j) + (j, i) = 2 Re), renormalisation; product 2L x tree.
