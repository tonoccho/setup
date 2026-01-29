#!/usr/bin/env bash
# 必ずやる処理
#SCRIPT_DIR=$(cd $(dirname $0);pwd)
#source ${SCRIPT_DIR}/../functions.sh
#
#for i in $(echo '')
#do
#  INSTALLATION=$(flatpak list | grep ${i} | wc -l)
#  if [ ${INSTALLATION} -eq 0 ]
#  then
#    echo -n "installing $i ... "
#    flatpak install flathub $i > /dev/null 2>&1
#    result=$?S
#    if [ $result -eq 0 ]
#    then
#      show_success_message
#    else
#      show_error_message
#      exit 9
#    fi
#  else
#    echo "$i is already installed"
#  fi
#done

exit 0