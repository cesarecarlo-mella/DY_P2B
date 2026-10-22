# RRV_reductions: IBP reduction of the real-real-virtual integrals with Kira

Same structure as RRR_reductions/ (see its README): groups of 4 families per Kira job, a mega reduction later,
insertion in FORM.

## Commands

```
python3 make_jobs.py group          # -> groups.txt: 20 groups of the 77 families (editable by hand)
python3 make_jobs.py jobs           # groups.txt -> jobs/<group>/
python3 make_jobs.py jobs --only g01,g02
python3 make_jobs.py test --only g01 --max-s 1 --max-dots 0     # cheap check of the setup -> jobs/g01_test/
jobs/g01/run.sh                     # kira --parallel=$KIRA_THREADS (default 4), nice 19, log in kira.out
nohup python3 run_reductions.py run --parallel 5 --threads 4 > /dev/null 2>&1 &   # all groups (as for RRR)
python3 run_reductions.py status | stats | stop
```

Input: `Code_RRV/integrals/all/` (`run_all.py integrals --set all` on newton, then
`Code_RRV/integrals/Tools/analyse_integrals.py all`): `kira/topoN.txt` (integrals to reduce: 354990 in 77 families)
and `analysis/topsectors.csv` (448 top sectors with r, s = maxima over their trees; maxima t = 11, s = 6, dots = 3).

## Per job, `jobs/<group>/`
- `config/integralfamilies.yaml`: loop momenta r1, r2, k1 (all incoming, as in FORM; q = -p1-p2-r1-r2);
  propagators 1-4 cut: r1^2, r2^2, (p1+p2+r1+r2)^2 - m2, the rapidity (-p1-p2-r1-r2).(-p1+u p2) (bilinear);
  5-12 the regular ones in the INT order of `Code_RRV/Families/integralfamilies_r.rrv.m` (DD number and RR / loop
  as comment): 3 RR propagators (k1-free) and 5 loop propagators (k1 + S)^2.
- `config/kinematics.yaml`: as for RRR: invariants m2, s12, u; p1.p2 = s12/2; m2 -> 1 (s12 = m2/z).
- `jobs.yaml`: `reduce_sectors` with one entry per top sector and its own r, s, `select_mandatory_list` =
  `toreduce/topoN.txt`, symmetries on, FireFly reconstruction, then `kira2math` and `kira2form`.
- `toreduce/` (not in git, copied from `Code_RRV/integrals/all/kira/`) and Kira's output (not in git).

## To check on the first (test) job
- Every family is initiated, and `results/` has a table for every family.
- Symmetries: RRV is (one-loop amplitude) x (tree conjugate), the cross section takes 2 Re(...) after the masters,
  so symmetries of the k1 loop and the r1 <-> r2 relabelling are allowed. Check in `kira.out` that no symmetry maps
  the loop momentum k1 onto a cut momentum r1, r2 (cut propagators must map onto cut propagators).
- The 8 top sectors with a single loop propagator (topo7, topo21: k1^2 alone, scaleless) must come out zero.

The jobs folder with the integral lists to the cluster:
`rsync -a jobs/ ge45tuy@newton4.t30.ph.tum.de:/scratch/ge45tuy/DY_P2B/RRV_reductions/jobs/`.
