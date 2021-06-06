#!/usr/bin/env bash

Files='*.lua'
Run=lua
Color=3

while getopts "f:r:c:h" o; do
  case "${o}" in
    f) Files=${OPTARG} ;;
    r) Run=${OPTARG};;
    c) Color=${OPTARG};;
    h) echo "usage: ./tests.sh -[rfc]"; exit;;
    *) echo "usage: ./tests.sh -[rfc]"; exit;;
 esac
done

bad=0
oops() {
  bad=1; 
  tput bold;tput setaf 1; printf "\n=== FAIL $1 ======== \n";tput sgr0
}
for f in $Files; do 
  tput bold;tput setaf $Color; printf "\n# $f\n";tput sgr0
  $Run $f || oops $f
done
exit $bad
