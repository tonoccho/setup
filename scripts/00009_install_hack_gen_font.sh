#!/bin/bash

DOWNLOAD_DIR=${HOME}/.local/share/toastee
FONT_DIR=${HOME}/.local/share/fonts 
if [ ! -d ${DOWNLOAD_DIR} ]
then
  mkdir -p ${DOWNLOAD_DIR}
fi

if [ ! -d ${FONT_DIR} ]
then
  mkdir -p ${FONT_DIR}
fi

if [ -f ${FONT_DIR}/HackGen35ConsoleNF-Regular.ttf  ]
then
  exit 0
else
  wget -O ${DOWNLOAD_DIR}/HackGen_NF_v2.10.0.zip "https://github.com/yuru7/HackGen/releases/download/v2.10.0/HackGen_NF_v2.10.0.zip"
  unzip -j -d ${FONT_DIR} ${DOWNLOAD_DIR}/HackGen_NF_v2.10.0.zip "*.ttf" 

  if [ $? -ne 0 ]
  then
    exit 9
  fi
fi

exit 0