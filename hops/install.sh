#!/bin/bash
D=`dirname "$0"`
D=`realpath $D`
bash $D/build.sh
echo "alias d-hops='bash $D/run_x.sh'" >> ~/.bashrc
echo "alias d-hops-cxs='bash $D/run_x_cxs.sh'" >> ~/.bashrc
