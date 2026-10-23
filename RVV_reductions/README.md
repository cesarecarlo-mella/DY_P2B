# RVV_reductions: IBP reduction of the RVV 1L x 1L integrals with Reduze

One Reduze project per family (Code_RVV_1L1L topo1..topo9 = k1 box x k2 box x (k1+k2)^2), reduced WITHOUT sector
relations and symmetries: the k2 factor is the conjugate amplitude (-i0), and a relation exchanging k1 and k2 would
move the conjugation onto the other factor (notes_Larin/oneloop_squared.tex). Masters = ordered products
M_a(k1) M_b(k2) of one-loop masters (16 per family).

## Commands

```
python3 make_jobs.py jobs                       # Code_RVV_1L1L/integrals/all -> jobs/topo1 .. jobs/topo9
python3 make_jobs.py jobs --fams 2,5 --r-extra 1
python3 make_jobs.py test --fams 2 --max-s 1 --max-ints 6     # cheap check -> jobs/topo2_test/ (not in git)
REDUZE=/path/to/reduze jobs/topo2/run.sh        # nice 19, log in reduze.out
MPIRUN="mpirun -np 8" REDUZE=/path/to/reduze jobs/topo2/run.sh   # MPI build (newton)
ls jobs | grep -v _test | xargs -P 9 -I{} sh -c 'REDUZE=/path/to/reduze jobs/{}/run.sh'   # all 9 in parallel
```

Input: `Code_RVV_1L1L/integrals/<collection>/` (`Code_RVV_1L1L/Scripts/run_all.py integrals`, then
`Code_RVV_1L1L/integrals/Tools/analyse_integrals.py <collection>`): `kira/topoN.txt` and `analysis/topsectors.csv`.

## Per job, `jobs/topoN/`
- `config/integralfamilies.yaml`: the 9 loop propagators of Code_RVV_1L1L topoN (INT positions 4..12; the 3 cut
  propagators, always index 1, are constants at fixed kinematics): k1 box, k2 box, (k1+k2)^2 (numerator only).
- `config/kinematics.yaml`: p1, p2, r1 incoming, q = -p1-p2-r1, q^2 = m2, s = (p1+p2)^2, t = (p1+r1)^2;
  m2 -> 1 (restored on export). In terms of z, u: s = m2/z, t = m2 (u z - 1)/(z (1 + u)).
- `jobs.yaml`: setup_sector_mappings (relations, symmetries, crossings off), reduce_sectors of the top sector(s) with
  seeds r in [t, t+1], s in [0, s of the tree], select_reductions of `toreduce/topoN`, reduce_files, export to
  `results/topoN.m` (Mathematica) and `results/topoN.inc` (FORM: INT(topoN, t, ID, r, s, [], n4..n12) -> to be
  mapped back to INT(topoN, 1,1,1, n4..n12) at insertion); coefficients in z, u, d (s, t, m2 replaced on
  export: s = 1/z, t = (u z - 1)/(z (1 + u)), m2 = 1).

## Checks
- Method: DY_P2B_work/2026-10-22/fact1x1 (toy family, 8 integrals) and rvv_reduze (rvv12 = topo2, k1.k2 at rank
  1 and 2): Reduze with these settings = Gram projection as ordered products; Reduze defaults and Kira do not keep
  the order.
- Setup: test job topo2 (6 integrals, s <= 1, Vqqbg collection) on the laptop, 149 s.
- Vqqbg alone: s <= 4 ((k1+k2)^2 up to the third power), no dots, top sector = all 8 box lines in every family.

## After the reduction: tables and insertion
```
MATH=math python3 to_form.py                     # jobs/topoN/results/topoN.m -> tables/red_topoN.inc (not in git)
cd ../Code_RVV_1L1L/Scripts && source ../setenv.sh
python3 tools/insert_reductions.py [--channels Vqqbg] [--pieces vv] [--jobs 2]
                                                 # tmp/unreduced/<piece>/unreduced<PROJ>.ff -> tmp/reduced/<piece>/reduced<PROJ>.ff
```
- `to_form.py`: per family, Mathematica puts every coefficient over a common denominator (Reduze substitutes s, t, m2
  -> z, u on export without normalising, e.g. Den(s - m2) -> Den(-1 + Den(z))), then the table
  `Fill RED<N>(n1..n9) = sum ML1(k1 master)*ML1C(k2 master)*RAT(num, den)`. A master INT(topoN, a1..a4, b1..b4, 0)
  is the product of a one-loop integral of box A in k1 (amplitude) and one of box B in k2 (conjugate: ML1C = complex
  conjugate), N = 3 (A - 1) + B; (k1+k2)^2 powers in a master are an error. One-loop names: B12, B13, B23, B123 =
  bubbles in (p1+p2)^2, (p1+r1)^2, (p2+r1)^2, q^2 (the same integral in every box ordering), BOX1..3 = the boxes,
  L1(A, a1..a4) otherwise.
- `insert_reductions.py`: applies the tables (FORM stops if an integral is missing), coefficients as one PolyRatFun
  RAT(num, den) in z, u, d per master product, bracketed in ML1, ML1C.
- Test (2026-10-23): Vqqbg aPSaPS of 1L x 1L (212 integrals, topo1, job `topo1_aPSaPS`, 169 s): 4 masters
  {B12, B123} x {B12, B123}*; the coefficient matrix is symmetric under amplitude <-> conjugate masters (the piece
  is its own conjugate), checked in FORM with a negative control.
