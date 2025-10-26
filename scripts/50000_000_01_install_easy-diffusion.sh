#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

TARGET_DIR=${HOME}/.opt/

if [ -d ${TARGET_DIR}/easy-diffusion ]
then
  echo "easy-diffusion is already installed"
  exit 0
else
  echo -n "installing easy-diffusion"
  wget -O ${DOWNLOAD_DIR}/Easy-Diffusion-Linux.zip "https://github.com/cmdr2/stable-diffusion-ui/releases/latest/download/Easy-Diffusion-Linux.zip"
  unzip -d ${TARGET_DIR} ${DOWNLOAD_DIR}/Easy-Diffusion-Linux.zip
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