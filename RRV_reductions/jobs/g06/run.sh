#!/bin/bash
# Kira reduction of group g06: topo6 topo30 topo67 topo69
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
