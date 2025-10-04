#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

if [ -f /etc/apt/sources.list.d/obsproject-ubuntu-obs-studio-noble.sources ]
then
  echo "the repository of obs-studio has already been added"
  exit 0
fi

echo "adding the repository of obs-studio ... "
sudo add-apt-repository ppa:obsproject/obs-studio
result=$?
if [ $result -eq 0 ]
then
  show_success_message
else
  show_error_message
  exit 9
fi

sudo apt update
result=$?
if [ $result -eq 0 ]
then
  show_success_message
else
  show_error_message
  exit 9
fi

exit 0