#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh


for i in $(echo 'ca-certificates curl')
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

if [ ! -f /etc/apt/keyrings/docker.asc ]
then
  echo -n "install docker GPG key ... "
  sudo install -m 0755 -d /etc/apt/keyrings  > /dev/null 2>&1
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc  > /dev/null 2>&1
  sudo chmod a+r /etc/apt/keyrings/docker.asc  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi

if [ ! -f /etc/apt/sources.list.d/docker.list ]
then
  echo -n "adding docker repository to apt source ... "
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update  > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi

for i in $(echo 'docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin')
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

exit 0