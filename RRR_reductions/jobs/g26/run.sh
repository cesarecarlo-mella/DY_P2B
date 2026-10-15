#!/bin/bash
# Kira reduction of group g26: topo370 topo388 topo580 topo751
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
