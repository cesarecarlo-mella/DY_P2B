#!/bin/bash
# Kira reduction of group g18: topo205 topo235 topo316 topo544
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
