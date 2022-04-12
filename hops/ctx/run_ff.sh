#!/bin/bash
set -e
#source /usr/local/hops/bin/hops.bash
cd /tmp/data
if [[ $1 = "--docker-bash" ]]; then CMD="bash"; else CMD="$@"; fi
echo $CMD
$CMD
