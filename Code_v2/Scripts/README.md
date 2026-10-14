# DY @ N3LO — triple-real (RRR) channels

Tree-level  i j -> V + 3 partons,  O(alpha_s^3),  V neutral (gamma*/Z).
Unphysical polarisation sum (-g^{mu nu}) for gluons -> ghost channels required.

## Summary (2026-10-12/13)

What was done in Code_v2, in order (details in the sections below):

1. Channels: 26 tree-level channels i j -> V + 3 partons (q qb g g g, q qb Q Qb g, q qb q qb g, ghosts q qb c cb g), then
   their p1 <-> p2 partners -> 49 channels, listed in `channels.csv`, created by `make_channel.py`. No q <-> Q swaps.
2. QGRAF in all 49 (50 / 24 / 48 / 12 diagrams per channel), NDIAG set.
3. FORM routines: `parser.h` (generic leg mapping, ghosts) and `spinlines.h` (generic spin lines from any antiquark leg,
   initial-state pol dropped, final-state pol kept as cut marker, gv/ga vs Gv/Ga) rewritten; `setenv.sh` for FORMPATH.
4. Steps 01-03 (colour algebra + spin lines, sums of 10 diagrams, complex conjugate) run and checked in all 49;
   step-03 template fixed (Cut legs at r3 and ghosts, ghost vertex indices, Gv/Ga conjugation).
   Checked against Code/ outputs (Vqqbgg, Vqgqg identical; VqQqQ up to an old Qbar2 bug).
5. Charge conjugation + p1 <-> p2 + r relabelling: the 49 channels form 16 classes (see "Minimal set to compute").
6. Propagators (`Families/collect_props.py`): per diagram, per diagram pair, union: 24 propagators (DD6..DD29),
   2548 maximal propagator sets.
7. Partial fractions (`Families/find_circuits.py`, `pf_identities.wl`): 48 identities in the old notebook format
   (36 ordinary, 12 with zero constant and a squared propagator), all verified.
8. Families (`Families/families.py`, `families.wl`), redefined from scratch (the old notebook families are not kept:
   they were chosen without the symmetry, 148 independent for q qb g g g alone where 29 suffice). Chosen with the
   relabelling symmetry r1,r2,r3 in mind: 154 representatives + all their relabelled copies -> 909 families, all rank 12,
   every tail inside a family as it is.
9. FORM rules for all 909 families (`Families/family_rules.wl`, notebook format), and the symmetry rules
   fams/symm_loop_crossings.inc: 755 rules INT(topo a, ...) = INT(topo b, permuted indices), each mapping a copy directly
   onto one of the 154 independent families (checked: every rule is a relabelling of r1,r2,r3 propagator by propagator).
   Earlier versions, for reference: family by family keeping the old 284 -> 1010 families, 474 independent;
   symmetry-aware keeping the old 284 (--keep-old) -> 1061 families, 277 independent.
   To do: reconstruct the integrals with the 909 families, then apply the 755 symmetry rules (-> 154); step 04 (squaring).

## Channels

### physical_qqbggg/  (7)   content q qb g g g

| Folder | Process | p1 <-> p2 partner | Process | Diagrams |
|---|---|---|---|---|
| Vqqbggg | q qb -> V g g g | Vqbqggg | qb q -> V g g g | 50 |
| Vqgqgg | q g -> V q g g | Vgqqgg | g q -> V q g g | 50 |
| Vqbgqbgg | qb g -> V qb g g | Vgqbqbgg | g qb -> V qb g g | 50 |
| Vggqqbg | g g -> V q qb g | symmetric | - | 50 |

### physical_qqbQ2Q2bg/  (14)   content q qb Q Qb g, Q != q

| Folder | Process | p1 <-> p2 partner | Process | Diagrams |
|---|---|---|---|---|
| VqqbQ2Q2bg | q qb -> V Q Qb g | VqbqQ2Q2bg | qb q -> V Q Qb g | 24 |
| VqQ2qQ2g | q Q -> V q Q g | VQ2qqQ2g | Q q -> V q Q g | 24 |
| VqbQ2bqbQ2bg | qb Qb -> V qb Qb g | VQ2bqbqbQ2bg | Qb qb -> V qb Qb g | 24 |
| VqQ2bqQ2bg | q Qb -> V q Qb g | VQ2bqqQ2bg | Qb q -> V q Qb g | 24 |
| VqbQ2qbQ2g | qb Q -> V qb Q g | VQ2qbqbQ2g | Q qb -> V qb Q g | 24 |
| VqgqQ2Q2b | q g -> V q Q Qb | VgqqQ2Q2b | g q -> V q Q Qb | 24 |
| VqbgqbQ2Q2b | qb g -> V qb Q Qb | VgqbqbQ2Q2b | g qb -> V qb Q Qb | 24 |

### physical_qqbqqbg/  (8)   content q qb q qb g, same flavour

| Folder | Process | p1 <-> p2 partner | Process | Diagrams |
|---|---|---|---|---|
| Vqqbqqbg | q qb -> V q qb g | Vqbqqqbg | qb q -> V q qb g | 48 |
| Vqqqqg | q q -> V q q g | symmetric | - | 48 |
| Vqbqbqbqbg | qb qb -> V qb qb g | symmetric | - | 48 |
| Vqgqqqb | q g -> V q q qb | Vgqqqqb | g q -> V q q qb | 48 |
| Vqbgqbqqb | qb g -> V qb q qb | Vgqbqbqqb | g qb -> V qb q qb | 48 |

### ghosts_qqbccbg/  (20)   content q qb c cb g

Only the q qb g g g content needs ghosts (>= 2 external gluons). One gluon pair -> ghost pair, both orientations.

| Parent | Folder | Process | p1 <-> p2 partner | Process | Diagrams |
|---|---|---|---|---|---|
| Vqqbggg | Vqqbccbg | q qb -> V c cb g | Vqbqccbg | qb q -> V c cb g | 12 |
| Vqgqgg | Vqgqccb | q g -> V q c cb | Vgqqccb | g q -> V q c cb | 12 |
|  | Vqcqcg | q c -> V q c g | Vcqqcg | c q -> V q c g | 12 |
|  | Vqcbqcbg | q cb -> V q cb g | Vcbqqcbg | cb q -> V q cb g | 12 |
| Vqbgqbgg | Vqbgqbccb | qb g -> V qb c cb | Vgqbqbccb | g qb -> V qb c cb | 12 |
|  | Vqbcqbcg | qb c -> V qb c g | Vcqbqbcg | c qb -> V qb c g | 12 |
|  | Vqbcbqbcbg | qb cb -> V qb cb g | Vcbqbqbcbg | cb qb -> V qb cb g | 12 |
| Vggqqbg | Vccbqqbg | c cb -> V q qb g | Vcbcqqbg | cb c -> V q qb g | 12 |
|  | Vgcqqbc | g c -> V q qb c | Vcgqqbc | c g -> V q qb c | 12 |
|  | Vgcbqqbcb | g cb -> V q qb cb | Vcbgqqbcb | cb g -> V q qb cb | 12 |

All p1 <-> p2 partners are separate folders (49 channels in total; Vggqqbg, Vqqqqg, Vqbqbqbqbg are symmetric). Full list: `channels.csv`.

## QGRAF diagram counts

qgraf-3.4.2 (`~/Software/qgraf-3.4.2/qgraf`, run from `<P>_LO/qgraf/`), tree level, options `nosnail, onshell, notadpole`. Output: `<P>_LO/external/<P>.0.inc`, log: `<P>_LO/qgraf/qgraf.log`.

| Group | Channels | Diagrams per channel |
|---|---|---|
| physical_qqbggg | 7 | 50 |
| physical_qqbQ2Q2bg | 14 | 24 |
| physical_qqbqqbg | 8 | 48 |
| ghosts_qqbccbg | 20 | 12 |

- All crossings of the same content (incl. p1 <-> p2 partners) have the same number of diagrams.
- Vqqbggg: 50 = old `NDIAG` of the template.
- Same flavour = 2 x different flavour (48 = 2 x 24): the identical quarks give the exchanged diagrams.
- Ghost channels: every diagram has overall sign (-1) (closed ghost line); keep sign conventions consistent when subtracting from the physical q qb g g g channels.
- External legs in the .inc files: -1 = p1, -3 = p2, -5 = V(q), -7 = r1, -9 = r2, -11 = r3.

## Conventions

Folder name = `V` + 2 initial partons + 3 final partons, in the same order as the legs in qgraf.dat.

| Token | Particle | qgraf field, initial / final |
|---|---|---|
| q | quark, flavour 1 | Quark[p] / Qbar[r] |
| qb | antiquark, flavour 1 | Qbar[p] / Quark[r] |
| Q2 | quark, flavour 2 (!= q) | Quark2[p] / Qbar2[r] |
| Q2b | antiquark, flavour 2 | Qbar2[p] / Quark2[r] |
| g | gluon | gluon |
| c | ghost | ghost[p] / Ghost[r] |
| cb | antighost | Ghost[p] / ghost[r] |

- QGRAF has every leg incoming (`out = ;`): final-state particles are written as their conjugate field.
- Momenta: initial p1, p2; V is V[q]; final r1, r2, r3 (left to right in the name).
- Example: VqgqQ2Q2b = q g -> V q Q Qb, `in = Quark[p1], gluon[p2], V[q], Qbar[r1], Qbar2[r2], Quark2[r3];`
- Group folders are named by the all-outgoing parton content: physical_<content>, ghosts_<content>.
- `Q2` instead of `Q` because macOS file names are case-insensitive (VqqbQQbg == Vqqbqqbg; also physical_qqbQQbg == physical_qqbqqbg).
- `_LO` = tree level (loops = 0).

## Layout

    Scripts/{physical_qqbggg,physical_qqbQ2Q2bg,physical_qqbqqbg,ghosts_qqbccbg}/<P>/<P>_LO/
        qgraf/qgraf.dat        output ../external/<P>.0.inc, style/model ../../../../../QGRAF/
        process_header.h       NDIAG (= QGRAF diagram count, see "QGRAF diagram counts"), NLOOP, PROC
        utils/                 copy of physical_qqbggg/Vqqbggg/Vqqbggg_LO/utils (the reference channel)
        external/              LeptonicCurrents (L1, L6), decayAmpSquared
        tmp/                   empty output tree
        cleanfld.py

    Scripts/channels.csv       all 49 channels: group, name, qgraf `in = ...`, p1 <-> p2 partner
    Scripts/make_channel.py    creates channel folders from channels.csv (copies shared files from the reference channel)
        python3 make_channel.py --missing --qgraf     # every listed channel without a folder, + QGRAF + NDIAG
        python3 make_channel.py <P> [<P> ...]         # selected channels; existing folders are never overwritten
    Families/                  propagators, partial fractions, integral families (run everything from Code_v2/Families)
    Families/collect_props.py  propagators of all channels from step-01 output -> Families/propagators/
        python3 collect_props.py [<P> ...]            # all channels by default
        propagators/<P>.m   props[P] (distinct), diagProps[P] (per diagram), pairProps[P] ({i, j, diagram i x conjugate j}),
                            products[P] (Union of pairProps[P]), maxProducts[P] (products[P] without sets contained in another)
        propagators/all.m   allProps, allMaxProducts (Union over the channels without sets contained in another; no relabelling)
        Momenta in the basis p1, p2, r1, r2, r3 (q eliminated), sign normalised. Only r-dependent propagators (p1+p2 = s dropped);
        each list only says which propagators occur (no repeats/powers); cut factors (r_i on shell, V, rapidity) not included.
    Families/denoms.m          definition of DD1..DD29 (DD1..DD5 cut, DD6..DD23 as the old notebook, DD24..DD29 new)
    Families/find_circuits.py  minimal linearly dependent propagator sets among the subsets of allMaxProducts -> circuits.m
    Families/pf_identities.wl  partial-fraction identities, same method and format as n3lo/RRR/Families_Identification:
        wolframscript -file pf_identities.wl   -> allpfid.m (PFid list), pfid_sets.m (j -> DD set),
                                                  partial_fraction/partialfraction_<j>.inc (FORM)
        DD1..DD23 as in Triple_Real_Families.nb, new DD24..DD29 = (p1+p2+r1)^2, (p1+p2+r2)^2, (p1+p2+r3)^2,
        (p1+p2+r1+r2)^2, (p1+p2+r1+r3)^2, (p1+p2+r2+r3)^2.
    Families/families.py       PF splitting of the sets -> tails; old 284 families kept, greedy new families (rank 12)
        python3 families.py [--keep-old] [--no-symmetry | --exact]  -> families_raw.m, tails.m, tailFamily.m, family_origin.m
        default: from scratch, families in complete relabelling groups (representative + its copies, r1,r2,r3 permuted);
        --keep-old: the 284 old notebook families first, unchanged;
        family_origin.m: n -> "old" | "representative" | {"copy", k, {s1,s2,s3}} (family k with r_i -> r_s_i)
    Families/families.wl       exact rank check (u symbolic) (+ old families unchanged with --keep-old) -> Families.m (old format)
    Families/family_rules.wl   as the notebook's "FORM ids" chapter and symmetry section, for all families:
        integralfamilies.rrr.m, fams/dens.inc, fams/fammatch.inc, fams/fams<n>.inc, fams/reconstruct.inc,
        fams/symm_loop_crossings.inc (relabelling r1,r2,r3 only, no p1 <-> p2)
        families_relabelling.m: famDD, famProps (families as DD numbers / momenta), relabelling = {{FAM[a], rule, FAM[b]}},
        independentFamilies; check: AllTrue[relabelling, Sort[(#[[1]] /. famProps) /. #[[2]]] === Sort[#[[3]] /. famProps] &]
    Families/isp_table.py       fams/fams<n>.inc as one FORM table ISP(n,k) (scalar product k of family n)   -> fams/isp_table.inc
    Families/fammatch_table.py  fams/fammatch.inc as tables FAM<m>(k1..km) = family of the propagator set     -> fams/fammatch_table.inc
        (run both after family_rules.wl; used by step 05 instead of trying the 909 / 22837 rules one by one, same output)

    Superseded: utils/run_collect_den.py, utils/collect_den.py, utils/show_den.frm (still in every channel).
        They need step-04 output (tmp/squared_diagrams), hardcode 5 x 5 groups and collect per group pair; replaced by Families/collect_props.py.
        Their old output format (den/den_<i>_<j>.m) is what n3lo/RRR/Families_Identification/Triple_Real_Families.nb reads.

Before running FORM: `source Code_v2/setenv.sh` (sets FORMPATH to Code_v2/FORMroutines; ~/.zshrc points elsewhere).
Works on macOS and Linux (bash or zsh). FORM executable for the step runners: environment variable FORM, default `form`;
on a cluster e.g. `export FORM="tform -w4"` (used by utils/04_run_4.py).

## Partial fractions: how the identities are found

- Every propagator DDk is linear in the 12 scalar products p1.ri, p2.ri, ri.rj (i <= j), plus a constant
  (s12 when the momentum contains p1 + p2). Definitions: Families/denoms.m.
- On the cut DD1 = ... = DD5 = 0 (r_i on shell, q^2 = m2, rapidity) five scalar products are fixed: the regular
  propagators live in the remaining 7 directions (the notebook's "someinversion").
- A set of regular propagators D_1..D_n has a relation if  sum c_i D_i = K + (terms in DD1..DD5)  with all c_i != 0
  (the scalar products cancel). It is minimal if no smaller subset has one.
  K != 0 -> identity  1 = (sum c_i D_i - cut terms)/K,  so  1/(D_1..D_n) = sum_i (c_i/K) 1/(D_1..^D_i..D_n)  (PFid, as old)
  K = 0  -> (skipped by the old notebook) the relation only says sum c_i D_i = 0 on the cut. Solving for D_n, the propagator
           with the highest DD number:  1/(D_1..D_n) = sum_{i<n} (-c_i/c_n) 1/(D_1..^D_i..D_{n-1} D_n^2)
           (PFid = (cut terms - sum_{i<n} c_i DD_i)/(c_n DD_n) = 1; FORM file with Prop(D_n)*Prop(D_n); pfid_squared.m: j -> n).
           All 12 come from the rapidity condition DD5 = 0 and contain DD24..DD29, e.g.
           (1+u) DD18 - DD28 - (1+u) DD8 - u DD14 + u DD25 = DD2 + 2 DD5  (= 0 on the cut).
- find_circuits.py: linear algebra (rank over the rationals, at two generic values of u) on every subset of the
  propagator sets that occur in the channels (allMaxProducts) -> the minimal ones (circuits.m).
  pf_identities.wl: for each, the exact relation (Solve, u symbolic, as TestPartialFractionCombo in the notebook),
  the constant K, check that PFid == 1, MultivariateApart for the FORM file.
- Numbers: minimal relations among all subsets of the 18 old propagators: 280 (old notebook: 270, all combinations);
  of all 24 propagators: 1662; of the sets that occur in the 49 channels: 48 (36 with K != 0, 12 with K = 0)
  -> PFid 1..36 (K != 0) and 37..48 (K = 0). The old notebook enumerated all combinations (270 identities): 257 of them
  involve propagators that never occur together in any of the 49 channels.
- Checks: every PFid == 1 exactly; every FORM file LHS - RHS = 0 on the cut (read back into Mathematica); PFid 1..12 of
  the old propagators identical to the old allpfid.m.
  Every product in the old den/ files of q qb -> V g g g is one of the products found here for Vqqbggg.

## Status (2026-10-13)

Code_v2 vs Code: `FORMroutines/`, `QGRAF/`, `dy_python/` identical; only `Scripts/` changed (old `Vqq*` folders, `Templates/`, `Form_Templates/`, `setup.sh` replaced by the 4 groups above).
Not copied from the template: generated files (`03_complex_conj_diags.frm`, `sum_squared_diags.frm`) and editor junk (`.idea`, `*~`, `#decay.inc#`).

Done:
- All 26 `qgraf.dat` checked against the conventions; QGRAF run in all 26 (qgraf-3.4.2), `NDIAG` set (log total = diagrams in file).
- `FORMroutines/parser.h`: per-PROC blocks replaced by one generic rule (leg -k -> 100-k, all fields incl. ghosts) + external ghost legs in the 99..89 loop.
  Tested on Vqqbggg, VqgqQ2Q2b, Vqqqqg, Vqqbccbg, Vgcqqbc: no negative legs, no unconverted v3/v4/prop left.
- `setenv.sh`: sets FORMPATH to Code_v2/FORMroutines (~/.zshrc points to MatrixElement/FORMroutines, which lacks all_header.h etc.).
- `FORMroutines/spinlines.h`: per-PROC blocks replaced by one generic line builder (start at any Qbar/Qbar2 leg, follow the line, close at Quark/Quark2;
  initial-state end points drop pol, final-state ones keep it as cut marker; gv/ga on flavour-1 lines, Gv/Ga on flavour-2; FORM exits on an open line).
  Old version: removed (old VqQqQ/VqQbqQb blocks restored the flavour-1 Qbar(93) as pol(Qbar2(93,...))).
- Step 01 (`form utils/01_colour_algebra.frm`) run in all 26 channels: no errors, all diagrams written, in every term each final quark leg has exactly one pol and no initial quark has one.
  Check vs Code/ (same processes rerun with Code_v2): Vqqbgg, Vqgqg identical; VqQqQ identical after Qbar2(93) -> Qbar(93) in the stored Code/ output (old bug).
- `utils/02_run_sum_diags_group.py` (all 26): exits with error and keeps `tmp_folder/` if a FORM group job fails (was: printed and continued).
- `utils/template_03_complex_conj_diags.frm` (all 26): Cut mapping for final quarks at 89 and final ghosts (93/91/89); vGGg, pghost added to the mu->nu renaming; Gv/Ga -> cGv/cGa.
  Dry run 02+03 on copies (Vqqbggg, VqgqQ2Q2b, Vqgqqqb, Vqqbccbg, Vgcqqbc): no mu left, all final-state pol in Cut form, all couplings conjugated.
- Steps 02 (group size 10) and 03 run in all 26 channels: no errors, conjugates clean (no mu left, final pol in Cut form, couplings conjugated).
- p1 <-> p2 partners added (23 new channels, 49 total) with `channels.csv` + `make_channel.py`
  (checked: regenerating the 26 existing channels reproduces them, QGRAF output included). Steps 01-03 run in all 23 new channels, same checks passed;
  final-state pol check passes in all 49.

Open (FORM step cannot run yet):
1. `FORMroutines/feynman_rules.h`: pol rules only for cut legs 93/91 (and gluon 89); missing for quark legs at 89 and for ghost legs.

Minor:
- `utils/insert_reduction.frm`: still includes `../Vqq_LO/tmp/...` and `L1_4.inc` (not present).
- `Code_v2/` not in git yet.

- Charge conjugation + p1 <-> p2 + r relabelling: the 49 channels form 16 classes (same 16 representatives as "Minimal set to compute" below);
  every image of C, p1 <-> p2, C + p1 <-> p2 is one of the 49.
- Propagators collected for all 49 channels (`collect_props.py`): 24 distinct r-dependent propagators (p1+p2 dropped),
  4849 distinct diagram-pair products (sets, no repeats), 2548 not contained in another (all with 6 propagators) = allMaxProducts. Checked: same propagators in every term of a diagram (1310 diagrams);
  products of each p1 <-> p2 partner = partner's with p1 <-> p2.

- `Families/` created (propagators, partial fractions, families); `Code_v2/.gitignore` ignores all pipeline output (tmp/ trees kept via .gitkeep).
- Partial fractions: 48 minimal dependent sets among the occurring propagator sets; 36 identities (allpfid.m, partial_fraction/);
  the 12 using only DD6..DD23 are identical to the old n3lo/RRR/Families_Identification/allpfid.m. 12 sets have a relation with
  zero constant (all involve DD24..DD29): no identity yet (skipped, as in the old notebook).

- Zero-constant relations written as PFid 37..48 (D_n squared); all 48 FORM files checked exactly.
- Families (families.py + families.wl): 1968 tails, all with independent propagators; 420 inside the 284 old families
  (all 284 used); 726 new families (greedy; lower bound 186) -> 1010 in Families.m, all of rank 12, FAM[1..284] unchanged.
  New families up to r1,r2,r3 relabelling: 329; also p1<->p2: 190.

- FORM rules (family_rules.wl): fams/ etc.; FAM[1..284] files byte-identical to the old notebook output. Old 284 alone ->
  148 independent, the same 136 relations as the old symm_loop_crossings.inc (which also lists 7 alternative permutations
  for symmetric families: 143 lines).
- Families chosen with the relabelling symmetry in mind (families.py default): 1061 families = 284 old + 12 copies of old
  + 129 representatives + 636 copies; 784 relabelling relations, 277 independent (was 1010 / 474 family by family).
  Test without old families: 154 independent from scratch (old q qb g g g tails alone: 29 instead of 148).

- Families redefined from scratch (user's choice): 909 families = 154 representatives + 755 copies; symm_loop_crossings.inc
  maps the 755 onto the 154 (all rules checked). Old notebook families no longer used (--keep-old restores them).

- Step 04 fixes (one at a time): `kin6point` added to FORMroutines/invariants.h (q = -p1-p2-r1-r2-r3, p1.p2 = s12/2, as H_P2B);
  utils/04_run_4.py (all 49) rewritten: ran only on Linux-style fork (crashed on macOS) and exited 0 on failures; now main guard,
  one FORM process per job in utils/tmp_fld/tmp_i_j/ (log kept there on failure), exit code 1 if any job fails. Not run yet.
- Step 04 coupling split (utils/4_square_ampl.frm, utils/04_run_4.py, all 49): the squared terms are split by the coupling of
  the amplitude (gv, ga: V on the q line; Gv, Ga: V on the Q2 line) times the conjugate one (cgv, cga, cGv, cGa) into 16 pieces,
  named amplitude + conjugate coupling with v, a, v2, a2 (v2, a2 = Gv, Ga):
      vv  va  vv2  va2  /  av  aa  av2  aa2  /  v2v  v2a  v2v2  v2a2  /  a2v  a2a  a2v2  a2a2
  -> tmp/squared_diagrams/<name>/<name>_i_j.inc (16 per job, 0 when the combination does not occur, e.g. v2.. without a Q2 line).
  Before, only vv, aa, va, av were kept: the Q2 pieces were lost. A completeness check stops FORM (#terminate) if
  interf - sum(coupling x piece) != 0. ONLYVECTOR now also sets Ga = 0 (as before only the amplitude's axial couplings).
  Steps 05/06 extended to the 16 pieces (see below).
- FORMroutines/feynman_rules.h: external-leg rules added for final quarks at r3 (leg 89: Quark, Qbar, Quark2, Qbar2 x Cut... ->
  Prop(cut,r3)) and ghosts (final ghost/Ghost x Cutghost/CutGhost -> Prop(cut,v), initial ghost/Ghost squared -> 1; no Lorentz part).
  Ghost sign (decided): NOT in the pipeline, applied at the very end when channels are combined:
  sum_phys |M|^2 = sum_{-g} |M|^2 - sum_{ghost channels} |M_ghost|^2, i.e. every ghost channel (both orientations c cb and cb c,
  already separate channels) enters once with a factor -1. QGRAF's overall (-1) per ghost amplitude squares to +1 and does
  not provide it (it would only in a forward-scattering/cut-diagram approach, from the closed ghost loop).
  utils/4_square_ampl.frm (all 49): stops (exit) if any pol(...) is left after the Feynman rules.
- Step 04 tests (single FORM jobs on scratch copies, low priority): expression names X<name> (aa2 is a colour index in
  all_header.h; files keep <name>). Feynman rules moved BEFORE the traces (polarisation sums / propagator d_ contracted inside
  the traces): Vqqbccbg 2x2 groups 47 s -> 1 s; old vs new order identical in all 16 pieces for Vqqbccbg 2x2, Vgcqqbc 2x2
  (initial ghost) and VqqbQ2Q2bg diagram 21 x 24 (two lines, Q2). VqqbQ2Q2bg groups 3x3 (4x4 diagrams): 69 s, all checks passed.
- Sign of final-state quark spin sums (utils/template_03_complex_conj_diags.frm, all 49): QGRAF momenta are incoming, an outgoing
  (anti)quark with label r has spin sum -r-slash; factor -1 per final-state quark/antiquark leg (generic version of the old
  `id Spin(1) = (-1)^('INITFIN')` of Code/Scripts/Vqgq). Was missing in Code_v2. Checked on Vqcqcg: new conjugate = - old.
  !! The existing step-03 outputs (Csum_*) of the channels with final-state quarks are stale: rerun steps 02-03 there.
- Steps 02-03 rerun in all 49 channels with the sign (597 s, one channel at a time).
- Total test on Code_v2 (Vqqbccbg regrouped, all 144 diagram pairs through step 04, 394 s one job at a time): total vv and aa
  symmetric in mu95<->nu95, total va = conj(av) transposed (conjugation includes e_ -> -e_: gamma5 is written eps/6 without i).
- COLOUR BUG fixed (utils/template_03_complex_conj_diags.frm, all 49): the 100x100 loop mapped the external indices back INSIDE
  the loop, so a T with two external quark indices was transposed twice (= not conjugated). Now: one transposition of every T,
  then renaming of the conjugate's internal quark colour indices (i->ii, j->jj, numbers < 89). Same faulty loop in the old
  Code/ NNLO setups (Vqqbgg, Vqgqg, VqQqQ, VqQbqQb, Vqqbggg_template) and in H_P2B ggHqqb_lo, ccbHqqb_lo, but HARMLESS
  there: their colour algebra never leaves a T with two external indices (f -> commutators with an internal j, four-quark
  colour Fierzed into d_'s), checked on the stored diag/Cdiag files. Only T(a,i_x,i_y) with x < y was wrong (x > y was
  transposed once). In Code_v2 it hit the 22 four-quark + gluon channels (VqqbQ2Q2bg, Vqqbqqbg, ... and partners).
- Colour test after the fix (scratch, Vqqbqqbg, one diagram per group): the square of each single diagram has exactly
  the colour factor (Nc^2-1)^2/(8 Nc) (gluon from a quark line: diagrams 1, 9, 16) or Nc (Nc^2-1)/4 (gluon from the
  gluon: diagram 10), in the vv, aa, va, av pieces (checked at Nc = 2, 3, 4). Control: with the old loop diagram 10 fails.
- Textbook check (scratch, q qb -> V g and q g -> V q, 2 diagrams each, bare tensor): -g.H = 8(1-eps) gs^2 C_F N_c
  [(1-eps)(t/u+u/t) + 2 Q^2 s/(t u) - 2 eps] exactly, crossing with opposite constant (final-quark sign), positive in the
  physical region, q_mu H^{mu nu} = 0. With the old loop the colour came out (Nc-1) instead of Nc^2-1.
- Per-pair checks done right (mu<->nu swap on one side only): H(i x j) = conj(H(j x i))^T in all pieces for the textbook
  process, Vqqbccbg 1x2, Vqqbqqbg 1x2 and the exchange pair 1x3. (An earlier "per-pair asymmetry" was a bug in my test.)
- Steps 02-03 rerun in all 49 with the colour fix.
- Step 04 full run, VqqbQ2Q2bg (runner, 2 jobs): 9 pairs x 16 pieces OK, 2937 s CPU in total (~5 s per diagram product;
  10x10 pairs 7-9 min), max 2 GB per job, 676 MB output. (Wall times of that run are meaningless: the laptop slept.)
  Estimate all 49 channels: ~66 CPU h for step 04.
- Steps 05/06 rewritten (first in physical_qqbQ2Q2bg/VqqbQ2Q2bg; copied to all 49 channels on 2026-10-14, identical files):
  utils/05_run_contractPj.py: all non-zero pieces x group pairs; projector per piece: L1 (symmetric) for the parity-even
    pieces vv, aa, vv2, aa2, v2v, a2a, v2v2, a2a2, L6 (epsilon) for the odd ones va, av, va2, av2, v2a, a2v, v2a2, a2v2
    (other combinations vanish by parity, not computed); jobs in utils/job_<piece>_<PROJ>_<i_j>/ (log kept on failure,
    exit 1); threads + main guard (macOS), FORM from $FORM; families from Code_v2/Families (FAMDIR), nothing copied.
    Prompts: a/o/l (all, one by index, list), parallel jobs, debug (write intermediate expressions).
  utils/template_contractPj.frm: piece/paths from the defines; generic Prop sign normalisation (hardcoded flips removed);
    our 48 PF sets inside ONE repeat (an identity can recreate an earlier pattern; terminates: each removes a distinct
    propagator); dens.inc, then exits if a Prop / cut Den is left; family by table lookup of the term's propagator set
    (fammatch_table.inc), exit if a set is in no family / a term has no unique TOPO; numerators by the ISP table, one scalar
    product per module (all powers at once); reconstruct.inc, exit if TOPO or any DD is left; CPU time in the messages.
  utils/06_run_sum_contracted.py + template_sum_squared_diags.frm: every piece and projector, warns about missing pairs,
    symm_loop_crossings.inc from Families, exit if a dependent family (left-hand side of the relabelling) is left;
    output tmp/unreduced/<piece>/unreduced<PROJ>.ff and .m.
  Tests (VqqbQ2Q2bg): numerical end-to-end check (scratch check05.py): step-04 piece x projector vs step-05 result, INT ->
    product of the family's DD's, at random rational points on the cut surface (r_i^2 = 0, q^2 = m2 = 1, rapidity = 0, cut
    propagators stripped, d, u, z numerical): identical for vv 3x3 (2 points), va 3x3 with L6 (2 points), vv 2x2 (10x10).
    Table lookups and per-scalar-product ISP: byte-identical to the rule-by-rule version.
    Step 06: relabelling applied (topo11 -> topo7, topo461 -> topo460, topo467 -> topo466), no dependent family left.
  Timing, one piece (vv, L1): 3x3 (4x4 diagrams) 81 s -> 14 s; 10x10 pair 620 s -> 309 s (PF 17 s, dens + families 19 s,
    numerators 120 s, reconstruct 108 s (sorting, a table lookup did not help), ratfun 33 s), 1.2 GB.
    -> step 05 costs much more than step 04 (16 pieces per pair, ~5 min each for 10x10): to be optimised / planned.
  Fixes after a 3-pair test (2026-10-14): Prop(p1+p2) (s-channel gluon, q qb -> g* -> Q Qb with V on the Q line,
    pieces with v2/a2) -> Num(z)/m2 again (dropped by mistake; the dens.inc check stopped the job); m2 -> 1 also for
    negative powers (id m2^n? = 1; m2^-1 was left, value unchanged since m2 = 1; same flaw in the old template).
- aa and a2a2 NOT computed (user decision, 2026-10-14; utils/4_square_ampl.frm, all 49): axial x axial on the same quark
  line equals vector x vector, and the intermediate Larin-scheme aa traces are very expensive (Vqqbggg 1x1: aa = 63 MB of
  the 121 MB step-04 output). id ga(ti)*cga(tj) = 0, id Ga(ti)*cGa(tj) = 0 before the traces; the aa and a2a2 files are 0
  and step 05 skips them. COMBINATION: aa := vv, a2a2 := v2v2. The mixed aa2, a2a (gamma5 on two different lines) are
  kept. Tested on VqqbQ2Q2bg 3x3: aa, a2a2 = 0, the other 14 pieces byte-identical, 69 s -> 34 s.
  Kept switchable (aa will be computed at some point): define SKIPAA (default 1) in 4_square_ampl.frm, set by
  04_run_4.py from the environment: `SKIPAA=0 python3 utils/04_run_4.py` computes aa and a2a2 again (step 05 then runs
  them with L1, step 06 sums them; nothing else to change). Tested: SKIPAA=0 gives aa, a2a2 byte-identical to the
  earlier full run (3x3: 47 s vs 34 s with the default).
  Tried and NOT adopted (user): coefficients as one rational function per structure (PolyRatFun) between the numerator
    stage and reconstruct.inc: exactly identical results, but only 4-26% faster on 10x10 pairs (vv 2x2 309 -> 263 s,
    va 1x2 348 -> 333 s, aa2 1x1 187 -> 138 s) and a different output format. Collecting coefficients into one function
    (Collect) made it worse (more terms after the numerators; re-collecting exceeds MaxTermSize).

Next: review steps 05/06 and copy them to all channels; reduce the cost of step 05; decide laptop vs cluster;
combination stage (ghost -1, symmetry factors, flavour sums, p1 <-> p2 / C partners).

## Minimal set to compute (16 of 26)

Free operations:
- **p1 <-> p2** (requires mapping u to its p1<->p2 image, since `Den(cut, -q.p1 + q.p2*u)` is asymmetric);
- **relabelling r1, r2, r3** (free: the rapidity constraint involves only q, p1, p2);
- **charge conjugation C**: QCD is C-invariant; the V vector current is C-odd, the axial current C-even
  -> vv, aa unchanged; va, av flip sign.
  -> **L1** (symmetric) contraction identical, **L6** (antisymmetric, eps) contraction gets an overall minus sign.
  L6 also flips sign under p1 <-> p2 (eps(q,p1) sqrt(z/u) - eps(q,p2) sqrt(z u)): combine the signs carefully when C and p1<->p2 are both used.

### Physical (10)

| Content | Compute | Obtained from it |
|---|---|---|
| q qb g g g | **Vqqbggg** | itself (C = p1<->p2) |
| | **Vqgqgg** | Vqbgqbgg (C) |
| | **Vggqqbg** | itself (C + r1<->r2) |
| q qb Q Qb g | **VqqbQ2Q2bg** | itself |
| | **VqQ2qQ2g** | VqbQ2bqbQ2bg (C) |
| | **VqQ2bqQ2bg** | VqbQ2qbQ2g (C) |
| | **VqgqQ2Q2b** | VqbgqbQ2Q2b (C) |
| q qb q qb g | **Vqqbqqbg** | itself |
| | **Vqqqqg** | Vqbqbqbqbg (C) |
| | **Vqgqqqb** | Vqbgqbqqb (C) |

### Ghosts (6)

Weight = multiplicity of -|M_ghost|^2 after including the parent symmetry factor (1/3!, 1/2!).

| Parent | Compute | Obtained from it | Weight |
|---|---|---|---|
| q qb -> V g g g | **Vqqbccbg** | 3 gluon pairs x 2 orientations (r relabelling) | 1 |
| q g -> V q g g | **Vqgqccb** | Vqbgqbccb (C); 2 orientations (r relabelling) | 1 |
| | **Vqcqcg** | Vqbcbqbcbg (C); 2 initial-final pairs (r relabelling) | 1 |
| | **Vqcbqcbg** | Vqbcqbcg (C); 2 initial-final pairs (r relabelling) | 1 |
| g g -> V q qb g | **Vccbqqbg** | cb c (p1<->p2) | c cb + cb c |
| | **Vgcqqbc** | Vgcbqqbcb (C + r1<->r2); ghost at p1 (p1<->p2) | g c + c g, both orientations |

- Ghost orientation with an initial-state ghost (q c vs q cb) is **not** related by any of the operations above (C also turns q into qb): both are needed.
- The 10 non-minimal folders are kept as cross-checks.
