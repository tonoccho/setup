#!/bin/bash
set -e

APP_NAME="Gimp 3.0.8"
APP_FILE=${HOME}/AppImages/GIMP-3.0.8-1-x86_64.AppImage
APP_URL=https://download.gimp.org/gimp/v3.0/linux/GIMP-3.0.8-1-x86_64.AppImage

# download krita
if [ -f ${APP_FILE} ]
then
  echo "${APP_NAME} is already downloaded"
else
  curl -L -o ${APP_FILE} ${APP_URL} > /dev/null 2>&1
  chmod +x ${APP_FILE}
  echo "${APP_NAME} is downloaded"
fi
