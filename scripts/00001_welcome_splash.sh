#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

# No precondition check as it always run

# Openins splash
figlet "SETUP"

echo -n "running apt update ... "
sudo apt update > /dev/null 2>&1
result=$?
if [ $result -eq 0 ]
then
  show_success_message
else
  show_error_message $result
  exit 9
fi

echo -n "running apt upgrade ... "
sudo apt upgrade -y > /dev/null 2>&1
result=$?
if [ $result -eq 0 ]
then
  show_success_message
else
  show_error_message $result
  exit 9
fi

exit 1