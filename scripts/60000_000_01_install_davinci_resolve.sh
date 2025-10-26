#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

if [ ! -f ${HOME}/.local/share/toastee/davinci-resolve_20.2.1-mrd1.8.3_amd64.deb ]
then
  echo "please save davinci-resolve_20.2.1-mrd1.8.3_amd64.deb into ${HOME}/.local/share/toastee/"
  exit 9
fi

INSTALLATION=$(dpkg -l | grep "^ii  davinci-resolve .*$" | wc -l)
if [ ${INSTALLATION} -eq 0 ]
then
  echo -n "installing davinci-resolve ... "
  sudo apt install -y ${HOME}/.local/share/toastee/davinci-resolve_20.2.1-mrd1.8.3_amd64.deb  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message
    exit 9
  fi
else
  echo "davinci-resolve is already installed"
fi

exit 0