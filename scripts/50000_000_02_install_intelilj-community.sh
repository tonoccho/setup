#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

TARGET_DIR=${HOME}/.opt/

if [ -d ${TARGET_DIR}/idea-IC-252.26830.84 ]
then
  echo "easy-diffusion is already installed"
  exit 0
else
  echo -n "installing intellij"
  wget -O ${DOWNLOAD_DIR}/ideaIC-2025.2.3.tar.gz "https://download.jetbrains.com/idea/ideaIC-2025.2.3.tar.gz?_gl=1*ydkyli*_gcl_au*MjAzMzE4ODg5MS4xNzU5NjU3ODMy*FPAU*MjAzMzE4ODg5MS4xNzU5NjU3ODMy*_ga*NzIyMzE0MTEuMTc1OTY1NzgzNg..*_ga_9J976DJZ68*czE3NTk3Mzg5NjckbzIkZzEkdDE3NTk3Mzg5ODIkajQ1JGwwJGgw" 
  tar xzf ${DOWNLOAD_DIR}/ideaIC-2025.2.3.tar.gz -C ${TARGET_DIR} 
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