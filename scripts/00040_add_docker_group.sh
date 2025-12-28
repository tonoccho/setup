#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
sudo groupadd docker
# check precondition
for i in `echo docker render`
do
  echo -n "checking $LOGNAME is a member of $i ... "
  result=$(getent group $i |  grep $LOGNAME | wc -l)
  if [ $result -eq 1 ]
  then
    echo "already the member of $i"
  elif [ $result -eq 0 ]
  then
    echo -n "adding $LOGNAME to group $i ... "
    sudo usermod -a -G $i $LOGNAME > /dev/null 2>&1
    result=$?
    if [ $result -ne 0 ]
    then
      show_error_message $result
      exit 9
    else
      show_success_message
      id $LOGNAME
    fi
  fi
done

exit 3