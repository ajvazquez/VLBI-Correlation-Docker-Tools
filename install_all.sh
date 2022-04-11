#!/bin/bash
for d in cxp cxs difx2mark4 difxcalc hops vex2difx
do
  pushd $d > /dev/null
  echo "Installing $d..."
  bash install.sh
  popd > /dev/null
done