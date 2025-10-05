#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
SOURCE_DIR=${HOME}/Documents/src/

if [ ! -d ${SOURCE_DIR}/tonoccho.com ]
then
  git clone git@github.com:tonoccho/tonoccho.com.git ${SOURCE_DIR}/tonoccho.com  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi

if [ ! -d ${SOURCE_DIR}/vscode-blogcard ]
then
  git clone git@github.com:tonoccho/vscode-blogcard.git ${SOURCE_DIR}/vscode-blogcard  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi

if [ ! -d ${SOURCE_DIR}/big_the_bujop ]
then
  git clone git@github.com:tonoccho/big_the_bujop.git ${SOURCE_DIR}/big_the_bujop  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi

if [ ! -d ${SOURCE_DIR}/scripton_tea ]
then
  git clone git@github.com:tonoccho/scripton_tea.git ${SOURCE_DIR}/scripton_tea  > /dev/null 2>&1
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