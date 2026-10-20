#!/bin/bash
# r1 <-> r2 (Q <-> Qbar) symmetry of the step-04 pieces of RR q qb -> V Q Qb (Code_RR VqqbQ2Q2b), contracted with L1.
# From the repo root, after: Code_RR run_all.py run --channels VqqbQ2Q2b --steps qgraf,01,02,03,04 --jobs 1
set -e
source Code_RR/setenv.sh >/dev/null
D=$PWD/Code_RR/Scripts/physical_qqbQ2Q2b/VqqbQ2Q2b/VqqbQ2Q2b_LO/tmp/squared_diagrams
T=$(mktemp -d "${TMPDIR:-/tmp}/furry.XXXX")
for p in vv v2v2 vv2 aa2 a2a; do
cat > $T/l1_$p.frm <<EOT
#-
#include all_header.h
#include $D/$p/${p}_1_1.inc
.sort
multiply (q(mu95)*q(nu95) - q.q*d_(mu95,nu95));
contract;
.sort
Format Mathematica;
Format nospaces;
#write <$T/$p.m> "%E" [interf1_1]
.end
EOT
(cd $T && nice form -q l1_$p.frm > /dev/null)
done
nice wolframscript -file notes_Larin/checks/furry_swap.wl $T
