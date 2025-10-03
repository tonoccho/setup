#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

INSTALLATION=$(dpkg -l | grep '^ii  virtualbox .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "virtualbox is already installed"
  exit 0
else
  echo -n "installing virtualbox ..."
  wget -O ${DOWNLOAD_DIR}/virtualbox.deb "https://download.virtualbox.org/virtualbox/7.2.2/virtualbox-7.2_7.2.2-170484~Ubuntu~noble_amd64.deb"  > /dev/null 2>&1
  sudo apt install -y ${DOWNLOAD_DIR}/virtualbox.deb  > /dev/null 2>&1
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