#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK
SHELL_PATH=$0
SHELL_DESCRIPTION="check user group of $LOGNAME, add group if not registered."

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "group check start"
for i in `echo video`
do
  info 2 "checking $LOGNAME is a member of $i ... "
  result=$(getent group $i |  grep $LOGNAME | wc -l)
  if [ $result -eq 1 ]
  then
    info 2 "already the member of $i"
  elif [ $result -eq 0 ]
  then
    info 2 "adding $LOGNAME to group $i"
    sudo usermod -a -G $i $LOGNAME > /dev/null 2>&1
    result=$?
    if [ $result -ne 0 ]
    then
      info 2 "failed with $result"
      EXIT_CODE=$EXIT_CODE_ERROR
    else
      info 2 "success"
      info 2 "$(id $LOGNAME)"
    fi
  fi
done


info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE
