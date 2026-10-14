"""Partial fractions on propagator SETS, exactly as FORM applies them in step 05 (shared by families.py, coverage.py).

contractPj: one outer repeat around the identities 1..48 (partial_fraction/partialfraction_<j>.inc), each in its
own repeat. Identity j applies to a term whose propagators contain its set C_j (pfid_sets.m): K != 0 -> the terms
without one element of C_j; K = 0 (pfid_squared.m: j -> n, n != 0) -> the terms without one element of C_j other
than n (n squared). Only which propagators occur matters here (powers do not change the sets).
NB: subsets must not be dropped before the partial fractions: a smaller product can contain all of C_j except the
squared n, is then not split, and is in no piece of its larger partner.
"""
import glob
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import collect_props as cp            # noqa: E402
from find_circuits import DD          # noqa: E402


def read_products():
    """every collected diagram-pair product of every channel (products[P], not only the maximal ones)"""
    out = set()
    for f in glob.glob(os.path.join(HERE, "propagators", "*.m")):
        if f.endswith("all.m"):
            continue
        m = re.search(r'products\["[^"]+"\] = \{(.*?)\};', open(f).read(), re.S)
        for x in re.findall(r"\{([^{}]*)\}", m.group(1)):
            out.add(frozenset(DD[cp.momentum(p)] for p in x.split(", ") if p.strip()))
    return out


def read_pf():
    pf = [frozenset(map(int, x.split(", "))) for x in
          re.findall(r"-> \{([^{}]*)\}", open(os.path.join(HERE, "pfid_sets.m")).read())]
    sq = [int(x) for x in re.findall(r"-> (\d+)", open(os.path.join(HERE, "pfid_squared.m")).read())]
    if len(sq) != len(pf):
        sys.exit("pfid_sets.m and pfid_squared.m do not match")
    return pf, sq


def form_pf(s, pf, sq, memo):
    """final propagator sets of a term with propagator set s, in FORM's order"""
    if s in memo:
        return memo[s]
    out, work = set(), {s}
    while work:                                   # outer repeat
        nxt = set()
        for t in work:
            cur = [t]
            for c, n in zip(pf, sq):              # identities 1..48, each with its own repeat
                new, stack = [], list(cur)
                while stack:
                    y = stack.pop()
                    if c <= y:
                        stack.extend(y - {m} for m in c if m != n)
                    else:
                        new.append(y)
                cur = new
            for x in cur:
                (nxt if any(c <= x for c in pf) else out).add(x)
        work = nxt
    memo[s] = out
    return out


def final_sets():
    """all propagator sets FORM can produce after the partial fractions, from all collected products"""
    pf, sq = read_pf()
    memo, final = {}, set()
    products = read_products()
    for s in products:
        final |= form_pf(s, pf, sq, memo)
    return products, final
