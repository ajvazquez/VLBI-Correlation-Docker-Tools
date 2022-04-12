#!/bin/bash
D=`dirname "$0"`
D=`realpath $D`
bash $D/build.sh
echo "alias d-cxs='bash $D/run.sh'" >> ~/.bashrc
echo "alias d-cxs-dev='bash $D/run_dev.sh'" >> ~/.bashrc
