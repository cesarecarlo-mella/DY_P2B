#!/bin/bash
# Kira reduction of group g12: topo12 topo35 topo48 topo58
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
