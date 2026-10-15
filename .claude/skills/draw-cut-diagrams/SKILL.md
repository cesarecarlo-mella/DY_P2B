---
name: draw-cut-diagrams
description: Draw the triple-real integral families or individual sectors (e.g. top sectors / master-integral sectors) of the DY N3LO RRR project as cut diagrams (amplitude x conjugate glued along the cut), with momentum-flow arrows and propagator tables. Use when the user asks to draw, plot or visualise families, sectors, topologies or master integrals of Code_v2/Families, or to update those drawings.
---

# Drawing integral families and sectors as cut diagrams

Tool: `FamilyDrawings/draw_families.py` (repository root, next to `Code_v2/`). It reads the families from
`../Code_v2/Families` (`families_raw.m`, `families_relabelling.m`, `fams/reconstruct.inc`, `find_circuits.REGULAR`),
so it must stay at that level. Needs `pdflatex` with `tikz-feynman` (TeX Live 2020 on the laptop: load it with
`compat=1.1.0`; the `charged ghost` style does not exist there) and `pdftoppm` to look at the result. Graphviz is not
used by this tool (only by `Code_v2/Scripts/diagrams/draw_diagrams.py`, the per-channel Feynman diagrams).

## Commands

```
cd FamilyDrawings
python3 draw_families.py                         # the 156 independent families -> families.pdf/.tex/.json
python3 draw_families.py --all                   # all 921 families
python3 draw_families.py 1 7 910                 # selected families
python3 draw_families.py --sectors my_sectors.txt                  # sectors -> sectors.pdf/.tex/.json
python3 draw_families.py --top-sectors ../Code_v2/integrals/all/integrals.m # maximal sectors among collected integrals
options: --straight (straight lines), --no-arrows, --momentum-labels (momenta instead of DD numbers on the lines)
```

Sector file, one per line (`#` comments allowed):
- `topo55[1,1,1,1,1,1,0,1,1,0,0,0]` -- INT indices (5 cut indices, then the 7 regular ones in the family's INT order
  from `reconstruct.inc`); positive index = line present;
- or `55: 6 13 8` -- family number and the DD numbers of the lines present.
The user's own sector list is `FamilyDrawings/my_sectors.txt` (theirs: do not commit or overwrite it).
`--top-sectors` reads an `integrals.m` from `Code_v2/Scripts/run_all.py integrals` (default `Code_v2/integrals/<set>/`).

## Physics and conventions (keep these when changing anything)

- Momenta all incoming: p1 + p2 + r1 + r2 + r3 + q = 0; regular propagators DD6..DD29 = (sum of legs)^2, e.g.
  6 = (p1+r1)^2, 27 = (p1+p2+r1+r2)^2 (list `REGULAR` in `Code_v2/Families/find_circuits.py`). Each regular
  propagator is a split of the legs {p1,p2,r1,r2,r3,q}; a tree amplitude p1 p2 -> V(q) r1 r2 r3 is a set of compatible
  splits (nested or disjoint).
- A family/sector is drawn as amplitude (left) x conjugate (right) glued along the cut (dashed): the two trees
  containing as many of its lines as possible (`best_trees`): tie-break = most lines, then fewest lines on both sides,
  then balanced; a line is never drawn twice (kept on the amplitude side). Lines fitting in neither tree: irreducible
  numerators (families) / listed in red "in no tree" (sectors). Families: 146 of the 156 have 1 irreducible numerator,
  10 have 2. The decomposition is NOT unique in general (only 28 of 156 families have a unique one) -- say so if asked.
- Cut: r1, r2, r3 (blue) and q (red) as horizontal segments through the cut, no arrows on the cut. The q line is
  wavy up to the cut (q^2 = m2) and a red double line after it (the rapidity condition -q.p1 + u q.p2 = 0, which is
  not a propagator line).
- Momentum-flow arrows (incoming convention): in the amplitude every line carries the sum of the incoming momenta of
  the legs on its far side towards the root (where q attaches); p1, p2 enter on the left; in the conjugate everything
  is mirrored (p1, p2 leave on the right). Edges from `tree_edges` are listed child -> parent: left as listed, right
  reversed.
- Layout (own, not graphviz): order of the cut lines (of 24) for which most propagators are contiguous in the cyclic
  leg order p1, cut lines, p2 (= drawable without crossing); p1/p2 at fixed corners; a vertex's x from its graph
  distances to the p legs and to the cut, y = average of the neighbours', then a minimum vertical distance; smooth
  lines (horizontal tangents, looseness 0.75; short lines straight).
- Under each drawing: table of its lines (DD number, momentum, amplitude/conjugate) and the pinched propagators.

## Checking a drawing

Render and look at it before reporting:
```
pdftoppm -png -r 110 -f 1 -l 1 sectors.pdf /tmp/sec      # then read the PNG
```
Check: arrows consistent with the momenta in the table (e.g. line 6 = p1+r1 flows from the vertex joining p1 and r1
towards the q vertex on the left; mirrored on the right), every listed line drawn once, no red "in no tree" unless
expected, labels readable. Known cosmetic limit: where 4-5 lines meet in a small area two DD labels can sit close.

## Housekeeping

Commit `draw_families.py`, `README.md` and the generated `.pdf/.tex/.json`; `FamilyDrawings/.gitignore` excludes
`*.aux`, `*.log`, `__pycache__/`. Do not commit the user's `my_sectors.txt`. Update `FamilyDrawings/README.md` when
the conventions or options change.
