#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee


if [ -d ${HOME}/miniconda3 ]
then
  echo "miniconda is already installed"

else
  echo -n "installing miniconda ... "
  wget -O ${DOWNLOAD_DIR}/Miniconda3-latest-Linux-x86_64.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
  chmod +x ${DOWNLOAD_DIR}/Miniconda3-latest-Linux-x86_64.sh
  ${DOWNLOAD_DIR}/Miniconda3-latest-Linux-x86_64.sh
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi

exit 0