#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.bin
URL=https://inkscape.org/gallery/item/56343/Inkscape-ebf0e94-x86_64.AppImage
FILENAME=Inkscape-ebf0e94-x86_64.AppImage
LINKNAME=Inkscape
APPNAME=Inkscape

if [ -f ${DOWNLOAD_DIR}/${FILENAME} ]
then
  echo "${APPNAME} is already installed"
  exit 0
else
  echo -n "installing ${APPNAME} ..."
  wget -O ${DOWNLOAD_DIR}/${FILENAME} "${URL}"  > /dev/null 2>&1
  chmod +x ${DOWNLOAD_DIR}/${FILENAME}  > /dev/null 2>&1
  ln -s ${DOWNLOAD_DIR}/${FILENAME} ${DOWNLOAD_DIR}/${LINKNAME}
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