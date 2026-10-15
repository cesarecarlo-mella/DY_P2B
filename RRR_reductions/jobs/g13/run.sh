#!/bin/bash
# Kira reduction of group g13: topo115 topo490 topo514 topo658
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
