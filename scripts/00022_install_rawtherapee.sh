#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

echo $DOWNLOAD_DIR
if [ -f ${DOWNLOAD_DIR}/RawTherapee.AppImage ]
then
  echo "RawTherapee is already installed"
  exit 0
else
  echo -n "installing RawTherapee ..."
  wget -O ${DOWNLOAD_DIR}/RawTherapee.AppImage "https://rawtherapee.com/shared/builds/linux/RawTherapee_5.12_release.AppImage"  > /dev/null 2>&1
  chmod +x ${DOWNLOAD_DIR}/RawTherapee.AppImage  > /dev/null 2>&1
  wget -O ${DOWNLOAD_DIR}/RawTherapee.svg "https://rawtherapee.com/images/rt-logo-white.svg"  > /dev/null 2>&1
  
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