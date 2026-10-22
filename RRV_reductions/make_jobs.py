#!/usr/bin/env python3
"""Kira reduction jobs for the real-real-virtual (RRV) integrals, a few families per job (RRV version of
RRR_reductions/make_jobs.py).

    python3 make_jobs.py group [--size 4] [--collection all]   # -> groups.txt (edit it by hand if you like)
    python3 make_jobs.py jobs  [--collection all] [--only g01,g02]   # groups.txt -> jobs/<group>/
    python3 make_jobs.py test  --only g01 [--max-s 1] [--max-dots 0] [--max-lines 12] [--max-ints 0]  # -> jobs/g01_test/
    python3 make_jobs.py test  --fams 1,7 --name g00 --max-s 0 --max-lines 8   # any families -> jobs/g00_test/

Inputs (nothing is changed there):
  ../Code_RRV/Families/integralfamilies_r.rrv.m   the 77 families: DD numbers in INT order, DD[n] -> Den[momentum]
  ../Code_RRV/integrals/<collection>/kira/topoN.txt             integrals to reduce, Kira notation
  ../Code_RRV/integrals/<collection>/analysis/topsectors.csv    top sectors with r, s over their trees
  ../Code_RRV/integrals/<collection>/analysis/sectors.csv       all occurring sectors (for the grouping)
  (the last two from Code_RRV/integrals/Tools/analyse_integrals.py <collection>)

Families: 12 propagators = 4 cut (r1^2, r2^2, (p1+p2+r1+r2)^2 - m2, the rapidity (-p1-p2-r1-r2).(-p1+u p2)) +
  3 RR propagators (DD5..DD13, k1-free) + 5 loop propagators (DD14..DD29 = (k1 + S)^2); loop momenta r1, r2, k1
  (all incoming, as in FORM: q = -p1-p2-r1-r2).
group: families with many common sectors go together, so that a job reduces them down to a common set of masters.
  Two sectors are "common" when their regular propagators are the same up to r1 <-> r2 (cut propagators and
  rapidity line are symmetric in r1, r2). Greedy + pairwise swaps, as for RRR.
jobs: per group jobs/<group>/ with config/integralfamilies.yaml, config/kinematics.yaml, jobs.yaml, toreduce/topoN.txt,
  run.sh. reduce_sectors lists every top sector with its own r, s (maxima over its tree).
test: a cheap job to check the setup on one group (see RRR_reductions/make_jobs.py).
"""
import argparse
import csv
import itertools
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CODE = os.path.join(HERE, "..", "Code_RRV")
FAMDIR = os.path.join(CODE, "Families")
NCUT = 4
NREG = 8


def read_families():
    """DD number -> momentum (e.g. 'k1+p1+p2'), family -> its 8 regular DD numbers in INT order (indices 5..12)"""
    text = open(os.path.join(FAMDIR, "integralfamilies_r.rrv.m")).read()
    mom = {int(n): m.split(",")[0].strip() for n, m in re.findall(r"DD\[(\d+)\] -> Den\[([^\]]*)\]", text)}
    block = text[text.index("{\n{") + 2: text.index("},\n{\n DD[1] ->")]
    fams = [[int(x) for x in re.findall(r"DD\[(\d+)\]", f)] for f in re.findall(r"\{([^{}]*)\}", block)]
    order = {n + 1: [dd for dd in f if dd > NCUT] for n, f in enumerate(fams)}
    if any(f[:NCUT] != [1, 2, 3, 4] for f in fams):
        sys.exit("integralfamilies_r.rrv.m: the first 4 propagators of a family are not DD1..DD4")
    return mom, order


MOM, ORDER = read_families()
LEGSET = {dd: frozenset(m.split("+")) for dd, m in MOM.items() if dd > NCUT}      # e.g. {'k1', 'p1', 'r2'}
DD_OF = {v: k for k, v in LEGSET.items()}
R_PERMS = [{}, {"r1": "r2", "r2": "r1"}]

CUT = """     - [ "r1", 0]
     - [ "r2", 0]
     - [ "p1+p2+r1+r2", m2]
     - { bilinear: [ ["-p1-p2-r1-r2", "-p1+u*p2"], 0 ] }
"""
KINEMATICS = """kinematics:
 incoming_momenta: [p1, p2, p3]
 outgoing_momenta: []
 momentum_conservation: [p3, -p1-p2]
 kinematic_invariants:
  - [m2, 2]
  - [s12, 2]
  - [u, 0]
 scalarproduct_rules:
  - [[p1,p1], 0]
  - [[p2,p2], 0]
  - [[p1,p2], s12/2]
 symbol_to_replace_by_one: m2
"""
RUN = """#!/bin/bash
# Kira reduction of group {group}: {fams}
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${{KIRA_THREADS:-4}} jobs.yaml > kira.out 2>&1
"""


def canonical(dds):
    """a set of regular DD numbers up to r1 <-> r2"""
    return min(tuple(sorted(DD_OF[frozenset(p.get(x, x) for x in LEGSET[d])] for d in dds)) for p in R_PERMS)


def read_csv(collection, name):
    path = os.path.join(CODE, "integrals", collection, "analysis", name)
    if not os.path.exists(path):
        sys.exit(f"{path} missing: run Code_RRV/integrals/Tools/analyse_integrals.py {collection} first")
    return list(csv.DictReader(open(path)))


def fam_num(topo):
    return int(topo[4:])


def sector_dds(sector, order):
    """sector ID (sum of 2^(i-1) over the 12 positions) -> its regular DD numbers"""
    return [order[k] for k in range(NREG) if sector >> (NCUT + k) & 1]


def read_groups():
    path = os.path.join(HERE, "groups.txt")
    if not os.path.exists(path):
        sys.exit("groups.txt missing: run make_jobs.py group first")
    groups = []
    for line in open(path):
        line = line.split("#")[0].strip()
        if line:
            name, fams = line.split(":")
            groups.append((name.strip(), [int(x) for x in fams.split()]))
    return groups


def cmd_group(args):
    secs, load = {}, {}
    for row in read_csv(args.collection, "sectors.csv"):
        n = fam_num(row["family"])
        secs.setdefault(n, set()).add(canonical(sector_dds(int(row["sector"]), ORDER[n])))
        load[n] = load.get(n, 0) + int(row["n_int"])
    fams = sorted(secs)
    common = {(a, b): len(secs[a] & secs[b]) for a in fams for b in fams}
    todo, groups = set(fams), []
    while todo:
        g = [max(todo, key=lambda n: (load[n], -n))]
        todo.discard(g[0])
        while len(g) < args.size and todo:
            nxt = max(todo, key=lambda n: (sum(common[n, m] for m in g), -load[n], -n))
            g.append(nxt)
            todo.discard(nxt)
        groups.append(g)
    score = lambda gs: sum(common[a, b] for g in gs for a, b in itertools.combinations(g, 2))
    improved = True                                   # then swap families between groups while that helps
    while improved:
        improved = False
        for gi, gj in itertools.combinations(groups, 2):
            for a, b in itertools.product(range(len(gi)), range(len(gj))):
                old = score([gi, gj])
                gi[a], gj[b] = gj[b], gi[a]
                if score([gi, gj]) > old:
                    improved = True
                else:
                    gi[a], gj[b] = gj[b], gi[a]
    groups = sorted(sorted(g) for g in groups)
    width = len(str(len(groups)))
    with open(os.path.join(HERE, "groups.txt"), "w") as f:
        f.write(f"# groups of the {len(fams)} RRV families of Code_RRV/integrals/{args.collection} (make_jobs.py group "
                f"--size {args.size}); one job per line, 'name: family numbers'. Editable.\n")
        f.write(f"# common sectors within groups, summed: {score(groups)}\n")
        f.write("# comment: #integrals, #occurring sectors (up to r1 <-> r2) in the union, common sectors summed over pairs\n")
        for i, g in enumerate(groups, 1):
            union = set().union(*(secs[n] for n in g))
            pairs = sum(common[a, b] for a, b in itertools.combinations(g, 2))
            f.write(f"g{i:0{width}d}: {' '.join(map(str, g)):<16}  # {sum(load[n] for n in g):6d} int, "
                    f"{len(union):4d} sectors, {pairs:4d} common\n")
    print(f"{len(groups)} groups -> groups.txt")


def cmd_jobs(args):
    tops = {}
    for row in read_csv(args.collection, "topsectors.csv"):
        tops.setdefault(fam_num(row["family"]), []).append((int(row["sector"]), int(row["r_tree"]), int(row["s_tree"])))
    kira = os.path.join(CODE, "integrals", args.collection, "kira")
    groups = read_groups()
    if args.only:
        groups = [g for g in groups if g[0] in args.only.split(",")]
    placed = [n for _, g in read_groups() for n in g]
    missing = sorted(set(tops) - set(placed))
    if missing or len(placed) != len(set(placed)):
        print(f"warning: families not in groups.txt: {missing}; placed twice: "
              f"{sorted({n for n in placed if placed.count(n) > 1})}")
    for name, fams in groups:
        lists = {n: open(os.path.join(kira, f"topo{n}.txt")).read().splitlines() for n in fams}
        write_job(name, fams, {n: tops[n] for n in fams}, lists, f"Code_RRV/integrals/{args.collection}; make_jobs.py")
    print(f"-> jobs/ ({len(groups)} jobs)")


def write_job(name, fams, tops, lists, note):
    """jobs/<name>/: config, jobs.yaml, run.sh, toreduce/topoN.txt; tops = family -> [(sector, r, s)],
    lists = family -> integrals (Kira notation)"""
    d = os.path.join(HERE, "jobs", name)
    for sub in ("config", "toreduce"):
        os.makedirs(os.path.join(d, sub), exist_ok=True)
    with open(os.path.join(d, "config", "integralfamilies.yaml"), "w") as f:
        f.write("integralfamilies:\n")
        for n in fams:
            f.write(f"\n  - name: \"topo{n}\"\n    loop_momenta: [r1, r2, k1]\n    propagators:\n")
            f.write(CUT)
            for dd in ORDER[n]:
                f.write(f"     - [ \"{MOM[dd]}\", 0]   # DD{dd} ({'loop' if 'k1' in LEGSET[dd] else 'RR'})\n")
            f.write("    cut_propagators: [1, 2, 3, 4]\n")
    with open(os.path.join(d, "config", "kinematics.yaml"), "w") as f:
        f.write(KINEMATICS)
    reduce = []
    for n in fams:
        ts = sorted(tops[n], key=lambda x: (-bin(x[0]).count("1"), x[0]))
        reduce += [f"{{topologies: [topo{n}], sectors: [{t[0]}], r: {t[1]}, s: {t[2]}}}" for t in ts]
        with open(os.path.join(d, "toreduce", f"topo{n}.txt"), "w") as f:
            f.write("".join(x + "\n" for x in lists[n]))
    targets = "".join(f"       - [topo{n}, toreduce/topo{n}.txt]\n" for n in fams)
    with open(os.path.join(d, "jobs.yaml"), "w") as f:
        f.write(f"# group {name}: RRV families {' '.join(map(str, fams))} ({note})\n"
                "jobs:\n - reduce_sectors:\n    conditional: true\n    reduce:\n")
        f.write("".join(f"     - {x}\n" for x in reduce))
        f.write("    select_integrals:\n      select_mandatory_list:\n")
        f.write(targets.replace("       -", "        -"))
        f.write("    run_symmetries: true\n    run_initiate: true\n    run_triangular: false\n"
                "    run_firefly: true\n    run_back_substitution: false\n")
        f.write(" - kira2math:\n    target:\n" + targets + "    reconstruct_mass: false\n")
        f.write(" - kira2form:\n    target:\n" + targets + "    reconstruct_mass: false\n")
    with open(os.path.join(d, "run.sh"), "w") as f:
        f.write(RUN.format(group=name, fams=" ".join(f"topo{n}" for n in fams)))
    os.chmod(os.path.join(d, "run.sh"), 0o755)
    print(f"{name}: topo{' topo'.join(map(str, fams))}  {len(reduce)} reduce entries, "
          f"{sum(len(x) for x in lists.values())} integrals")


def parse_int(line):
    """'topo1[1,1,0,-2,...]' -> (sector, t, r, s); sector = sum of 2^(i-1) over the positive indices"""
    a = [int(x) for x in line[line.index("[") + 1:line.index("]")].split(",")]
    pos = [i for i, x in enumerate(a) if x > 0]
    return sum(1 << i for i in pos), len(pos), sum(a[i] for i in pos), -sum(x for x in a if x < 0)


def cmd_test(args):
    if args.fams:
        groups = [(args.name or "g00", [int(x) for x in args.fams.split(",")])]
    else:
        groups = [g for g in read_groups() if args.only and g[0] in args.only.split(",")]
    if not groups:
        sys.exit("test: give the group(s) with --only, e.g. --only g01, or the families with --fams 1,7 [--name g00]")
    kira = os.path.join(CODE, "integrals", args.collection, "kira")
    for name, fams in groups:
        lists, tops = {}, {}
        for n in fams:
            sel = [(line, parse_int(line)) for line in open(os.path.join(kira, f"topo{n}.txt")).read().split()]
            sel = [(line, p) for line, p in sel if p[3] <= args.max_s and p[2] - p[1] <= args.max_dots
                   and p[1] <= args.max_lines]
            if args.max_ints:   # a few per family: one per sector in turn, highest rank first
                by = {}
                for line, p in sorted(sel, key=lambda x: (-x[1][3], x[1][1] - x[1][2], x[0])):
                    by.setdefault(p[0], []).append((line, p))
                queues = [by[k] for k in sorted(by)]
                sel = [q[i] for i in range(max(map(len, queues), default=0)) for q in queues if i < len(q)]
                sel = sel[:args.max_ints]
            lists[n] = [line for line, _ in sel]
            secs = {p[0] for _, p in sel}
            top = [x for x in secs if not any(y != x and x & y == x for y in secs)]
            tops[n] = []
            for x in top:
                tree = [p for _, p in sel if p[0] & x == p[0]]
                tops[n].append((x, max(bin(x).count("1"), max(p[2] for p in tree)), max(p[3] for p in tree)))
        write_job(name + "_test", fams, tops, lists,
                  f"TEST: s <= {args.max_s}, dots <= {args.max_dots}, lines <= {args.max_lines}, max "
                  f"{args.max_ints or 'all'} per family; Code_RRV/integrals/{args.collection}; make_jobs.py test")
    print("-> jobs/ (test)")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("command", choices=["group", "jobs", "test"])
    ap.add_argument("--collection", default="all", help="Code_RRV/integrals/<collection> (default all)")
    ap.add_argument("--size", type=int, default=4, help="families per job (group; default 4)")
    ap.add_argument("--only", help="jobs, test: comma-separated group names")
    ap.add_argument("--max-s", type=int, default=1, help="test: keep integrals with numerator rank s <= this (default 1)")
    ap.add_argument("--max-dots", type=int, default=0, help="test: keep integrals with at most this many dots (default 0)")
    ap.add_argument("--max-lines", type=int, default=12, help="test: keep integrals with at most this many lines (default 12)")
    ap.add_argument("--max-ints", type=int, default=0, help="test: keep only this many integrals per family (0 = all)")
    ap.add_argument("--fams", help="test: comma-separated family numbers instead of a group of groups.txt")
    ap.add_argument("--name", help="test with --fams: job name (default g00) -> jobs/<name>_test")
    args = ap.parse_args()
    {"group": cmd_group, "jobs": cmd_jobs, "test": cmd_test}[args.command](args)


if __name__ == "__main__":
    main()
