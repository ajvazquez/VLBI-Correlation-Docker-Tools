#!/bin/bash
D=`dirname "$0"`
D=`realpath $D`
bash $D/build.sh
echo "alias d-cxp='bash $D/run.sh'" >> ~/.bashrc
echo "alias d-cxp-dev='bash $D/run_dev.sh'" >> ~/.bashrc
echo "alias d-cxp-jupyter='bash $D/run_jupyter.sh'" >> ~/.bashrc
