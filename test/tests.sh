#!/usr/bin/env bash

What=${1:-lua}
Who=${2:-"*.lua"}

bad=0
for f in $Who; do 
  echo ""
  tput bold;tput setaf 3; echo "-- $f";tput sgr0
  echo $What $f || bad=1
done
exit $bad
