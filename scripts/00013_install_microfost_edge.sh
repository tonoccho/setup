#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

INSTALLATION=$(dpkg -l | grep '^ii  microsoft-edge-stable .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "microsoft edge is already installed"
  exit 0
else
  echo -n "installing microsoft edge ... "
  wget -O ${DOWNLOAD_DIR}/msedge.deb "https://go.microsoft.com/fwlink?linkid=2149051&brand=M102"  > /dev/null 2>&1
  sudo apt install -y ${DOWNLOAD_DIR}/msedge.deb  > /dev/null 2>&1
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