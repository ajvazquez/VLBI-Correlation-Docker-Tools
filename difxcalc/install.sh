#!/bin/bash
D=`dirname "$0"`
D=`realpath $D`
bash $D/build.sh
echo "alias d-difxcalc='bash $D/run.sh'" >> ~/.bashrc
