#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.bin

if [ -f ${DOWNLOAD_DIR}/Inkscape-ebf0e94-x86_64.AppImage ]
then
  echo "Inkscape is already installed"
  exit 0
else
  echo -n "installing Inkscape ..."
  wget -O ${DOWNLOAD_DIR}/Inkscape-ebf0e94-x86_64.AppImage "https://inkscape.org/gallery/item/56343/Inkscape-ebf0e94-x86_64.AppImage"  > /dev/null 2>&1
  chmod +x ${DOWNLOAD_DIR}/Inkscape-ebf0e94-x86_64.AppImage  > /dev/null 2>&1
  ln -s ${DOWNLOAD_DIR}/Inkscape-ebf0e94-x86_64.AppImage ${DOWNLOAD_DIR}/Inkscape
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