#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee


INSTALLATION=$(dpkg -l | grep '^ii  rapid_raw .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "rapid raw is already installed"

else
  echo -n "installing rapid raw ... "
  wget -O ${DOWNLOAD_DIR}/03_RapidRAW_v1.4.1_ubuntu-24.04_amd64.deb "https://github.com/CyberTimon/RapidRAW/releases/download/v1.4.1/03_RapidRAW_v1.4.1_ubuntu-24.04_amd64.deb"  > /dev/null 2>&1
  sudo apt install -y ${DOWNLOAD_DIR}/03_RapidRAW_v1.4.1_ubuntu-24.04_amd64.deb  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi

echo "launch 1 password for the initial setup, then continue"

exit 3