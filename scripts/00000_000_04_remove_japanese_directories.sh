#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK
SHELL_PATH=$0
SHELL_DESCRIPTION="remove Japanese directories in ${HOME}"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "Japanese directory delete start"

for i in `echo "ダウンロード  テンプレート  デスクトップ  ドキュメント  ビデオ  ピクチャ  ミュージック  公開"`
do
  if [ -d ${HOME}/$i ]
  then
    info 2 "removing ${HOME}/$i ... "
    rm -rf ${HOME}/${i}   > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      info 2 "removed ${HOME}/${i}"
    else
      error 2 "failed to remove ${HOME}/{i} with $result"
      EXIT_CODE=$EXIT_CODE_ERROR
      break
    fi
  else
    info 2 "${HOME}/$i is not exist"
  fi
done


info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE