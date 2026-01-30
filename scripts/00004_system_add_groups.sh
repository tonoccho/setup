#!/usr/bin/env bash
# 必ずやる処理
set -e

source $1
groups=(video docker render)

# check precondition
for i in "${goups[@]}"
do
  if getent group "${i}" > /dev/null 2>&1
  then
    linfo "group ${i} is found"
  else
    if sudo groupadd ${i}
    then
      linfo "group ${i} is created"
    else
      lerror "failed to add group ${i} with $?"
      exit 9
    fi    
  fi
done
exit 0