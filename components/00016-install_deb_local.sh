#!/bin/bash
set -e

APP_NAME="local 9.2.9"
APP_FILE=${HOME}/Downloads/local-9.2.9-linux.deb
APP_URL=https://cdn.localwp.com/stable/latest/deb


# download local
if [ -f ${APP_FILE} ]
then
  echo "${APP_NAME} is already downloaded"
else
  curl -L -o ${APP_FILE} ${APP_URL} > /dev/null 2>&1
  chmod +x ${APP_FILE}
  echo "${APP_NAME} is downloaded"
fi

if [ $(dpkg -l | grep -E "^ii +local " | wc -l) -eq 1 ]
then
  echo "local is already installed"
else
  sudo apt install -y ${HOME}/Downloads/local-9.2.9-linux.deb > /dev/null 2>&1
  echo "local is installed"
fi

