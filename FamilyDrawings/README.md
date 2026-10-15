# Drawings of the integral families (cut diagrams)

    python3 draw_families.py            # the 156 independent families -> families.pdf, families.json, families.tex
    python3 draw_families.py --all      # all 921
    python3 draw_families.py 1 7 910    # selected families
    python3 draw_families.py --sectors FILE              # given sectors -> sectors.pdf, sectors.json
    python3 draw_families.py --top-sectors integrals.m   # maximal sectors per family among collected integrals

Sector file, one per line: `topo55[1,1,1,1,1,1,1,0,1,1,0,1]` (INT indices; positive = line present) or `55: 6 9 17`
(family and DD numbers of the lines). Only the lines of the sector are drawn (the others are pinched); a line that
fits in neither tree is listed in red; a line is never drawn on both sides. Sectors of families that are not
independent are marked.

Reads the families from ../Code_v2/Families (families_raw.m, families_relabelling.m; DD numbering of
find_circuits.REGULAR). Needs graphviz (dot) and pdflatex with tikz-feynman.

Method: with all legs incoming every regular propagator is a split of {p1, p2, r1, r2, r3, q}; a tree amplitude
p1 p2 -> V(q) r1 r2 r3 is a set of compatible splits. Each family is drawn as amplitude (left) x conjugate (right),
glued along the cut r1, r2, r3, q, choosing the two trees that contain the most of its 7 regular propagators; the
others are irreducible numerators (listed under each drawing and in families.json). The cut conditions are r_i^2 = 0,
q^2 = m2 and the rapidity condition -q.p1 + u q.p2 = 0, which is not a line and is not drawn.

Independent families: 146 with 1 irreducible numerator, 10 with 2; 155 of them are two full trees (3 + 3 propagators).

To do: nicer layout (fewer crossings, labels that do not overlap).
