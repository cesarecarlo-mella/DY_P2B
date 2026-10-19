# Code_R: single real (NLO, one emission r1) with the Code_RRR pipeline

Same machinery as Code_RRR and Code_RR (FORM routines, QGRAF files, steps 01-06, `Scripts/run_all.py`), with one
emitted parton. Created 2026-10-19 by copying Code_RR / Code_RRR and changing only what depends on the number of
emissions (list below); the LO (Born) is in `../Code_LO`, built the same way.

## Physics: why there are no integrals at NLO

One emitted parton k (= -r1) and the two constraints of the cross section at fixed rapidity, delta+(Q^2 - m2) and
delta(Q.p1 - u Q.p2) with Q = p1 + p2 + r1, fix every scalar product (s12 = m2/z):

    p1.r1 = (m2 u - s12) / (2 (1+u)),     p2.r1 = (m2 - u s12) / (2 (1+u))

(solve Q^2 = s12 + 2 p1.r1 + 2 p2.r1 = m2 and s12/2 + p1.r1 = u (s12/2 + p2.r1); same rules as the old
`Code/Scripts/Vqgq/Vqgq_LO/tmp/ISP/PL.inc`). So the regular propagators (p1+r1)^2 = 2 p1.r1, (p2+r1)^2 = 2 p2.r1 are
constants, and what is left is one "integral", the phase space itself:

    INT(topo1,1,1,1) = Phi_1 = int d^dk delta+(k^2) delta+(Q^2-m2) delta(Q.p1 - u Q.p2)
                     = pi^(1-eps)/Gamma(1-eps) s^(-1-eps) /(1+u) [(u-z)(1-uz)/(1+u)^2]^(-eps)

(the n = 1 case of `phase_space_int/`). The results are exact in d.

## What differs from Code_RR

- `Families/`: one family topo1 = the 3 cut propagators D1 = r1^2, D2 = (p1+p2+r1)^2 - m2, D3 = rapidity.
  `fams/dens.inc` (cut propagators only), `partial_fraction/partialfraction_1.inc` (the regular propagators as their
  values on the cut), `fams/fams1.inc` -> `isp_table.py` -> `fams/isp_table.inc`, `isp_apply.inc` (p1.r1, p2.r1),
  `fams/reconstruct.inc` (-> INT(topo1,1,1,1)), `fams/fammatch_table.inc` and `symm_loop_crossings.inc` trivial.
- Channel `utils/4_square_ampl.frm`: `#call kin4point` instead of kin5point.
- Channel `utils/template_contractPj.frm`: kin4point; the family matching is replaced by `multiply TOPO(1)` (no
  regular propagator can be left); D1..D3 only.
- `Scripts/run_all.py`: NCUT = NPROP = 3, GLUON_GROUPS = {physical_qqbg}, INT pattern also closed by ")",
  selftest channel (selftest and tools/check05.py not adapted, as in Code_RR).
- `Scripts/make_channel.py`: reference channel physical_qqbg/Vqqbg.
- `FORMroutines/`, `QGRAF/`: byte-identical copies of Code_RRR's (check: `diff -r Code_R/FORMroutines Code_RRR/FORMroutines`).

## Channels (`Scripts/channels.csv`)

Every channel of Code_RR with its final gluon r2 removed (and every Code_RR channel is a Code_RRR channel with its final
gluon r3 removed): same names, same p1 <-> p2 partners, no q <-> Q swaps. 2 diagrams each, no ghosts (one gluon).

| Folder | Process | p1 <-> p2 partner |
|---|---|---|
| Vqqbg | q qb -> V g | Vqbqg |
| Vqgq | q g -> V q | Vgqq |
| Vqbgqb | qb g -> V qb | Vgqbqb |

## Run

    cd Code_R && source setenv.sh && export QGRAF=~/Software/qgraf-3.4.2/qgraf
    python3 Scripts/run_all.py run --set all --jobs 1          # seconds; SKIPAA=0 also computes aa
    python3 Scripts/run_all.py check --set all

Output per channel: `tmp/unreduced/<piece>/unreduced<PROJ>.{ff,m}` = coefficient of INT(topo1,1,1,1), m2 = 1, in z, u, d.

## Checks (2026-10-19, laptop, FORM 5.0)

- QGRAF output byte-identical to the old `Code/Scripts/{Vqgq,Vqbgqb}`.
- Vqgq and Vqbgqb (run with SKIPAA=0): vv (L1), va, av (L6), aa (L1) exactly identical to the old
  `tmp/unreduced{1,6}.m` (old INT(PL,1,1,1) -> 1, s12 -> m2/z, m2 -> 1); control: different pieces differ.
  `wolframscript -file Scripts/tools/cmp_old.wl <channel>/tmp/unreduced Code/Scripts/<channel>/<channel>_LO/tmp PL`
- p1 <-> p2 partners: coefficient(partner; z, u) = +-(1/u) coefficient(z, 1/u) with sqrtzu <-> sqrtziu (+ for vv, aa,
  - for va, av): with Phi_1(z, 1/u) = u Phi_1(z, u) this is the Jacobian 1/u^2 of u -> 1/u. Charge conjugation
  (Vqgq <-> Vqbgqb, Vgqq <-> Vgqbqb): vv, aa equal, va, av opposite. (`Scripts/tools/partners.wl Code_R/Scripts`)
- Vqqbg (no old result): vv at d = 4 = 4 gs^2 (Nc^2-1) x q^2 (-q.p2) (t^2 + u^2 + 2 s m2)/(t u), the textbook
  q qb -> V* g matrix element times our projector and cut factor (`Scripts/tools/textbook.wl`, run from the repo root).
