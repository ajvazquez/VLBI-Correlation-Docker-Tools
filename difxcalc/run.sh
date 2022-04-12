#!/bin/bash
if [[ -z "$EXP" ]]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
xhost local:root && docker run -v $EXP:/tmp/data -it difxcalc:latest /usr/local/run_c.sh $@
popd > /dev/null
