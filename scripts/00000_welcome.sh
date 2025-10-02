#!/usr/bin/env bash

# RC
#   0 : Normal end (and do not run again)
#   1 : Normal end (and run again)
#   9 : Error end (and run again)
which figlet > /dev/null 2>&1

if [ $? -ne 0 ]
then
  sudo apt install -y figlet > /dev/null 2>&1
fi

figlet "SETUP"

echo "running apt update"
sudo apt update > /dev/null 2>&1

# Check AMD GPU Driver installation
for i in $(echo 'rocm amdgpu-dkms')
do
  INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    echo "${i} is not installed, please install AMD GPU driver"
    echo "https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html"
    exit 9
  else 
    echo "${i} is installed"  
  fi
done

exit 1