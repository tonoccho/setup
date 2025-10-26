#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

echo -n "changing setup remote url to ssh"
git remote set-url origin git@github.com:tonoccho/setup.git > /dev/null 2>&1
result=$?
if [ $result -eq 0 ]
then
  show_success_message
else
  show_error_message $result
  exit 9
fi

exit 0