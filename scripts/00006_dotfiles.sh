#!/bin/bash

which yadm > /dev/null 2>&1

if [ $? -ne 0 ]
then
  sudo apt install -y yadm > /dev/null 2>&1
fi

if [ -d ${HOME}/.local/share/yadm/repo.git ]
then
  exit 0
else
  yadm clone https://github.com/tonoccho/dotfiles.git > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    exit 9
  fi
fi

exit 0