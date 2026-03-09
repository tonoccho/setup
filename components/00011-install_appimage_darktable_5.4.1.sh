#!/bin/bash
set -e

APP_NAME="Daroktable 5.4.1"
APP_FILE=${HOME}/AppImages/Darktable-5.4.1-x86_64.AppImage
APP_URL=https://github.com/darktable-org/darktable/releases/download/release-5.4.1/Darktable-5.4.1-x86_64.AppImage

# download krita
if [ -f ${APP_FILE} ]
then
  echo "${APP_NAME} is already downloaded"
else
  curl -L -o ${APP_FILE} ${APP_URL} > /dev/null 2>&1
  chmod +x ${APP_FILE}
  echo "${APP_NAME} is downloaded"
fi
