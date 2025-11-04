#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh

# No precondition check, this is always run

# Check AMD GPU Driver installation
if [ $(lspci | grep VGA | grep AMD | wc -l) -eq 1 ]
then
  for i in $(echo 'rocm amdgpu-dkms')
  do
    INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
    if [ ${INSTALLATION} -eq 0 ]
    then
      echo "${i} is not installed, please install AMD GPU driver"
      echo "https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html"
      exit 9
    else 
      echo "${i} is already installed"  
    fi
  done
fi

# Check and install very basic software
for i in $(echo 'figlet git flatpak snapd')
do
  INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    echo -n "installing ${i} ... "
    sudo apt install -y ${i}  > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      show_success_message

    elif [ $result -ne 0 ]
    then
      show_error_message $result
      exit 9
    fi
  else
    echo "${i} is already installed"
  fi
done

exit 1