#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

for i in `echo "ダウンロード  テンプレート  デスクトップ  ドキュメント  ビデオ  ピクチャ  ミュージック  公開"`
do
  if [ -d ${HOME}/$i ]
  then
    echo -n "removing ${HOME}/$i ... "
    rm -rf ${HOME}/${i}   > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      show_success_message
    else
      show_error_message $result
      exit 9
    fi
  else
    echo "${HOME}/$i is not exist"
  fi
done
exit 1
