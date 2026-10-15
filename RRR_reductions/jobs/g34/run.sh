#!/bin/bash
# Kira reduction of group g34: topo640 topo688 topo694 topo856
# threads: KIRA_THREADS (default 4); low priority
cd "$(dirname "$0")"
nice -n 19 kira --parallel=${KIRA_THREADS:-4} jobs.yaml > kira.out 2>&1
