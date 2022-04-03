#!/bin/bash
if [ -z "$EXP" ]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
docker run -p4040:4040 -v $EXP:/tmp/data -it cxs:latest /opt/cx/run_cxs.sh $@
popd > /dev/null
