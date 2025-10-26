#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

INSTALLATION=$(dpkg -l | grep '^ii  code .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "vscode is already installed"
  exit 0
else
  echo -n "installing vscode ..."
  wget -O ${DOWNLOAD_DIR}/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"  > /dev/null 2>&1
  sudo apt install -y ${DOWNLOAD_DIR}/code.deb  > /dev/null 2>&1
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