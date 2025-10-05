#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

## --classicがいるパッケージ
for i in $(echo 'shotcut')
do
  INSTALLATION=$(snap list ${i} | grep latest/stable | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    echo -n "installing $i ... "
    sudo snap install $i --classic > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      show_success_message
    else
      show_error_message
      exit 9
    fi
  else
    echo "$i is already installed"
  fi
done

## そのまま入れるパッケージ
for i in $(echo 'intel-npu-driver')
do
  INSTALLATION=$(snap list ${i} | grep latest/stable | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    echo -n "installing $i ... "
    sudo snap install $i --classic > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      show_success_message
    else
      show_error_message
      exit 9
    fi
  else
    echo "$i is already installed"
  fi
done

exit 0