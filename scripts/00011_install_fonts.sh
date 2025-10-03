#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee
FONT_DIR=${HOME}/.local/share/fonts
if [ -f ${FONT_DIR}/HackGen35ConsoleNF-Regular.ttf  ]
then
  echo "hack gen is already installed"
  exit 0
else
  echo -n "installing hack gen ... "
  wget -O ${DOWNLOAD_DIR}/HackGen_NF_v2.10.0.zip "https://github.com/yuru7/HackGen/releases/download/v2.10.0/HackGen_NF_v2.10.0.zip"  > /dev/null 2>&1
  unzip -j -d ${FONT_DIR} ${DOWNLOAD_DIR}/HackGen_NF_v2.10.0.zip "*.ttf"   > /dev/null 2>&1
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