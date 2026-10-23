# Code_RVV_2L: real-virtual-virtual at N3LO, product 2L x tree (two-loop amplitude x conjugate tree)

Built 2026-10-23 from the tracked Code_RV files (build script: ~/Documents/GitHub/DY_P2B_work/2026-10-23/
code_rvv2l_build/build_rvv2l.py; plan: notes_Larin/RVV_plan.md). The product 1L x 1L is Code_RVV_1L1L.

Channels: q qb g and crossings (physical_qqbg, 6), as Code_RV. g g -> V g has no tree amplitude (its 2L x 1L is
N4LO), so it is not here; its 1L x 1L is in Code_RVV_1L1L.

## Steps qgraf..04
- Two diagram sets: 2 = two-loop amplitude (qgraf/loop/: loops = 2, external/PROC.2.inc after
  Scripts/tools/drop_quark2_loops.py; NDIAG2 in process_header.h), 0 = tree (conjugate, step 03 as in Code_RV).
  Vqqbg: 300 two-loop diagrams, 229 after dropping the closed Quark2 loops (4 of them zero by colour).
- spinlines.h (change approved 2026-10-23): the closed quark loops are walked twice, Spin(3,...) and Spin(4,...); at
  two loops a diagram can have two (a quark bubble on the s-channel gluon of the V-g-g triangle, Vqqbg QGRAF
  diagrams 134, 138); factor Nf per closed loop without V (Vline(L)), couplings gvPS, gaPS on the loop with V.
  Step 01 splits the momentum sums in Spin(4) as in Spin(3); step 04 takes the second loop as trace 4 (SpinL4).
- Step 01 (two-loop set): every diagram is shifted onto its family and tagged L2F(f), from
  external/PROC.2L_shifts.inc (in git): Families/rvv2l_shifts.py runs QGRAF with the Reduze style and Reduze
  find_diagram_shifts (Families/reduze/: families PL, NPL; crossings by Reduze), checks every match independently
  (after the shift every loop propagator is a propagator of the crossed family, t and the sector ID agree), maps the
  QGRAF numbering onto the FORM one (Quark2 loops dropped) and writes the shift file. run_all.py step 01 fails if
  the file is missing. Regenerate after any change of the QGRAF card: `python3 Families/rvv2l_shifts.py [P ...]`
  (needs QGRAF and Reduze; the cluster runs need neither the Reduze project nor Reduze).

## Step 05 (utils/template_contractPj.frm, Families/rvv2l_families.py)
- Families (Families/rvv2l_families.txt): PL and NPL of Hjet2L (Code/Scripts/Templates/common.py; there outgoing
  p1, p2, p3, here all incoming with p3 -> r1) and their crossings of the massless legs in the standard notation
  1 = p1, 2 = p2, 3 = r1 (x12, x13, x23, x123, x132): topo1..6 = PL, PLx12, PLx13, PLx23, PLx123, PLx132,
  topo7..12 = NPL, ... (10 used in the q qb g channels; NPLx13, NPLx123 not).
- No matching in step 05: each term carries L2F(f). Global propagators D1..D3 cuts, D4..D32 the 29 distinct loop
  propagators (Families/rvv2l_props.txt, fams/l2_dens.inc); the 9 loop scalar products of each family in its
  propagators (fams/l2_isp_table.inc, exact inversion checked); INT(topo<f>, 1,1,1, n1..n9) in the Hjet2L order
  (fams/l2_reconstruct.inc). Mathematica: Families/integralfamilies_r.rvv2l.m.
- Scripts/tools/check05.py (run_all.py verify): before = step-04 piece x L, after = step-05 result with each INT
  replaced by its propagators, at a random point (random loop scalar products; valid pointwise since step 05 does
  not shift loop momenta here).

## Checks (Vqqbg, laptop prototype, 2026-10-23)
- Census of the parsed two-loop diagrams: 158 without closed loop, 20 with an Nf loop, 45 with V on a closed loop,
  2 with two closed loops, 4 zero by colour (diagram 32 recomputed with explicit SU(3) matrices: 0).
- Reduze matches 300/300 (6 channels: 229 FORM diagrams each, all checked); every loop propagator of every parsed
  diagram inside its tagged family.
- Step 04: 23 pairs, 157 CPU min, at most 25 min and 1.8 GB per pair.
- Step 05 = step 04 numerically (check05: vv, aPSa, vPSv, small and large pairs, two seeds), negative control
  (two propagators swapped) different.
- Vector PS pieces are not zero pair by pair (the two orientations of a closed loop are different two-loop diagrams,
  possibly in different crossings): the triangle-type cancellation (Furry) and the d^abc structure of the boxes
  (vPS x v zero at Nc = 2) are checks after the reduction.

Not done: reduction (Kira, PL/NPL and crossings, symmetries allowed: 2 Re is taken after the masters), insertion,
masters (Hjet2L canonical basis), renormalisation.
