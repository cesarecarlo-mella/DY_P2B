#!/bin/bash
# Kira reduction of group g13: topo13 topo15 topo40 topo74
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
