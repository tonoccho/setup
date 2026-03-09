#!/bin/bash
set -e

APP_NAME="Inkscape 1.4.3"
APP_FILE=${HOME}/AppImages/Inkscape-0d15f75-x86_64.AppImage
APP_URL=https://inkscape.org/gallery/item/58919/Inkscape-0d15f75-x86_64.AppImage

# download krita
if [ -f ${APP_FILE} ]
then
  echo "${APP_NAME} is already downloaded"
else
  curl -L -o ${APP_FILE} ${APP_URL} > /dev/null 2>&1
  chmod +x ${APP_FILE}
  echo "${APP_NAME} is downloaded"
fi