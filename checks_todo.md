# Checks to do

Written 2026-10-22, updated 2026-10-23. Tick items off as they are done.

## 1. Families and identities

### RRV (Code_RRV/Families)

Files: integralfamilies_r.rrv.m (77 families as lists of DD[n], DD[n] -> Den[...]), integralfamilies.rrv.m,
relabelling_momenta.rrv.m, rrv_topsectors.m, rrv_families.txt, denominators.rrv.m, fams/*.inc (FORM tables).

- [ ] Rerun the automatic checks: `wolframscript -file Code_RRV/Families/check_rrv_families.wl`
      1. RR part of every family = integralfamilies.rr.m (topo1..41; RR 42, 45, 46 not in it)
      2. 12 independent propagators per family (complete basis of the scalar products)
      3. the 154 families (77 + r1 <-> r2 images) = rrv_reconstruct.inc
      4. loop ISP table, valid modulo the cut propagators D1..D4
      5. matching table: every entry lands in its family after the shift
      6. integralfamilies_r.rrv.m = integralfamilies.rrv.m
- [ ] Definitions by hand: DD[1..4] cuts (r1^2, r2^2, (p1+p2+r1+r2)^2 - m2, rapidity -q.p1 + u q.p2),
      DD[5..13] RR propagators, DD[14..29] = (k1 + S)^2 with S = subsets of {p1, p2, r1, r2}; signs of the momenta
      (p1, p2, r1, r2, k1 incoming, q = -p1-p2-r1-r2).
- [ ] Each family = (RR family) x (k1 pentagon): the 5 loop propagators form one ordering of the legs around the
      pentagon, consistent with FamilyDrawings/RRV (families_rrv.pdf).
- [ ] r1 <-> r2 identities: topo(77+n) = topo n with r1 <-> r2 (relabelling_momenta.rrv.m, {78, {p4 -> p5, p5 -> p4}, 1});
      check that the propagator sets map onto each other and that the cut propagators (rapidity!) are invariant.
- [ ] Top sectors (rrv_topsectors.m, 280 in total): maximal sets with 10 or 11 propagators, never 12; every
      integral of the step-06 results (Code_RRV/integrals/all after `run_all.py integrals`) lies in a subsector of
      one of them.
- [ ] Step-06 results: no dependent family (topo78..154), no leftovers (`run_all.py check`, lines 05/06 only).
- [-] Numerical step-05 check: not ported to Code_RRV (the k1 shift in step 05 makes a pointwise check need the same
      shift on both sides); dropped (user, 2026-10-22).
- [ ] Colour/Furry on step 06: Vqqbgg vPSv purely d^abc d^abc, zero at Nc = 2; non-zero for Nc = 3 (the box survives).

### RV (Code_RV/Families)

Files: integralfamilies_r.rv.m, rv_families.txt, rv_topsectors.m, fams/rv_*.inc.

- [ ] Rerun: `wolframscript -file Code_RV/Families/check_rv_families.wl`
      1. 7 independent propagators; 2. loop ISP table modulo the cuts; 3. matching table; 4. rv_reconstruct.inc
- [ ] Definitions by hand: 3 families = box orderings q-p1-p2-r1, q-p1-r1-p2, q-p2-p1-r1; D1..D3 cuts, D4..D11 =
      (k1 + S)^2, S subsets of {p1, p2, r1}; top sector 127 in every family; no irreducible numerator.
- [ ] Furry: vPSv = vPSa = 0 (two gluons on the loop); aPSa, aPSv non-zero.

### RR (Code_RR/Families)

- [ ] integralfamilies.rr.m (the RR parts used by the RRV families).

## 2. Reduction strategy for one loop x one loop (RVV)

Method: notes_Larin/oneloop_squared.tex. Factorisable two-loop families (k1 box of the amplitude) x (k2 box of the
conjugate) x (k1+k2)^2; k1.k2 removed by Lorentz covariance; masters = ordered products M_a(k1) M_b(k2); the
conjugation acts on the k2 factor; NO symmetries exchanging k1 and k2.

Done so far (work files in ~/Documents/GitHub/DY_P2B_work/2026-10-22/):
- fact1x1/ (toy family, same box ordering in k1 and k2, 8 integrals up to rank 2): projection = reduction as
  unordered values 8/8; as ordered products: Kira 1/8 (applies k1 <-> k2 sector symmetries, cannot be switched off),
  Reduze with default settings 1/8 (130 sector relations exchange k1 and k2), Reduze with find_sector_relations,
  find_sector_symmetries, setup_crossings false 8/8 (16 masters = 4 x 4).
- rvv_reduze/ (one family rvv12 = Code_RV topo1 in k1 x topo2 in k2, real kinematics s, t, m2; top sector with
  k1.k2 at rank 1 and 2): Reduze without relations = projection as ordered products 2/2; 16 masters = 4 x 4, none
  with (k1+k2)^2. Rerun: `./run_test.sh` (16 min, one core).

To check:
- [ ] Read check/routeB.wl against the formulas of the notes (Gram matrix of p1, p2, r1; rank 2: (k1perp^2 k2perp^2)/(d-3);
      higher ranks: (2l-1)!! / ((d-3)(d-1)...)).
- [ ] sectormappings/sectormappings_rvv12.yaml: sector_relations and sector_symmetries empty, only zero sectors.
- [x] Higher rank: seeds from the data (2026-10-23, all 6 q qb g channels: 11441 integrals, s <= 4 in topo1, 2, 4,
      s <= 3 otherwise, (k1+k2)^2 up to the third power, no dots); RVV_reductions/make_jobs.py takes them from
      the analysis.
- [ ] Subsector integrals, numerators on the box propagators, one dot (not only the top sector).
- [ ] A diagonal family (rvv11, same ordering in k1 and k2), where k1 <-> k2 maps the family onto itself: ordered
      products must still come out right with the relations off.
- [ ] Relabelling rule for the mixed families: rvvBA reduced directly = rvvAB with the two factors swapped
      (if true, only 6 of the 9 families need a reduction: rvv11, rvv22, rvv33, rvv12, rvv13, rvv23).
- [ ] Conjugation: the reduction coefficients are real (rational in s, t, m2, d); evaluate one product with
      both prescriptions, M_a(+i0) M_b(-i0) = M_a M_b^*, on a simple case (bubble x bubble above threshold).
- [x] Step 04: X_ji[Q] = (X_ij[P])^* for every partner pair of pieces (Vqqbg, with negative controls).
- [x] After insertion: Vqqbg aPSaPS coefficient matrix symmetric under amplitude <-> conjugate masters (FORM check
      with a negative control).
- [ ] Assembly: X_ij + X_ji = 2 Re X_ij for the pairs (i, j) of 1x1 products; the summed 1x1 contribution is real;
      the same symmetry for every self-conjugate piece (vv, aPSaPS, vPSvPS, ...) of every channel.
- [ ] Cost: time and memory of the real families (9 propagators, all sectors, no symmetries) at the needed seeds.
      Laptop, one core per family, s <= 4: about 46 of ~65 sectors in 2 h (stopped 2026-10-23, to run on newton
      with MPI).
- [ ] g g -> V g (Vggg + 6 ghost channels): ghost |M|^2 subtracted at assembly; after the reduction the vector PS
      part of Vggg is pure d^abc d^abc (zero at Nc = 2); the triangle parts (vector) cancel.

## 3. Reduction strategy and checks for two loop x tree (RVV 2L x tree, Code_RVV_2L)

Families PL, NPL of Hjet2L and their 6 crossings (12, 10 used); per-diagram shifts from Reduze find_diagram_shifts
(applied in step 01, tag L2F); Kira with symmetries (no conjugated loop; 2 Re after the masters).

Done (Vqqbg, prototype): census of the 229 two-loop diagrams (2 with two closed quark loops, 4 zero by colour, the
colour zero checked with explicit SU(3) matrices); Reduze matches 300/300 checked independently; every loop
propagator inside its tagged family after step 01; step 05 = step 04 numerically (check05, 6/6 + negative control).

To check:
- [ ] All channels: census and shift check (rvv2l_shifts.py does it per channel), step 05 check05 on random pieces.
- [ ] After the Kira reduction: the triangle-type vector PS contributions cancel (Furry); the vector PS part is pure
      d^abc (zero at Nc = 2).
- [ ] Masters: Kira masters mapped onto the Hjet2L canonical basis (crossings!), production-region continuation.
- [ ] Comparison with the known two-loop V+jet interference (Garland, Gehrmann, Glover, Koukoutsakis, Remiddi;
      Gehrmann et al.).

## 4. Still to implement (2026-10-23)

- [ ] Repo: g g -> V g channels in Code_RVV_1L1L; RVV_reductions MPIRUN option; commit to_form.py,
      insert_reductions.py (tested on the laptop).
- [ ] Repo: Code_RVV_2L (build scripts in DY_P2B_work/2026-10-23/code_rvv2l_build), with the 6 shift files.
- [ ] Code_RVV_2L: integral analysis tool (12 families) and RVV2L_reductions/ (Kira job generator for PL, NPL and
      crossings).
- [ ] Insertion of Kira results (RRV, RVV 2L x tree; RRR): Kira tables -> FORM tables -> masters (as to_form.py /
      insert_reductions.py for Reduze).
- [ ] Masters: one-loop box/bubble masters to the needed order in eps (1L x 1L, conjugate factor); two-loop masters
      from Hjet2L in our kinematics; RRV masters (open).
- [ ] Assembly: 2 Re, ghost subtraction, PS coupling sums, renormalisation (Z factors), mass factorisation; full
      Larin (aa_S with Z5^ns, an ONLYAA option for step 04) if decided.
