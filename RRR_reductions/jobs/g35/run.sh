#!/bin/bash
# Kira reduction of group g35: topo664 topo868 topo880 topo916
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
