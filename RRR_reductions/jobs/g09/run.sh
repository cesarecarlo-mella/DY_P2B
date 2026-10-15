#!/bin/bash
# Kira reduction of group g09: topo61 topo820 topo826 topo898
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
