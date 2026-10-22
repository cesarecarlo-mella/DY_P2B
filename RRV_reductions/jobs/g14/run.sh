#!/bin/bash
# Kira reduction of group g14: topo14 topo18 topo28 topo65
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
