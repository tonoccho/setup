#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK
SHELL_PATH=$0
SHELL_DESCRIPTION="set home directory to English"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "home directory check start"
IS_ENGLISH=$(cat ~/.config/user-dirs.dirs | grep 'XDG_DESKTOP_DIR="$HOME/Desktop"' | wc -l)

if [ $IS_ENGLISH -eq 0 ]
then
  info 2 "changing home directoeis to English ... "
  LANG=C xdg-user-dirs-update --force > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    info 2 "successfully changed, please reboot to continue"
    EXIT_CODE=$EXIT_CODE_OK_AND_NEED_REBOOT
  else
    error 2 "failed with $result"
    EXIT_CODE=$EXIT_CODE_ERROR
  fi
else
  info 2 "home directory is in English already"
fi

info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE
