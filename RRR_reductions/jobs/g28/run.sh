#!/bin/bash
# Kira reduction of group g28: topo400 topo790 topo802 topo808
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
