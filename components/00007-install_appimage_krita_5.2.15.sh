#!/bin/bash
set -e

APP_NAME="Krita 5.2.16"
APP_FILE=${HOME}/AppImages/krita-5.2.16-x86_64.AppImage
APP_URL=https://download.kde.org/stable/krita/5.2.16/krita-5.2.16-x86_64.AppImage

# download krita
if [ -f ${APP_FILE} ]
then
  echo "${APP_NAME} is already downloaded"
else
  curl -L -o ${APP_FILE} ${APP_URL} > /dev/null 2>&1
  chmod +x ${APP_FILE}
  echo "${APP_NAME} is downloaded"
fi