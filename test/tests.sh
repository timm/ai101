#!/usr/bin/env bash

Lua=${1:-lua}

bad=0
for f in *.lua; do 
  $Lua $f || bad=1
done
exit $bad
