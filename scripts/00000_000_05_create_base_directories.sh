#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK
SHELL_PATH=$0
SHELL_DESCRIPTION="create directories inder ${HOME}"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "make base directories start"

for i in `echo ".local/share/fonts .bin .icon Applications Documents/src .opt"`
do
  if [ ! -d ${HOME}/$i ]
  then
    info 2 "creating ${HOME}/$i ... "
    mkdir -p ${HOME}/${i}  > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      info 2 "${HOME}/${i} created successfully"
    else
      error 2 "creating ${HOME}/$i} failed with $result"
      EXIT_CODE=EXIT_CODE_ERROR
    fi
  else
    info 2 "${HOME}/$i is already exist"
  fi
done

info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE