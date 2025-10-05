#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

INSTALLATION=$(dpkg -l | grep '^ii  appimagelauncher .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "app-image-launcher is already installed"
  exit 0
else
  echo -n "installing app image launcher ..."
  wget -O ${DOWNLOAD_DIR}/appimagelauncher.deb "https://github.com/TheAssassin/AppImageLauncher/releases/download/v3.0.0-beta-1/appimagelauncher_3.0.0-alpha-4-gha275.0bcc75d_amd64.deb"  > /dev/null 2>&1
  sudo apt install -y ${DOWNLOAD_DIR}/appimagelauncher.deb  > /dev/null 2>&1
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