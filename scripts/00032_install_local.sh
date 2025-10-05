#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

echo "Please access https://localwp.com/ then download deb file as ${HOME}/.local/share/toastee/local.deb"
read -p "Press enter to continue"

if [ ! -f ${HOME}/.local/share/toastee/local.deb ]
then
  echo "file is not stored"
  exit 9
fi

INSTALLATION=$(dpkg -l | grep '^ii  local .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "local is already installed"
  exit 0
else
  echo -n "installing app image launcher ..."
  sudo apt install -y ${HOME}/.local/share/toastee/local.deb  > /dev/null 2>&1
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