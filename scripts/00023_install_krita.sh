#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

echo $DOWNLOAD_DIR
if [ -f ${DOWNLOAD_DIR}/krita.AppImage ]
then
  echo "krita is already installed"
  exit 0
else
  echo -n "installing krita ..."
  wget -O ${DOWNLOAD_DIR}/krita.AppImage "https://download.kde.org/stable/krita/5.2.13/krita-5.2.13-x86_64.AppImage"  > /dev/null 2>&1
  chmod +x ${DOWNLOAD_DIR}/krita.AppImage  > /dev/null 2>&1
  
  result=$?
  if [ $? -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi
exit 0