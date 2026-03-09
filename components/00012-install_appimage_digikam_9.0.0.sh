#!/bin/bash
set -e

APP_NAME="digiKam 9.0.0"
APP_FILE=${HOME}/AppImages/digiKam-9.0.0-Qt6-x86-64.appimage
APP_URL=https://mirrors.xtom.au/kde/stable/digikam/9.0.0/digiKam-9.0.0-Qt6-x86-64.appimage

# download krita
if [ -f ${APP_FILE} ]
then
  echo "${APP_NAME} is already downloaded"
else
  curl -L -o ${APP_FILE} ${APP_URL} > /dev/null 2>&1
  chmod +x ${APP_FILE}
  echo "${APP_NAME} is downloaded"
fi
