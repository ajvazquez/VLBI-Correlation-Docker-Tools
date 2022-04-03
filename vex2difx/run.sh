#!/bin/bash
if [ -z "$EXP" ]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
docker run -v $EXP:/tmp/data -it vex2difx:latest /usr/local/run_v.sh $@
popd > /dev/null
