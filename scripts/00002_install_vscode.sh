#!/bin/bash

DOWNLOAD_DIR=${HOME}/.local/share/toastee

if [ ! -d ${DOWNLOAD_DIR} ]
then
  mkdir -p ${DOWNLOAD_DIR}
fi

INSTALLATION=$(dpkg -l | grep '^ii  code .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  exit 0
else
  wget -O ${DOWNLOAD_DIR}/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  sudo apt install -y ${DOWNLOAD_DIR}/code.deb
  if [ $? -ne 0 ]
  then
    exit 9
  fi
fi

exit 0