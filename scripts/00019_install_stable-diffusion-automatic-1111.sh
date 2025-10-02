#!/bin/bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update

for i in $(echo 'wget git python3 python3-venv libgl1 libglib2.0-0 python3.11')
do
  INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    sudo apt install -y ${i}
    if [ $? -ne 0 ]
    then
      exit 9
    fi
  fi
done

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui ${HOME}/Documents/ai/stable-diffusion-webui

exit 0