#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

echo $DOWNLOAD_DIR
if [ -f ${DOWNLOAD_DIR}/GIMP.AppImage ]
then
  echo "GIMP is already installed"
  exit 0
else
  echo -n "installing GIMP ..."
  wget -O ${DOWNLOAD_DIR}/GIMP.AppImage "https://download.gimp.org/gimp/v3.0/linux/GIMP-3.0.4-x86_64.AppImage"  > /dev/null 2>&1
  chmod +x ${DOWNLOAD_DIR}/GIMP.AppImage  > /dev/null 2>&1
  
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