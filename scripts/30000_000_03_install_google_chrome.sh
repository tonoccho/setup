#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

INSTALLATION=$(dpkg -l | grep '^ii  google-chrome-stable .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "google chrome is already installed"
  exit 0
else
  echo -n "installing google chrome ..."
  wget -O ${DOWNLOAD_DIR}/chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"  > /dev/null 2>&1
  sudo apt install -y ${DOWNLOAD_DIR}/chrome.deb  > /dev/null 2>&1
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