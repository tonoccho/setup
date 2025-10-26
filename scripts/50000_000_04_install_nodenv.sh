#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

if [ ! -d ${HOME}/.nodenv ]
then
  echo "installing nodenv ... "
  git clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv  > /dev/null 2>&1
  ${HOME}/.nodenv/bin/nodenv init
  git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
else 
  echo "nodenv is already installed"
fi

exit 0