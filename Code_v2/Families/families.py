#!/usr/bin/env python3
"""Integral families for the triple-real propagator sets.

  python3 families.py [--keep-old] [--no-symmetry | --exact]   (after collect_props.py, find_circuits.py,
                                                                pf_identities.wl; then families.wl)
  python3 families.py --extend    keep the families of families_raw.m (and family_origin.m) unchanged as FAM[1..N]
                                  and append new families (complete relabelling groups) for the tails in none of them
  default        all families chosen from scratch with the relabelling symmetry r1, r2, r3 in mind (step 3 below)
  --keep-old     keep the 284 families of the old notebook as FAM[1..284] (277 independent instead of 154)
  --no-symmetry  plain greedy choice, family by family (gave 1010 families, 474 independent under relabelling)
  --exact        exact minimum set cover without symmetry (cover.wl, Mathematica integer programming; slow)

Method as in n3lo_old/RRR/Families_Identification/Triple_Real_Families.nb ("Define Integral families"):
 1. EVERY collected product of the channels (products[P]) is split with the partial-fraction identities
    (pfid_sets.m, pfid_squared.m) exactly in FORM's order (pfsim.py): a set containing all propagators of an
    identity -> the subsets missing one of them, except the propagator the identity squares (identities with zero
    constant), until no set contains an identity; only then sets contained in another set are dropped -> "tails".
    (Until 2026-10-14 only allMaxProducts were split and subsets were dropped before/while splitting: a smaller
    product containing a zero-constant identity except its squared propagator was lost -> 12 sets in no family,
    fixed by --extend, FAM[910..].)
 2. with --keep-old: the 284 families of the old notebook (its Families.m) are kept unchanged as FAM[1..284]
 3. tails in no old family get new families (default, with the relabelling symmetry in mind):
    a. tails that fit a relabelled copy (r1, r2, r3 permuted) of an old family that is not among the 284: those
       copies are added (they map back onto old families, no new independent family)
    b. representatives for the remaining tails: longest tail first, completed with regular propagators to
       5 cut + 7 regular, linearly independent in the 12 scalar products (rank 12); among the completions the one
       containing most remaining tails, counting a tail as contained if one of its relabelled copies is
    c. all relabelled copies of the representatives are added, so every tail fits a family as it is and the new
       families come in complete relabelling groups (one independent family per group)
    --no-symmetry: as in the notebook, family by family (b. without copies), unneeded new families dropped.
Ranks are computed exactly over the rationals at two generic values of u; families.wl redoes them symbolically.

Writes  families_raw.m   {{DD numbers of FAM[1]}, ...}   (families.wl turns it into Families.m)
        tails.m          {{DD numbers}, ...}
        tailFamily.m     {{DD numbers} -> n, ...}  (a family n containing the tail)
        family_origin.m  {n -> "old" | "representative" | {"copy", k, {s1, s2, s3}}}: family n = family k with
                         r_i -> r_{s_i} (default mode only)
"""
import itertools, os, re, subprocess, sys
from fractions import Fraction

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import collect_props as cp
from find_circuits import REGULAR, DD
from pfsim import final_sets, read_pf

OLD_FAMILIES = os.path.join(HERE, "..", "..", "n3lo_old", "RRR", "Families_Identification", "Families.m")
CUT = (1, 2, 3, 4, 5)
NDD = 29


def sp_coefficients(u):
    """Linear part of DD1..DD29 in sp(p1,r1..3), sp(p2,r1..3), sp(ri,ri), sp(r1,r2), sp(r1,r3), sp(r2,r3)."""
    def square(a, b, c):
        return ([2 * a * x for x in c] + [2 * b * x for x in c] + [x * x for x in c]
                + [2 * c[i] * c[j] for i, j in ((0, 1), (0, 2), (1, 2))])
    rows = {1: square(0, 0, (1, 0, 0)), 2: square(0, 0, (0, 1, 0)), 3: square(0, 0, (0, 0, 1)),
            4: square(1, 1, (1, 1, 1)),
            5: [1, 1, 1, -u, -u, -u, 0, 0, 0, 0, 0, 0]}          # -q.p1 + u q.p2, q = -p1-p2-r1-r2-r3
    for vec, n in DD.items():
        rows[n] = square(vec[0], vec[1], vec[2:])
    return rows


def rank(rows):
    m = [[Fraction(x) for x in r] for r in rows]
    r = 0
    for col in range(len(m[0])):
        piv = next((i for i in range(r, len(m)) if m[i][col] != 0), None)
        if piv is None:
            continue
        m[r], m[piv] = m[piv], m[r]
        for i in range(len(m)):
            if i != r and m[i][col] != 0:
                f = m[i][col] / m[r][col]
                m[i] = [x - f * y for x, y in zip(m[i], m[r])]
        r += 1
    return r


COEF = [sp_coefficients(Fraction(7, 3)), sp_coefficients(Fraction(-11, 5))]


def full_rank(fam):
    return all(rank([c[n] for n in fam]) == 12 for c in COEF)


def mask(s):
    return sum(1 << n for n in s)


def unmask(m):
    return tuple(n for n in range(1, NDD + 1) if m >> n & 1)


def maximal(masks):
    out = []
    for m in sorted(set(masks), key=lambda x: -bin(x).count("1")):
        if not any(m & ~o == 0 for o in out):
            out.append(m)
    return out


def exact_cover(uncovered, regular):
    """Fewest rank-12 families (5 cut + 7 regular) containing all uncovered tails: integer programme in cover.wl."""
    cand = set()
    for t in uncovered:
        free = [n for n in regular if not t >> n & 1]
        for extra in itertools.combinations(free, 7 - bin(t).count("1")):
            cand.add(mask(CUT) | t | mask(extra))
    cover = {}
    for f in sorted(cand):
        if full_rank(unmask(f)):
            c = frozenset(i for i, t in enumerate(uncovered) if t & ~f == 0)
            cover.setdefault(c, f)                     # one family per distinct set of covered tails
    kept = []                                          # drop candidates whose tails are all in another candidate
    for c, f in sorted(cover.items(), key=lambda x: (-len(x[0]), x[1])):
        if not any(c <= k for k, _ in kept):
            kept.append((c, f))
    print(f"exact cover: {len(cand)} completions, {len(cover)} of rank 12 with distinct tails, {len(kept)} not dominated")
    with open(os.path.join(HERE, "cover_problem.m"), "w") as out:
        out.write("{" + str(len(uncovered)) + ", {\n  "
                  + ",\n  ".join(mlist(sorted(i + 1 for i in c)) for c, _ in kept) + "\n}}\n")
    subprocess.run(["wolframscript", "-file", os.path.join(HERE, "cover.wl")], check=True)
    chosen = [int(x) for x in re.findall(r"\d+", open(os.path.join(HERE, "cover_solution.m")).read().split("*)")[-1])]
    if not chosen or not all(1 <= k <= len(kept) for k in chosen) or \
            set().union(*(kept[k - 1][0] for k in chosen)) != set(range(len(uncovered))):
        sys.exit("exact cover: invalid solution in cover_solution.m")
    return [kept[k - 1][1] for k in chosen]


PERMS = [p for p in itertools.permutations((1, 2, 3)) if p != (1, 2, 3)]   # relabellings r_i -> r_{p_i}


def relabel(m, perm):
    """Propagator set (mask) with r_i -> r_{perm_i}: DD1..DD3 (r_i^2) permuted, DD4, DD5 unchanged."""
    inv = {n: v for v, n in DD.items()}
    out = 0
    for n in unmask(m):
        if n <= 3:
            out |= 1 << perm[n - 1]
        elif n <= 5:
            out |= 1 << n
        else:
            a, b, c = inv[n][0], inv[n][1], inv[n][2:]
            w = [a, b, 0, 0, 0]
            for i in range(3):
                w[1 + perm[i]] = c[i]
            out |= 1 << DD[tuple(w)]
    return out


def mlist(seq):
    return "{" + ", ".join(map(str, seq)) + "}"


def main():
    # 1. partial fractions, on every product, in FORM's order
    products, final = final_sets()
    sets = [mask(x) for x in products]
    pf = read_pf()[0]
    tails = maximal([mask(x) for x in final])
    dependent = [t for t in tails if not all(rank([c[n] for n in CUT + unmask(t)]) == 5 + bin(t).count("1") for c in COEF)]
    sizes = sorted({bin(t).count("1") for t in tails})
    print(f"{len(sets)} sets -> {len(tails)} tails after {len(pf)} partial-fraction identities "
          f"(sizes {[(k, sum(bin(t).count('1') == k for t in tails)) for k in sizes]})")
    print(f"tails whose propagators are still linearly dependent: {len(dependent)}")
    for t in dependent[:10]:
        print("   ", unmask(t))

    # 2. old families
    old = [tuple(map(int, re.findall(r"DD\[(\d+)\]", f)))
           for f in re.findall(r"FAM\[\d+\] -> \{([^{}]*)\}", open(OLD_FAMILIES).read())]
    if not all(len(f) == 12 and f[:5] == CUT and full_rank(f) for f in old):
        sys.exit("an old family is not 5 cut + 7 regular of rank 12")
    if "--keep-old" not in sys.argv:
        old = []
    families = [mask(f) for f in old]
    extend = "--extend" in sys.argv
    if extend:                                           # previous families kept as FAM[1..N]
        families = [mask(map(int, re.findall(r"\d+", x))) for x in
                    re.findall(r"\{([\d,\s]+)\}", open(os.path.join(HERE, "families_raw.m")).read())]
        prev_origin = []
        for m in re.finditer(r'(\d+) -> (?:"(\w+)"|\{"copy", (\d+), \{(\d), (\d), (\d)\}\})',
                             open(os.path.join(HERE, "family_origin.m")).read()):
            prev_origin.append(m.group(2) if m.group(2) else ["copy", int(m.group(3)), tuple(map(int, m.group(4, 5, 6)))])
        if len(prev_origin) != len(families):
            sys.exit("--extend: families_raw.m and family_origin.m do not match")
        prev = list(families)
    uncovered = [t for t in tails if not any(t & ~f == 0 for f in families)]
    print(f"{len(tails) - len(uncovered)} tails in the {len(old)} old families, {len(uncovered)} not")

    # 3. new families
    regular = range(6, NDD + 1)
    origin = list(prev_origin) if extend else ["old"] * len(families)
    symmetric = "--no-symmetry" not in sys.argv and "--exact" not in sys.argv
    if "--exact" in sys.argv:
        families += exact_cover(uncovered, regular)
        uncovered = []
    if symmetric:
        def fits_copy(t, f):
            return any(relabel(t, p) & ~f == 0 for p in PERMS)
        # a. relabelled copies of old families, where needed
        copies = {}
        for k, f in enumerate(families):
            for p in PERMS:
                c = relabel(f, p)
                if c not in families and c not in copies:
                    copies[c] = (k + 1, p)
        need = [t for t in uncovered if any(t & ~c == 0 for c in copies)]
        while need:
            c = max(copies, key=lambda c: (sum(1 for t in need if t & ~c == 0), -c))
            families.append(c); origin.append(["copy", *copies[c]])
            need = [t for t in need if t & ~c != 0]
        uncovered = [t for t in uncovered if not any(t & ~f == 0 for f in families)]
        print(f"3a. relabelled copies of old families added: {len(families) - len(old)}; tails left: {len(uncovered)}")
        # b. representatives
        reps = []
        left = list(uncovered)
        while left:
            t = min(left, key=lambda x: (-bin(x).count("1"), unmask(x)))
            free = [n for n in regular if not t >> n & 1]
            best, best_n = None, -1
            for extra in itertools.combinations(free, 7 - bin(t).count("1")):
                f = mask(CUT) | t | mask(extra)
                n = sum(1 for x in left if x & ~f == 0 or fits_copy(x, f))
                if n > best_n and full_rank(unmask(f)):
                    best, best_n = f, n
            if best is None:
                sys.exit(f"no rank-12 completion for {unmask(t)}")
            reps.append(best)
            left = [x for x in left if x & ~best != 0 and not fits_copy(x, best)]
        # c. representatives and all their relabelled copies
        for r in reps:
            if r not in families:
                families.append(r); origin.append("representative")
            k = families.index(r) + 1
            for p in PERMS:
                c = relabel(r, p)
                if c not in families:
                    families.append(c); origin.append(["copy", k, p])
        n_copy = sum(1 for o in origin if isinstance(o, list))
        print(f"3b/c. representatives: {len(reps)}; copies (of old families and of representatives): {n_copy}")
        uncovered = [t for t in tails if not any(t & ~f == 0 for f in families)]
        if uncovered:
            sys.exit(f"{len(uncovered)} tails in no family")
    while uncovered:
        t = min(uncovered, key=lambda x: (-bin(x).count("1"), unmask(x)))
        free = [n for n in regular if not t >> n & 1]
        best, best_n = None, -1
        for extra in itertools.combinations(free, 7 - bin(t).count("1")):
            f = mask(CUT) | t | mask(extra)
            n = sum(1 for x in uncovered if x & ~f == 0)
            if n > best_n and full_rank(unmask(f)):
                best, best_n = f, n
        if best is None:
            sys.exit(f"no rank-12 completion for {unmask(t)}")
        families.append(best)
        uncovered = [x for x in uncovered if x & ~best != 0]
    n_old = len(old)
    if extend:
        assert families[:len(prev)] == prev, "--extend changed an existing family"
        print(f"--extend: {len(prev)} families kept, {len(families) - len(prev)} appended")
    for k in range(len(families) - 1 if not symmetric else n_old - 1, n_old - 1, -1):   # drop unneeded new families
        others = families[:k] + families[k + 1:]
        if all(any(x & ~o == 0 for o in others) for x in tails if x & ~families[k] == 0):
            families = others

    def covering(t):
        return next(i + 1 for i, f in enumerate(families) if t & ~f == 0)
    used = {covering(t) for t in tails}
    print(f"families: {n_old} old + {len(families) - n_old} new = {len(families)}; containing a tail: {len(used)} "
          f"(old {sum(1 for u in used if u <= n_old)}, new {sum(1 for u in used if u > n_old)})")

    with open(os.path.join(HERE, "families_raw.m"), "w") as f:
        f.write("{\n  " + ",\n  ".join(mlist(unmask(x)) for x in families) + "\n}\n")
    if symmetric:
        def fmt(o):
            return f'"{o}"' if isinstance(o, str) else "{\"copy\", " + str(o[1]) + ", " + mlist(o[2]) + "}"
        with open(os.path.join(HERE, "family_origin.m"), "w") as f:
            f.write("(* family -> origin, generated by families.py; copy k {s1,s2,s3}: family k with r_i -> r_s_i *)\n{\n  "
                    + ",\n  ".join(f"{i + 1} -> {fmt(o)}" for i, o in enumerate(origin)) + "\n}\n")
    with open(os.path.join(HERE, "tails.m"), "w") as f:
        f.write("(* propagator sets after partial fractions, generated by families.py *)\n{\n  "
                + ",\n  ".join(mlist(unmask(t)) for t in sorted(tails, key=unmask)) + "\n}\n")
    with open(os.path.join(HERE, "tailFamily.m"), "w") as f:
        f.write("(* tail -> family containing it, generated by families.py *)\n{\n  "
                + ",\n  ".join(f"{mlist(unmask(t))} -> {covering(t)}" for t in sorted(tails, key=unmask)) + "\n}\n")


if __name__ == "__main__":
    main()
