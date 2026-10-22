#!/bin/bash
# Kira reduction of group g18: topo33 topo64 topo73 topo76
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
