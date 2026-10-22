# RRV families and sectors as cut diagrams

    python3 draw_families_rrv.py                 # the 77 independent families -> families_rrv.pdf, .json, .tex
    python3 draw_families_rrv.py 1 7 21          # selected families
    python3 draw_families_rrv.py --sectors FILE              # given sectors -> sectors_rrv.pdf, .json
    python3 draw_families_rrv.py --top-sectors integrals.m   # maximal sectors per family among collected integrals

Sector file, one per line: `topo7[1,1,1,1,0,1,1,1,0,1,1,1]` (INT indices; positive = line present) or `7: 6 12 14 18`
(family and DD numbers of the lines), e.g. Code_RRV/integrals/all/analysis/topsectors_list.txt (from
Code_RRV/integrals/Tools/analyse_integrals.py). Options as in ../RRR: --straight, --no-arrows, --momentum-labels.

Reads the families from ../../Code_RRV/Families (integralfamilies_r.rrv.m: DD numbering and momenta; rrv_families.txt:
RR family and pentagon order) and uses the layout helpers of ../RRR/draw_families.py.

Method: all legs incoming (p1 + p2 + r1 + r2 + q = 0, k1 incoming). A family = 4 cut "propagators" (r1^2, r2^2,
q^2 - m2, rapidity condition) + 3 RR propagators DD5..DD13 (k1-free) + 5 loop propagators DD14..DD29 = (k1 + S)^2.
The loop lines present form a chain S_0 < S_1 < ...; the legs entering the loop between two consecutive loop lines
form a group attached to one loop vertex (the q group: S_0, the legs not in the last S, and q). An RR propagator is a
split of the five legs: it is drawn in the amplitude (a tree attached to the loop vertex) when one of its sides lies
inside a group, in the conjugate tree otherwise; the assignment covering most RR lines is taken (ties: more lines in
the conjugate), the rest are irreducible numerators (listed in red). The loop lines are green, the cut lines r1, r2
blue, q red (wavy up to the cut, double line for the rapidity condition after it). The cut order of r1, r2, q is the
one with the fewest non-planar pieces; families whose pentagon has q between p1 and p2 always cross (p1, p2 enter on
the left).

Sectors with fewer than two loop lines are scaleless (zero) and are listed without a drawing.
