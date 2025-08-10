#!/bin/bash

DOWNLOAD_DIR=${HOME}/.local/share/toastee

if [ ! -d ${DOWNLOAD_DIR} ]
then
  mkdir -p ${DOWNLOAD_DIR}
fi

INSTALLATION=$(dpkg -l | grep '^ii  1password .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  exit 0
else
  wget -O ${DOWNLOAD_DIR}/1password.deb "https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb"
  sudo apt install -y ${DOWNLOAD_DIR}/1password.deb
  if [ $? -ne 0 ]
  then
    exit 9
  fi
fi

exit 0