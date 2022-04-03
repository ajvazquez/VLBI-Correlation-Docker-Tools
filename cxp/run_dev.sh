#!/bin/bash
echo "## DEV ##"
SRC_FOLDER="/home/aj/work/cx_git/CXS338/"
DEV=" -v ${SRC_FOLDER}:/opt/cx/venv3/src/cxs338/"

if [ -z "$EXP" ]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
docker run $DEV -v $EXP:/tmp/data -it cxp:latest /opt/cx/run_cxp.sh $@
popd > /dev/null
