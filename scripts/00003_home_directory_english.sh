#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

echo -n "changing home directoeis to English ... "
LANG=C xdg-user-dirs-update --force > /dev/null 2>&1
result=$?
if [ $result -eq 0 ]
then
  show_success_message
else
  show_error_message $result
  exit 9
fi

echo "Home folder is now shown in English, please reboot once, then continue"
exit 3
