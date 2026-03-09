#!/bin/bash
set -e

APP_NAME="Rae Therapee 5.12"
APP_FILE=${HOME}/AppImages/RawTherapee_5.12_release.AppImage
APP_URL=https://rawtherapee.com/shared/builds/linux/RawTherapee_5.12_release.AppImage

# download krita
if [ -f ${APP_FILE} ]
then
  echo "${APP_NAME} is already downloaded"
else
  curl -L -o ${APP_FILE} ${APP_URL} > /dev/null 2>&1
  chmod +x ${APP_FILE}
  echo "${APP_NAME} is downloaded"
fi
