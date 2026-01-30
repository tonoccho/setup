#!/usr/bin/env bash
# 必ずやる処理
set -e
source $1
dirs=(デスクトップ ダウンロード テンプレート 公開 ドキュメント ミュージック ピクチャ ビデオ)
for i in "${dirs[@]}"
do
  dir=${HOME}/${i}
  if [ -d $dir ]
  then
    if rmdir $dir
    then
      linfo "$dir is removed"
    else
      lerror "$dir could not removed by $?"
      exit $RC_ERROR
    fi
  else
    linfo "$dir is not found, can't delete, continue"
  fi
done
exit $RC_OK