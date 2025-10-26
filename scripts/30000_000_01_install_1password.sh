#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee


INSTALLATION=$(dpkg -l | grep '^ii  1password .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  echo "1password is already installed"

else
  echo -n "installing 1password ... "
  wget -O ${DOWNLOAD_DIR}/1password.deb "https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb"  > /dev/null 2>&1
  sudo apt install -y ${DOWNLOAD_DIR}/1password.deb  > /dev/null 2>&1
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