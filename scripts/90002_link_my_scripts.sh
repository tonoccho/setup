#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
SOURCE_DIR=${HOME}/Documents/src/scripton_tea/

for i in `ls ${SOURCE_DIR}/scripts`
do
  ln -nfs ${SOURCE_DIR}/scripts/${i} ${HOME}/.bin/${i}
    result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
done
exit 0