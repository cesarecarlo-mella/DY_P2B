#!/bin/bash
# Runs the checks of notes_Larin/Larin.pdf. From the repo root:  bash notes_Larin/checks/run_checks.sh
# Needs the step-06 outputs (not in git): Code_LO Vqqb and Code_RR VqQ2qQ2 run with SKIPAA=0.
# The identical-quark check (sect. 5.3) used a scratch copy of Code_RR with q qb -> V q qb run with SKIPAA=0;
# pass its unreduced folder as $1 to repeat it.
set -e
IDQ="$1"
C=notes_Larin/checks
nice wolframscript -file $C/lo_ratio.wl
R=Code_RR/Scripts/physical_qqbQ2Q2b/VqQ2qQ2/VqQ2qQ2_LO/tmp/unreduced
for p in "aa vv" "a2a2 v2v2" "aa2 vv2"; do set -- $p; nice wolframscript -file $C/aa_vs_vv.wl $R $1 $2; done
if [ -n "$IDQ" ]; then nice wolframscript -file $C/aa_vs_vv.wl "$IDQ" aa vv; fi
