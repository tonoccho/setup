#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.bin

if [ -f ${DOWNLOAD_DIR}/Darktable-5.2.1-x86_64.AppImage ]
then
  echo "Darktable is already installed"
  exit 0
else
  echo -n "installing Darktable ..."
  wget -O ${DOWNLOAD_DIR}/Darktable-5.2.1-x86_64.AppImage "https://github.com/darktable-org/darktable/releases/download/release-5.2.1/Darktable-5.2.1-x86_64.AppImage"  > /dev/null 2>&1
  chmod +x ${DOWNLOAD_DIR}/Darktable-5.2.1-x86_64.AppImage  > /dev/null 2>&1
  ln -s ${DOWNLOAD_DIR}/Darktable-5.2.1-x86_64.AppImage ${DOWNLOAD_DIR}/Darktable
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