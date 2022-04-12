#!/bin/bash
if [[ -z "$EXP" ]]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
docker run -v $EXP:/tmp/data -it cxp:latest /opt/cx/run_cxp.sh $@
popd > /dev/null