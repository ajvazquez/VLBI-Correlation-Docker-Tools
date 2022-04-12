#!/bin/bash
set -e
source /opt/cx/venv3/bin/activate
cd /tmp/data
if [[ $1 = "--docker-bash" ]]; then CMD="bash"; else CMD=$@; fi
if [[ $D = "1" ]]; then mkdir /tmp/cxs-egg && python /opt/cx/venv3/src/cxs338/setup.py egg_info --egg-base /tmp/cxs-egg > /dev/null && export PYTHONPATH=$PYTHONPATH:/tmp/cxs-egg; fi
$CMD
