#!/bin/bash
D=`dirname "$0"`
D=`realpath $D`
bash $D/build.sh
echo "alias d-vex2difx='bash $D/run.sh'" >> ~/.bashrc
