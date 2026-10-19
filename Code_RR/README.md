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

Channels (2026-10-19): all 33 in Scripts/channels.csv, derived from Code_RRR's by removing the final gluon r3 (same
names, same p1 <-> p2 partners, no q <-> Q swaps), created by Scripts/make_channel.py (reference channel
physical_qqbgg/Vqqbgg) with QGRAF:

| Group | Channels | Diagrams |
|---|---|---|
| physical_qqbgg | Vqqbgg, Vqbqgg, Vqgqg, Vgqqg, Vqbgqbg, Vgqbqbg, Vggqqb | 8 |
| physical_qqbQ2Q2b | VqqbQ2Q2b, VqbqQ2Q2b, VqQ2qQ2, VQ2qqQ2, VqQ2bqQ2b, VQ2bqqQ2b, VqbQ2qbQ2, VQ2qbqbQ2, VqbQ2bqbQ2b, VQ2bqbqbQ2b | 4 |
| physical_qqbqqb | Vqqbqqb, Vqbqqqb, Vqqqq, Vqbqbqbqb | 8 |
| ghosts_qqbccb | Vqqbccb, Vqbqccb, Vqcqc, Vcqqc, Vqcbqcb, Vcbqqcb, Vqbcqbc, Vcqbqbc, Vqbcbqbcb, Vcbqbqbcb, Vccbqqb, Vcbcqqb | 2 |

    cd Code_RR && source setenv.sh && export QGRAF=...
    python3 Scripts/run_all.py run --set all --jobs 8        # or --channels Vqqbgg,...

Test against the old Code/Scripts/Vqqbgg (2026-10-15): QGRAF output byte-identical; step-04 tensor (summed) exactly
identical to the old tmp/Htensor in vv, va, av and aa (aa with SKIPAA=0); unreduced integrals after steps 05/06
exactly identical to the old tmp/unreduced (vv with L1; va, av with L6; aa with L1), compared per integral with the
whole coefficient as one rational function (m2 = 1); controls (different pieces) come out different.
Not computed by default, as in RRR: aa (= vv), and the parity-odd pieces with L1 / even with L6 (the old code had
non-zero va, av with L1: terms with the Levi-Civita tensor of four momenta, which vanish after integration).

Tests of the other channels (2026-10-19, laptop, SKIPAA=0; `Scripts/tools/cmp_old.wl NEW/tmp/unreduced OLD/tmp/unreduced`,
`Scripts/tools/ratio_old.wl NEWFILE OLDFILE`, per integral with m2 = 1):
- QGRAF output identical to the old Vqgqg, VqQqQ (= VqQ2qQ2), VqQbqQb (= Vqqbqqb with r1 <-> r2, run in a scratch copy
  with the old leg order).
- VqQ2qQ2 vs old VqQqQ: every old piece identical (old VV = vv2 = v2v, AA = aa2, AV = av = va (L6), va = va2 (L6)).
- Old VqQbqQb (identical quarks): vv, aa, va, av identical (also the relative signs of the exchanged diagrams).
- Vqgqg vs old Vqgqg: new = - old in every integral of vv, aa, va, av. The new sign is the right one: crossing
  (all momenta incoming, q g -> V q g = q qb -> V g g with the antiquark and a gluon exchanged, one fermion crossed)
  requires Vqgqg(p1,p2,r1,r2) = - Vqqbgg(p1, r1, p2, r2) for the step-04 tensor . L1 (V-cut factor -q.p2 divided out);
  checked exactly in d and Nc at a rational point, and Vqqbgg agrees with the old code. Same check at NLO
  (Code_R Vqgq vs Vqqbg): -1 as well, and there old = new. So the old RR q g channel lacks the crossing sign.
- Ghost channel Vqcqc and Vggqqb run through step 06 (all propagator sets in the 41 families); no old reference.
- As before, the old parity-odd pieces with L1 (Levi-Civita of four momenta, zero after integration) are not computed.
