#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee

for i in $(echo 'fakeroot')
do
  INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    echo -n "installing $i ... "
    sudo apt install -y ${i}  > /dev/null 2>&1
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

echo "please install davinci resolve by hand"
echo "refer to https://www.danieltufvesson.com/makeresolvedeb for making deb package"
echo "once you have made a deb, please continue"
exit 3