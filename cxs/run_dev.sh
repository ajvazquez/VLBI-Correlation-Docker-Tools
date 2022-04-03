#!/bin/bash
echo "## DEV ##"
SRC_FOLDER="/home/aj/work/cx_git/CXS338/"
DEV=" -v ${SRC_FOLDER}:/opt/cx/venv3/src/cxs338/"

if [ -z "$EXP" ]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
docker run -p4040:4040 $DEV -v $EXP:/tmp/data -it cxs:latest /opt/cx/run_cxs.sh $@
popd > /dev/null
