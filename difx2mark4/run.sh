#!/bin/bash
if [ -z "$EXP" ]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
docker run -v $EXP:/tmp/data -it difx2mark4:latest /usr/local/run_d.sh $@
popd > /dev/null
