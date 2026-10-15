---
name: kira-reductions
description: Generate, run, monitor and stop the Kira IBP-reduction jobs of the DY N3LO triple-real (RRR) integrals in RRR_reductions/ (families grouped 4 per job). Use when the user asks to (re)group families, (re)generate Kira jobs, change the Kira kinematics or job options, move jobs to the cluster, run several groups at once, check or kill running reductions.
---

# Kira reductions of the RRR integrals

Folder `RRR_reductions/` (repository root, next to `Code_RRR/`); generator `make_jobs.py`, details in its docstring and
`RRR_reductions/README.md`. Strategy: stage 1 = one Kira job per group of 4 families, reduced to masters within the
group; stage 2 = one low-rank reduction of all families to relate masters across groups (not written yet); then the
insertion in FORM.

## Commands (laptop, light: pure Python, seconds)

```
cd RRR_reductions
python3 make_jobs.py group                    # -> groups.txt (39 groups; editable by hand)
python3 make_jobs.py jobs                     # groups.txt -> jobs/<group>/
python3 make_jobs.py jobs --only g01,g02      # only some groups
python3 make_jobs.py jobs --merge-rs          # one reduce entry per family (max r, s) instead of one per top sector
python3 make_jobs.py jobs --collection gluons # another Code_RRR/integrals/<collection>
```
Inputs (must exist): `Code_RRR/integrals/<collection>/kira/topoN.txt` and `analysis/{topsectors,sectors}.csv`, from
`Code_RRR/Scripts/run_all.py integrals [--merge]` and `Code_RRR/integrals/Tools/analyse_integrals.py <collection>`.
`integrals/all` (the merge of gluons + quarks) exists only on the laptop.

## Conventions (keep them; checked)

- Kira loop momenta r1, r2, r3 = -p4, -p5, -p6 of Code_RRR. Propagators 1-5 cut: r1^2, r2^2, r3^2,
  (p1+p2+r1+r2+r3)^2 - m2, bilinear (-p1-p2-r1-r2-r3).(-p1+u*p2); 6-12 the regular DDs in the INT order of
  `Code_RRR/Families/fams/reconstruct.inc` (momenta from `find_circuits.REGULAR`). Verified numerically against
  `Families/integralfamilies.rrr.m` for all 921 families: re-check like that after any change of the propagators.
- Kinematics as n3lo_old: invariants m2, s12, u; p1.p2 = s12/2; m2 replaced by 1. Our families have s12 = m2/z:
  substitute s12 -> 1/z when reading Kira's tables into FORM (before PolyRatFun).
- Sector ID = sum of 2^(i-1) over the 12 positions (Kira's), as in analyse_integrals.py. r, s per top sector = maxima
  over its tree of occurring subsectors (`r_tree`, `s_tree`).
- Grouping: similarity of two families = number of occurring sectors they share up to permutations of r1, r2, r3
  (the relabellings Kira's run_symmetries can use; cut and rapidity lines are r-symmetric; no p1 <-> p2, broken by u).
  Greedy + pairwise swaps. A proxy, not Kira's own symmetry finder; groups are not balanced in load.

## Cluster (newton1 / newton4, no scheduler, repo /scratch/ge45tuy/DY_P2B)

Configs come with `git pull`; `toreduce/` and Kira's output are gitignored, so the integral lists go by rsync from the
laptop: `rsync -av RRR_reductions/jobs/ ge45tuy@newton4:/scratch/ge45tuy/DY_P2B/RRR_reductions/jobs/`.
`kira` must be on PATH there (`which kira`, `kira --version`).

```
cd /scratch/ge45tuy/DY_P2B/RRR_reductions/jobs/g01
KIRA_THREADS=4 nohup ./run.sh &          # nice 19; Kira's log in kira.out (nohup.out stays empty)
# several groups, N at a time (N x threads < nproc, N x RES < RAM):
cd .. ; ls -d g* | nohup xargs -P 4 -I{} env KIRA_THREADS=4 {}/run.sh > ../batch.log 2>&1 &
```
Monitor: `tail -f kira.out`; `for d in g*; do printf '%s  ' $d; tail -n1 $d/kira.out 2>/dev/null || echo -; done`;
`pgrep -u ge45tuy -a -x kira`; `top -u ge45tuy`.
Stop: kill xargs first, then Kira, then check helpers: `pkill -u ge45tuy -x xargs; pkill -u ge45tuy -x kira;
pgrep -u ge45tuy -a 'kira|fer64|ferl64'`. Restart a group cleanly: in its folder
`rm -rf sectors results tmp firefly_saves kira.out` (keep config/, toreduce/, jobs.yaml, run.sh).
Never regenerate (`make_jobs.py jobs`) or rsync over a group that is running.

## Open points

- Untested: whether Kira accepts the same topology in several `reduce` entries (one per top sector); if not, use
  `--merge-rs`.
- What to read from a first run: symmetries found between the 4 families, masters per group, memory (RES), time of
  initiate vs FireFly.
- Possible improvement of the grouping: count all subsectors of the top sectors, weight shared sectors by #lines.
