"""Check that every propagator set FORM can produce after the partial fractions lies in a family.

    python3 coverage.py      (run in Code_RRR/Families after families.py; exit code 1 if a set is in no family)

Takes EVERY collected product (products[P] of all channels) through the 48 partial-fraction identities in FORM's
order (pfsim.py) and checks the resulting sets against families_raw.m. Writes coverage_missing.m (sets in no family).
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from pfsim import final_sets          # noqa: E402

products, final = final_sets()
fams = [frozenset(map(int, re.findall(r"\d+", s))) for s in
        re.findall(r"\{([\d,\s]+)\}", open(os.path.join(HERE, "families_raw.m")).read())]
missing = sorted((x for x in final if not any(x <= f for f in fams)), key=lambda x: (len(x), sorted(x)))
print(f"{len(products)} products -> {len(final)} distinct sets after partial fractions, {len(fams)} families; "
      f"in no family: {len(missing)}")
for x in missing[:20]:
    print("  ", sorted(x))
with open(os.path.join(HERE, "coverage_missing.m"), "w") as f:
    f.write("(* propagator sets after partial fractions that lie in no family, coverage.py *)\n{"
            + ", ".join("{" + ", ".join(map(str, sorted(x))) + "}" for x in missing) + "}\n")
sys.exit(1 if missing else 0)
