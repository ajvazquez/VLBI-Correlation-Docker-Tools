#!/bin/bash
set -e
cd /tmp/data
if [[ $1 = "--docker-bash" ]]; then CMD="bash"; else CMD="vex2difx $@"; fi
$CMD
