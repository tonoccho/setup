#!/bin/bash

DOWNLOAD_DIR=${HOME}/.local/share/toastee

if [ ! -d ${DOWNLOAD_DIR} ]
then
  mkdir -p ${DOWNLOAD_DIR}
fi

INSTALLATION=$(dpkg -l | grep '^ii  google-chrome-stable .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  exit 0
else
  wget -O ${DOWNLOAD_DIR}/chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  sudo apt install -y ${DOWNLOAD_DIR}/chrome.deb
  if [ $? -ne 0 ]
  then
    exit 9
  fi
fi

exit 0