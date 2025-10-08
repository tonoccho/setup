#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK_BUT_NOT_REGISTER
SHELL_PATH=$0
SHELL_DESCRIPTION="do apt update"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "apt update start"
sudo apt update > /dev/null 2>&1
result=$?
info 2 "check result"
if [ $result -eq 0 ]
then
  info 2 "apt update successfully finished"
else
  error 2 "apt update failed with $result"
  EXIT_CODE=$EXIT_CODE_ERROR 
fi

info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE
