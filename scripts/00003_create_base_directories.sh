#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${1}
dirs=(local/share/fonts .bin .icon Applications Documents/src .opt)
for i in "${dirs[@]}"
do
  dir=${HOME}/${i}
  if [ -d $dir ]
  then
    linfo "$dir is already created"
  else
    if mkdir -p $dir
    then
      linfo "$dir is created"
    else
      lerror "$dir could not created by $?"
      exit $RC_ERROR
    fi
  fi
done
exit $RC_OK
