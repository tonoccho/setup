#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

for i in `echo ".local/share/fonts .bin"`
do
  if [ ! -d ${HOME}/$i ]
  then
    echo -n "creating ${HOME}/$i ... "
    mkdir -p ${HOME}/${i}  > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      show_success_message
    else
      show_error_message $result
      exit 9
    fi
  else
    echo "${HOME}/$i is already exist"
  fi
done
exit 0
