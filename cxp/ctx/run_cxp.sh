#!/bin/bash
set -e
source /opt/cx/venv3/bin/activate
cd /tmp/data
if [ $1 = "--docker-bash" ]; then CMD="bash"; else CMD=$@; fi
$CMD
