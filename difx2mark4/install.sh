#!/bin/bash
D=`dirname "$0"`
D=`realpath $D`
bash $D/build.sh
echo "alias d-difx2mark4='bash $D/run.sh'" >> ~/.bashrc
