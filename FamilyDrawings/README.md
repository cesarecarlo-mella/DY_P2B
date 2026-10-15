# Drawings of the integral families (cut diagrams)

    python3 draw_families.py            # the 156 independent families -> families.pdf, families.json, families.tex
    python3 draw_families.py --all      # all 921
    python3 draw_families.py 1 7 910    # selected families

Reads the families from ../Code_v2/Families (families_raw.m, families_relabelling.m; DD numbering of
find_circuits.REGULAR). Needs graphviz (dot) and pdflatex with tikz-feynman.

Method: with all legs incoming every regular propagator is a split of {p1, p2, r1, r2, r3, q}; a tree amplitude
p1 p2 -> V(q) r1 r2 r3 is a set of compatible splits. Each family is drawn as amplitude (left) x conjugate (right),
glued along the cut r1, r2, r3, q, choosing the two trees that contain the most of its 7 regular propagators; the
others are irreducible numerators (listed under each drawing and in families.json). The cut conditions are r_i^2 = 0,
q^2 = m2 and the rapidity condition -q.p1 + u q.p2 = 0, which is not a line and is not drawn.

Independent families: 146 with 1 irreducible numerator, 10 with 2; 155 of them are two full trees (3 + 3 propagators).

To do: nicer layout (fewer crossings, labels that do not overlap).
