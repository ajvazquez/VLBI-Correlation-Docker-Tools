#!/bin/bash

# Dev
DEV=""
#echo "## DEV ##"
#SRC_FOLDER="/home/aj/work/cx_git/CXS338/"
#DEV=" -v ${SRC_FOLDER}:/opt/cx/venv3/src/cxs338/"

if [[ -z "$EXP" ]]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
docker run -p8888:8888 $DEV -v $EXP:/tmp/data -it cxp:latest /opt/cx/run_cxp.sh $@ /opt/cx/venv3/bin/python -m jupyter notebook --no-browser --ip=0.0.0.0
popd > /dev/null

# Example import:
# from cxs.conversion.difx import cx2d_lib
