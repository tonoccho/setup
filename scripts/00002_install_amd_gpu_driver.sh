#!/bin/bash

DOWNLOAD_DIR=${HOME}/.local/share/toastee

if [ ! -d ${DOWNLOAD_DIR} ]
then
  mkdir -p ${DOWNLOAD_DIR}
fi

INSTALLATION=$(dpkg -l | grep '^ii  amdgpu-install .*$' | wc -l)

if [ ${INSTALLATION} -eq 1 ]
then
  exit 0
else
  wget -O ${DOWNLOAD_DIR}/amdgpu-install_6.4.60402-1_all.deb "https://repo.radeon.com/amdgpu-install/6.4.2.1/ubuntu/jammy/amdgpu-install_6.4.60402-1_all.deb"
  sudo apt install -y ${DOWNLOAD_DIR}/amdgpu-install_6.4.60402-1_all.deb
  if [ $? -ne 0 ]
  then
    exit 9
  fi
  sudo amdgpu-install -y --usecase=graphics,rocm
  if [ $? -ne 0 ]
  then
    exit 9
  fi
  sudo usermod -a -G render,video $LOGNAME
fi

exit 0