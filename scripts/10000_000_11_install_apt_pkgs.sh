#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK
SHELL_PATH=$0
SHELL_DESCRIPTION="install additional packages"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "package check start"
# Check and install very basic software
for i in $(echo 'ibus-mozc mozc-data mozc-server mozc-utils-gui git-flow libimage-exiftool-perl yadm g810-led')
do
  INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    info 2 "installing [${i}] ... "
    sudo apt install -y ${i}  > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      info 2 "installation [$i] success"

    elif [ $result -ne 0 ]
    then
      error 2 "installation of [$i] is failed with $result"
      EXIT_CODE=$EXIT_CODE_ERROR
      break
    fi
  else
    info 2 "[${i}] is already installed"
  fi
done

info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE
