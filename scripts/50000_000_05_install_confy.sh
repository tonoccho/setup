#!/usr/bin/env bash
# 必ずやる処理
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
DOWNLOAD_DIR=${HOME}/.local/share/toastee
source ~/miniconda3/bin/activate
if [ -d ${HOME}/.opt/ConfyUI ]
then
  echo "Confu UI is already installed"
else
  echo -n "installing Confy UI ... "
  conda create -n confienv
  conda activate confyenv
  
  git clone https://github.com/comfyanonymous/ComfyUI.git ${HOME}/.opt/ConfyUI
  pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.0
  cd ${HOME}/.opt/ConfyUI
  pip install -r requirements.txt
  result=$?
  if [ $result -eq 0 ]
  then
    show_success_message
  else
    show_error_message $result
    exit 9
  fi
fi
exit 0