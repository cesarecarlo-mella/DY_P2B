# Plan: RRV (one loop x tree, two real emissions), and what RR needs for it

Internal plan (code + physics), 2026-10-21. Nothing in the FORM pipeline changed yet.

## 0. The criterion: traces, not lines

gamma5 matters only through where the two V vertices sit in the **traces** of |M|^2 (after the spin sums):

| class | where the V vertices are | gamma5 | scheme |
|---|---|---|---|
| **S** | amplitude V and conjugate V in the **same trace** | the two gamma5 meet in one trace: aa = vv exactly (anticommuting) | NDR, only vv computed |
| **X** | in **two different open-line traces** | one gamma5 per trace | Larin, Z_a^ns per axial vertex |
| **P** (loops only) | amplitude V on a **closed quark loop** (pure singlet) | one gamma5 in the loop trace | Larin, Z_s (differs from Z_a^ns at O(a^2): not needed in RRV) |
| odd | va, av, ... (one gamma5 in total) | single gamma5 | always Larin |

Why traces and not lines: for identical quarks, the direct x exchange interference D E* is always **one** trace (the two
spin lines are joined into one; `4_square_ampl.frm`, "combine spinlines": `Spin(1) Spin(2) SpinC(2) SpinC(1) -> g_(1,...)`).
So D E* is class S whatever line V sits on, including when amplitude and conjugate have V on different lines.
- The per-line labels gv2/ga2 (patch prepared, not applied) put the D E* part of "cross-line" pieces (aas, asa) into Larin.
  Meanwhile the D E* part of the same-label pieces (vv) is anticommuting.
- That splits one closed set (D E*) between two schemes: exactly the mixture to avoid.
- **The gv2/ga2 patch should not be applied as is.** Replace it with a trace tag (section 2).

Each class must be separately finite (UV, IR, mass factorisation). This holds because:
- q != Q channels: S and X have different couplings (a_q^2, a_Q^2 vs a_q a_Q): independent, so separately finite.
- Identical quarks: class X = the two-trace parts of D D* and E E* (V on different lines). Each is the same function
  as the q != Q cross-line piece with Q -> q, so it belongs to the finite a_q a_Q set. D E* is always one trace: all S.
- P: coupling a_q sum_f a_f (v_q sum_f v_f), independent of the others. The RR produced-pair X pieces
  (a_q sum_Q a_Q) are in the same bucket as RRV's P: both Larin, so consistent.

So the "mixture" is consistent once the split is by trace: the identical-quark process renormalises as a whole, and
every class just carries its own Z (Z = 1 for S in NDR).

## 1. Tags needed (amplitude level and squared level)

Amplitude level (spinlines / QGRAF):
1. Open lines: flavour labels as now. gv, ga on flavour-1 lines; Gv, Ga on flavour-2 lines. No per-line labels.
2. Closed quark loop containing V: `gvPS`, `gaPS` (coupling sum_f v_f, sum_f a_f; Larin for gaPS).
3. Closed quark loop without V: factor `Nf` (scheme-free).

Squared level (step 04, right after "combine spinlines"):

4. Trace tag: in a two-trace term the amplitude line i and conjugate line i form trace i.
   - Two-trace term with V_amp on line i and V_conj on line j != i -> class X.
   - Single-trace term, or i = j -> class S.
   - Only needed when the flavour label does not already decide it, i.e. identical-quark channels.

Pieces: name = amp label + conj label (+ `X` suffix for class X when the flavours are equal):
- one line: vv, va, av (aa = vv, not computed)
- q != Q: as now (16; X is automatic: vv2, aa2, ...)
- identical quarks: vv, vvX, aaX, va, vaX, av, avX (aa S part = vv S part, skipped)
- RRV extra: gvPS / gaPS x conj label: vPSv, aPSa, vPSa, aPSv (+ v2, a2 on two-flavour channels)

SKIPAA then zeroes only the S part of aa (the X part is always computed).

## 2. Code changes (to propose as diffs later; not now)

| step | change | channels |
|---|---|---|
| spinlines.h | line number stored on the V coupling (e.g. `ga(ti,LINE)`), removed after step 04 | all |
| 04 combine spinlines | multiply two-trace terms with different V lines by `trX`; split pieces by `trX` | identical-quark only matter |
| 04 SKIPAA | `id ga*cga = 0` only on the terms without `trX` | all |
| run_all / 04_run_4 / 05 | piece list with the X suffix | all |
| spinlines.h (RRV) | closed-loop routine: walk around a quark loop, trace g_(3,...), Larin on V, `gvPS/gaPS` | RRV |
| QGRAF (RRV) | loops = 1; each closed quark loop once (drop closed Quark2 loops; closed Quark loop = flavour sum) | RRV |
| kinematics (RRV) | loop momentum k; tree conjugate unchanged | RRV |

Check the QGRAF fermion-loop sign on the Nf part of the gluon self-energy (known result).

## 3. What RR needs, and what depends on the RRV choices

RR enters RRV and RRR assembly through:
- UV counterterms: beta0/eps x RR (every piece, exact in d);
- Z_a^ns(1) x RR Larin pieces (class X axial and odd);
- mass factorisation (RR x Gamma^(1), per coupling bucket).

| RR item | depends on | status |
|---|---|---|
| 29 channels with one line or q != Q (one-line, Q2, ghosts) | nothing: the flavour label already gives the class | **can run now** |
| 4 identical-quark channels (Vqqbqqb, Vqbqqqb, Vqqqq, Vqbqbqbqb) | trace tag (D1) | **hold**; run after the tag (cheap) |
| X-class axial pieces exact in d (aa2, a2a, aaX) | Larin for X (D1) | aa2, a2a already computed |
| aa (S) in Larin (SKIPAA=0) | only if a class is chosen all-Larin (option A) | not needed with the trace split |
| eps depth of the integrated RR | beta0/eps counterterm and mass factorisation | integration side |
| piece names = conjugate labels of RRV | naming in section 1 | fix before RRV assembly |

RRR: the 8 identical-quark channels (`physical_qqbqqbg`) need the same tag, so they are rerun once the tag exists
(SKIPAA=1 is then fine: only aa S skipped). The other RRR channels are unchanged.

## 4. RRV pipeline (new)

1. Channels: the 33 RR channels (same names, legs, partners). P pieces appear in:
   - vector P (d^abc, three gluons on the loop): q qb -> V g g, q g -> V q g, g g -> V q qb (and crossings)
   - axial P (anomaly): the same channels plus four-quark (V + 2 gluons on the loop; vector P = 0 there by Furry)
2. QGRAF loops = 1 (`template.dat` already has &Nloops&), closed-loop handling (section 2).
3. Steps 01-04 as RR, with the closed-loop trace and the PS tags; interference A^(1) A^(0)*; assembly takes 2Re.
4. RRV integral families: 1 loop + 2 emissions + V + rapidity delta (new: not among the 41 RR families). Then family
   identification, partial fractions, Kira reduction, masters. This is the largest part.
5. Steps 05/06 adapted to the new families (NPROP, ISP tables).

## 5. Checks for RRV

- Poles of the one-loop amplitude (after reduction, or at a phase-space point): Catani's I^(1) x tree, **per class** (S, X, P separately). This tests that the classes
  are closed and that the trace tag is right.
- UV: after the beta0 and Z_a^ns counterterms, the remaining poles = Catani.
- S class: aa = vv at d = 4 (Larin, SKIPAA=0, one channel).
- Identical quarks: X class of D D* = q != Q cross-line piece with Q -> q (INT by INT, same leg order).
- Axial P: sum_f a_f over a full massless doublet cancels; Nf part of the gluon self-energy.

## 6. Decisions

Status 2026-10-21: D1 = classes by trace (for now, may change later; start producing bare results). D2 = explained,
proposal (drop closed Quark2 loops, closed Quark loop = generic flavour) pending. D3 = top decoupled, b remainder later.


- D1: classes by trace (S anticommuting, X and P Larin): recommended. Alternatives: all Larin for identical-quark
  channels (SKIPAA=0, no tag needed, all of it gets Z_a^ns), or all Larin everywhere.
- D2: closed quark loops in QGRAF: loop-only field vs filter on Quark2 loops.
- D3: axial P with the third doublet: drop the b remainder (massless top), or a massive top loop.
- D4: compute only one of each tree-level mirror pair (va = av, ...): optional speed-up.

## 7. Order of work

1. Discuss D1-D3.
2. RR: run the 29 channels on newton now.
3. Trace tag in step 04 (diff, test on Code_RR Vqqbqqb: completeness, S aa = vv at d=4, X = Q2 copy, q != Q unchanged).
4. RR: run the 4 identical-quark channels. RRR: rerun the 8 identical-quark channels, then integrals + Kira top-up.
5. RRV: QGRAF + closed loops + PS tags on one channel (q qb -> V g g); check the one-loop interference at a phase-space
   point against an independent one-loop code, per class; then the families.
6. RRV families, reductions, all channels; assembly with assembly.pdf.

## 8. Code_RRV decisions (2026-10-21)

1. New folder Code_RRV, copy of Code_RR (same 33 channels).
2. Two diagram sets per channel: QGRAF loops=1 and loops=0, steps 01/02 on both, 03 on the tree set only, 04 = loop
   group i x conjugate tree group j (two defines, e.g. NLOOP=1, NLOOPC=0); tree set regenerated inside Code_RRV.
3. Closed quark loops in spinlines.h (drop closed Quark2 loops, closed Quark loop = any flavour: Nf, gvPS/gaPS).
   Every change to spinlines.h is approved by the user first.
4. Colour of closed loops (trace of T's, d^abc): test on q qb -> V g g.
5. No existing RRV families: collect all denominators and match them to families (as for RRR).
6. Trace tag: under discussion. 7-9 later.
