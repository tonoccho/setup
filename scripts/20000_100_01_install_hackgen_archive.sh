
#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK
SHELL_PATH=$0
SHELL_DESCRIPTION="install hack gen font"
DOWNLOAD_DIR=${HOME}/.local/share/toastee
FONT_DIR=${HOME}/.local/share/fonts

CAN_PROCEED=0

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "check font installation"
# check if font is installed
if [ -f ${FONT_DIR}/HackGen35ConsoleNF-Regular.ttf  ]
then
  info 2 "hack gen is already installed"
  
else
  info 2 "check font archive"
  if [ -f ${DOWNLOAD_DIR}/HackGen_NF_v2.10.0.zip ]
  then
    info 2 "font archive file is already downloaded"
  else
    info 2 "downloading hackgen archive"
    wget -O ${DOWNLOAD_DIR}/HackGen_NF_v2.10.0.zip "https://github.com/yuru7/HackGen/releases/download/v2.10.0/HackGen_NF_v2.10.0.zip"  > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      info 2 "archive is downloaded"
      info 2 "install font"
      unzip -j -d ${FONT_DIR} ${DOWNLOAD_DIR}/HackGen_NF_v2.10.0.zip "*.ttf"   > /dev/null 2>&1
        result=$?
        if [ $result -eq 0 ]
        then
          info 2 "installation successfully finished"
        else
          error 2 "installation failed with $result"
          EXIT_CODE=$EXIT_CODE_ERROR
        fi
    else
      error 2 "failed to download archive with $result"
      EXIT_CODE=$EXIT_CODE_ERROR
    fi
  fi
fi
info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE
