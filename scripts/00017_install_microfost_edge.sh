#!/bin/bash

DOWNLOAD_DIR=${HOME}/.local/share/toastee

if [ ! -d ${DOWNLOAD_DIR} ]
then
  mkdir -p ${DOWNLOAD_DIR}
fi

INSTALLATION=$(dpkg -l | grep '^ii  microsoft-edge-stable .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  exit 0
else
  wget -O ${DOWNLOAD_DIR}/msedge.deb "https://go.microsoft.com/fwlink?linkid=2149051&brand=M102"
  sudo apt install -y ${DOWNLOAD_DIR}/msedge.deb
  if [ $? -ne 0 ]
  then
    exit 9
  fi
fi

exit 0