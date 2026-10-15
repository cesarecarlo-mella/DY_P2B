# RRR_reductions: IBP reduction of the triple-real integrals with Kira

Strategy
1. **Groups** (this folder, now): 4 families per Kira job, so that each job reduces its families down to masters
   common to the 4. Families are grouped by common sectors (`make_jobs.py group`).
2. **Mega reduction** (later): all families together at low rank, to relate the masters of the different groups.
3. **Insertion**: in FORM (tables per family, PolyRatFun), Mathematica only at the end.

## Commands

```
python3 make_jobs.py group          # -> groups.txt: 39 groups of 4 of the 156 families (editable by hand)
python3 make_jobs.py jobs           # groups.txt -> jobs/<group>/
python3 make_jobs.py jobs --only g01,g02
jobs/g01/run.sh                     # kira --parallel=$KIRA_THREADS (default 4), nice 19, log in kira.out
```

## Running all groups: `run_reductions.py`
```
nohup python3 run_reductions.py run --parallel 5 --threads 4 > /dev/null 2>&1 &   # all groups, 5 at a time
python3 run_reductions.py status        # per group: status, wall, CPU h, cores in use, RAM now / peak, masters
python3 run_reductions.py stats         # totals, CPU s per integral, peak RAM, estimate of what is left
python3 run_reductions.py stop          # stops the driver and its Kira jobs (they are requeued)
tail -f run_state/driver.log
```
Largest groups first; finished groups are skipped on the next `run` (failed ones only with `--retry-failed`).
CPU and RAM of each job are sampled over its whole process tree (Kira + Fermat) every `--interval` s
(`run_state/samples/<group>.csv`); `--min-free-gb N` starts a job only with N GB of available memory.
After a hard kill of the driver, the next `run` kills the orphaned Kira jobs and requeues them.
Options and details: `python3 run_reductions.py -h`. `run_state/` is not in git.
Input: `Code_RRR/integrals/all/` (`run_all.py integrals --merge`, then
`integrals/Tools/analyse_integrals.py all`): `kira/topoN.txt` (integrals to reduce) and `analysis/topsectors.csv`
(top sectors with r, s = maxima over their trees). Another collection: `--collection gluons`.

## Per job, `jobs/<group>/`
- `config/integralfamilies.yaml`: loop momenta r1, r2, r3 (= -p4, -p5, -p6 of Code_RRR); propagators 1-5 cut:
  r1^2, r2^2, r3^2, (p1+p2+r1+r2+r3)^2 - m2, the rapidity (-p1-p2-r1-r2-r3).(-p1+u p2); 6-12 the regular ones in the
  INT order of `Families/fams/reconstruct.inc` (DD number as comment). Checked numerically against
  `Families/integralfamilies.rrr.m` for all 921 families.
- `config/kinematics.yaml`: as in n3lo_old: invariants m2, s12, u; p1.p2 = s12/2; m2 -> 1.
  **Our families use s12 = m2/z**: in the results set s12 -> 1/z (m2 = 1).
- `jobs.yaml`: `reduce_sectors` with one entry per top sector and its own r, s (`--merge-rs`: one entry per family
  with the maxima, as in n3lo_old), `select_mandatory_list` = `toreduce/topoN.txt`, symmetries on, FireFly
  reconstruction, then `kira2math` and `kira2form`.
- `toreduce/` (not in git, copied from `Code_RRR/integrals/all/kira/`) and Kira's output (not in git).

The jobs folder with the integral lists to the cluster: `rsync -a jobs/ newton4:/scratch/ge45tuy/DY_P2B/RRR_reductions/jobs/`.
