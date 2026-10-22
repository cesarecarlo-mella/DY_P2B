#!/bin/bash
# Kira reduction of group g05: topo5 topo38 topo50 topo63
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
