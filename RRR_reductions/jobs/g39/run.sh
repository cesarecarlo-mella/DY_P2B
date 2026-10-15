#!/bin/bash
# Kira reduction of group g39: topo757 topo763 topo769 topo832
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
