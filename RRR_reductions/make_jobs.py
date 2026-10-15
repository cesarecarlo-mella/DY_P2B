#!/usr/bin/env python3
"""Kira reduction jobs for the triple-real (RRR) integrals, a few families per job.

    python3 make_jobs.py group [--size 4] [--collection all]   # -> groups.txt (edit it by hand if you like)
    python3 make_jobs.py jobs  [--collection all] [--merge-rs] [--only g01,g02]   # groups.txt -> jobs/<group>/

Inputs (nothing is changed there):
  ../Code_RRR/Families/fams/reconstruct.inc      INT order of every family (DD numbers of indices 6..12)
  ../Code_RRR/Families/find_circuits.py          REGULAR: DD6..DD29 as sums of incoming legs
  ../Code_RRR/integrals/<collection>/kira/topoN.txt             integrals to reduce, Kira notation
  ../Code_RRR/integrals/<collection>/analysis/topsectors.csv    top sectors with r, s over their trees
  ../Code_RRR/integrals/<collection>/analysis/sectors.csv       all occurring sectors (for the grouping)
  (the last two from Code_RRR/integrals/Tools/analyse_integrals.py <collection>)

group: families with many common sectors go together, so that a job reduces them down to a common set of masters.
  Two sectors are "common" when their regular propagators are the same up to a permutation of r1, r2, r3 (the
  relabellings Kira finds with run_symmetries); the cut propagators and the rapidity line are symmetric in r1, r2, r3.
  Greedy: the heaviest family not yet placed (most integrals) starts a group, then the family with the most common
  sectors with the group so far is added (ties: the lighter one), until the group has --size families; then two
  families of different groups are swapped as long as that increases the common sectors within the groups.
jobs: per group jobs/<group>/ with config/integralfamilies.yaml, config/kinematics.yaml, jobs.yaml, toreduce/topoN.txt,
  run.sh. reduce_sectors lists every top sector with its own r, s (maxima over its tree); --merge-rs uses one entry
  per family with the maxima over its top sectors (the old n3lo_old setup).
"""
import argparse
import csv
import itertools
import os
import re
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CODE = os.path.join(HERE, "..", "Code_RRR")
FAMDIR = os.path.join(CODE, "Families")
sys.path.insert(0, FAMDIR)
from find_circuits import REGULAR  # noqa: E402

SPLIT = {6 + i: frozenset(m.split("+")) for i, m in enumerate(REGULAR)}   # DD number -> legs on its non-q side
DD_OF = {v: k for k, v in SPLIT.items()}
R_PERMS = [dict(zip(("r1", "r2", "r3"), p)) for p in itertools.permutations(("r1", "r2", "r3"))]

CUT = """     - [ "r1", 0]
     - [ "r2", 0]
     - [ "r3", 0]
     - [ "p1+p2+r1+r2+r3", m2]
     - {{ bilinear: [ ["-p1-p2-r1-r2-r3", "-p1+u*p2"], 0 ] }}
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


def int_order():
    """family -> its 7 regular DD numbers in the order of the INT indices 6..12"""
    out = {}
    for line in open(os.path.join(FAMDIR, "fams", "reconstruct.inc")):
        m = re.match(r"id TOPO\((\d+)\)/DD1/DD2/DD3/DD4/DD5/(.*) = INT\(topo\d+,", line)
        if m:
            out[int(m.group(1))] = [int(x) for x in re.findall(r"DD(\d+)\^", m.group(2))]
    return out


def canonical(dds):
    """a set of regular DD numbers up to permutations of r1, r2, r3"""
    return min(tuple(sorted(DD_OF[frozenset(p.get(x, x) for x in SPLIT[d])] for d in dds)) for p in R_PERMS)


def read_csv(collection, name):
    path = os.path.join(CODE, "integrals", collection, "analysis", name)
    if not os.path.exists(path):
        sys.exit(f"{path} missing: run Code_RRR/integrals/Tools/analyse_integrals.py {collection} first")
    return list(csv.DictReader(open(path)))


def fam_num(topo):
    return int(topo[4:])


def sector_dds(sector, order):
    """sector ID (sum of 2^(i-1) over the 12 positions) -> its regular DD numbers"""
    return [order[k] for k in range(7) if sector >> (5 + k) & 1]


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
    order = int_order()
    secs, load = {}, {}
    for row in read_csv(args.collection, "sectors.csv"):
        n = fam_num(row["family"])
        secs.setdefault(n, set()).add(canonical(sector_dds(int(row["sector"]), order[n])))
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
        f.write(f"# groups of the {len(fams)} families of integrals/{args.collection} (make_jobs.py group --size "
                f"{args.size}); one job per line, 'name: family numbers'. Editable.\n")
        f.write(f"# common sectors within groups, summed: {score(groups)}\n")
        f.write("# comment: #integrals, #occurring sectors (up to r1,r2,r3 permutations) in the union, "
                "common sectors summed over pairs\n")
        for i, g in enumerate(groups, 1):
            union = set().union(*(secs[n] for n in g))
            pairs = sum(common[a, b] for a, b in itertools.combinations(g, 2))
            f.write(f"g{i:0{width}d}: {' '.join(map(str, g)):<20}  # {sum(load[n] for n in g):6d} int, "
                    f"{len(union):4d} sectors, {pairs:4d} common\n")
    print(f"{len(groups)} groups -> groups.txt")


def cmd_jobs(args):
    order = int_order()
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
        d = os.path.join(HERE, "jobs", name)
        for sub in ("config", "toreduce"):
            os.makedirs(os.path.join(d, sub), exist_ok=True)
        with open(os.path.join(d, "config", "integralfamilies.yaml"), "w") as f:
            f.write("integralfamilies:\n")
            for n in fams:
                f.write(f"\n  - name: \"topo{n}\"\n    loop_momenta: [r1, r2, r3]\n    propagators:\n")
                f.write(CUT.format())
                for dd in order[n]:
                    f.write(f"     - [ \"{REGULAR[dd - 6]}\", 0]   # DD{dd}\n")
                f.write("    cut_propagators: [1, 2, 3, 4, 5]\n")
        with open(os.path.join(d, "config", "kinematics.yaml"), "w") as f:
            f.write(KINEMATICS)
        reduce = []
        for n in fams:
            ts = sorted(tops[n], key=lambda x: (-bin(x[0]).count("1"), x[0]))
            if args.merge_rs:
                reduce.append(f"{{topologies: [topo{n}], sectors: [{', '.join(str(t[0]) for t in ts)}], "
                              f"r: {max(t[1] for t in ts)}, s: {max(t[2] for t in ts)}}}")
            else:
                reduce += [f"{{topologies: [topo{n}], sectors: [{t[0]}], r: {t[1]}, s: {t[2]}}}" for t in ts]
            shutil.copy(os.path.join(kira, f"topo{n}.txt"), os.path.join(d, "toreduce", f"topo{n}.txt"))
        targets = "".join(f"       - [topo{n}, toreduce/topo{n}.txt]\n" for n in fams)
        with open(os.path.join(d, "jobs.yaml"), "w") as f:
            f.write(f"# group {name}: families {' '.join(map(str, fams))} (integrals/{args.collection}; make_jobs.py)\n"
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
        nint = sum(1 for n in fams for _ in open(os.path.join(kira, f"topo{n}.txt")))
        print(f"{name}: topo{' topo'.join(map(str, fams))}  {len(reduce)} reduce entries, {nint} integrals")
    print(f"-> jobs/ ({len(groups)} jobs)")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("command", choices=["group", "jobs"])
    ap.add_argument("--collection", default="all", help="Code_RRR/integrals/<collection> (default all)")
    ap.add_argument("--size", type=int, default=4, help="families per job (group; default 4)")
    ap.add_argument("--merge-rs", action="store_true", help="one reduce entry per family with the maximal r, s")
    ap.add_argument("--only", help="jobs: comma-separated group names")
    args = ap.parse_args()
    {"group": cmd_group, "jobs": cmd_jobs}[args.command](args)


if __name__ == "__main__":
    main()
