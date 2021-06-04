#!/usr/bin/env bash

Lua=${1:-lua}

bad=0
for f in *.lua; do 
  echo -en '\E[47;31m'"\033[1m-- $f\033[0m"   # Red
  echo ""
  $Lua $f || bad=1
done
exit $bad
