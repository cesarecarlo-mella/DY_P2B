(* Propagators DD1..DD29 of the triple-real integrals, used by pf_identities.wl, families.py, families.wl.

   Kinematics: p1, p2 incoming (p1^2 = p2^2 = 0, 2 p1.p2 = s12 = m2/z), all QGRAF momenta incoming,
   q = -p1 - p2 - r1 - r2 - r3 (the vector boson, q^2 = m2), r1, r2, r3 final-state partons (on shell).
   sp[a, b] = a.b.  The 12 scalar products of the integration momenta: p1.ri, p2.ri, ri.rj (i <= j).

   DD1..DD5   cut propagators, the same in every family (first 5 entries of every FAM[n])
   DD6..DD23  regular propagators, numbering of n3lo/RRR/Families_Identification/Triple_Real_Families.nb
   DD24..DD29 regular propagators added for the 49 channels of Code_v2 (none in q qb -> V g g g):
              (p1+p2+r_i)^2 = (q+r_j+r_k)^2 and (p1+p2+r_i+r_j)^2 = (q+r_k)^2

   In FORM (partial_fraction/*.inc) the regular propagators are written Prop(<momentum>), momentum as in "momentum" below. *)

DDdefinitions = {
  DD1  -> sp[r1, r1],                                              (* cut: r1 on shell *)
  DD2  -> sp[r2, r2],                                              (* cut: r2 on shell *)
  DD3  -> sp[r3, r3],                                              (* cut: r3 on shell *)
  DD4  -> sp[p1 + p2 + r1 + r2 + r3, p1 + p2 + r1 + r2 + r3] - m2, (* cut: q^2 - m2 *)
  DD5  -> -sp[q, p1] + u sp[q, p2],                                 (* cut: rapidity, q = -p1-p2-r1-r2-r3 *)
  DD6  -> sp[p1 + r1, p1 + r1],
  DD7  -> sp[p2 + r1, p2 + r1],
  DD8  -> sp[p1 + r2, p1 + r2],
  DD9  -> sp[p2 + r2, p2 + r2],
  DD10 -> sp[p1 + r3, p1 + r3],
  DD11 -> sp[p2 + r3, p2 + r3],
  DD12 -> sp[r1 + r2, r1 + r2],
  DD13 -> sp[r2 + r3, r2 + r3],
  DD14 -> sp[r1 + r3, r1 + r3],
  DD15 -> sp[p1 + r1 + r2, p1 + r1 + r2],
  DD16 -> sp[p2 + r1 + r2, p2 + r1 + r2],
  DD17 -> sp[p1 + r1 + r3, p1 + r1 + r3],
  DD18 -> sp[p2 + r1 + r3, p2 + r1 + r3],
  DD19 -> sp[p1 + r2 + r3, p1 + r2 + r3],
  DD20 -> sp[p2 + r2 + r3, p2 + r2 + r3],
  DD21 -> sp[r1 + r2 + r3, r1 + r2 + r3],
  DD22 -> sp[p1 + r1 + r2 + r3, p1 + r1 + r2 + r3],
  DD23 -> sp[p2 + r1 + r2 + r3, p2 + r1 + r2 + r3],
  DD24 -> sp[p1 + p2 + r1, p1 + p2 + r1],                          (* = (q + r2 + r3)^2 *)
  DD25 -> sp[p1 + p2 + r2, p1 + p2 + r2],                          (* = (q + r1 + r3)^2 *)
  DD26 -> sp[p1 + p2 + r3, p1 + p2 + r3],                          (* = (q + r1 + r2)^2 *)
  DD27 -> sp[p1 + p2 + r1 + r2, p1 + p2 + r1 + r2],                (* = (q + r3)^2 *)
  DD28 -> sp[p1 + p2 + r1 + r3, p1 + p2 + r1 + r3],                (* = (q + r2)^2 *)
  DD29 -> sp[p1 + p2 + r2 + r3, p1 + p2 + r2 + r3]                 (* = (q + r1)^2 *)
};

momentum = {r1, r2, r3, q, -q.p1 + u q.p2,
  p1 + r1, p2 + r1, p1 + r2, p2 + r2, p1 + r3, p2 + r3, r1 + r2, r2 + r3, r1 + r3,
  p1 + r1 + r2, p2 + r1 + r2, p1 + r1 + r3, p2 + r1 + r3, p1 + r2 + r3, p2 + r2 + r3, r1 + r2 + r3,
  p1 + r1 + r2 + r3, p2 + r1 + r2 + r3,
  p1 + p2 + r1, p1 + p2 + r2, p1 + p2 + r3, p1 + p2 + r1 + r2, p1 + p2 + r1 + r3, p1 + p2 + r2 + r3};
