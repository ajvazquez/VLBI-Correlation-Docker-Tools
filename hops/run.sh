#!/bin/bash
if [[ -z "$EXP" ]; then EXP=`pwd`; fi; EXP=`realpath $EXP`; echo "EXP=$EXP"
pushd $EXP > /dev/null
xhost local:root && docker run -v $EXP:/tmp/data -v /tmp/.X11-unix/:/tmp/.X11-unix -e DISPLAY=$DISPLAY -it hops:latest /usr/local/hops/run_ff.sh $@
popd > /dev/null
