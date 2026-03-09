#!/bin/bash
set -e

if [ $(flatpak list | grep it.mijorus.gearlever | wc -l) -eq 1 ]
then
  echo "Gear Lever is already installed"
else
  flatpak install -y flathub it.mijorus.gearlever > /dev/null 2>&1
  echo "Gear Lever is installed"
fi

if [ ! -d ${HOME}/AppImages ]
then
  mkdir -p ${HOME}/AppImages
  echo "${HOME}/AppImages is created"
else
  echo "${HOME}/AppImages is found"
fi