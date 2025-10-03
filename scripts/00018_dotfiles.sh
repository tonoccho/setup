#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

if [ -d ${HOME}/.local/share/yadm/repo.git ]
then
  echo "dotfiles are already cloned"
  exit 0
else
  echo -n "cloning dotfiles ... "
  yadm clone git@github.com:tonoccho/dotfiles.git -f > /dev/null 2>&1
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