#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK_BUT_NOT_REGISTER
SHELL_PATH=$0
SHELL_DESCRIPTION="check AMD GPU driver installation"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "gathering AMD GPU information"
AMD_GPU_INSTALLATION=$(lspci | grep VGA | grep AMD | wc -l)
AMD_GPU_INFORMATION=$(lspci | grep VGA | grep AMD)
info 2 "gathered"

info 2 "checking information"
if [ $AMD_GPU_INSTALLATION -eq 1 ]
then
  info 2 "AMD GPU is detected"
else
  into 2 "AMD GPU is not detected"
  EXIT_CODE=$EXIT_CODE_OK_BUT_NOT_REGISTER
fi

if [ $AMD_GPU_INSTALLATION -eq 1 ]
then
  info 2 "checking AMD GPU driver installation"
  for i in $(echo 'rocm amdgpu-dkms')
  do
    INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
    if [ ${INSTALLATION} -eq 0 ]
    then
      info 2 "[${i}] is not installed, please install AMD GPU driver"
      info 2 "https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html"
      EXIT_CODE=$EXIT_CODE_ERROR
      break
    else 
      info 2 "[${i}] is already installed"  
    fi
  done
fi

info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE