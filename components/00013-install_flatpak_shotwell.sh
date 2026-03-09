#!/bin/bash
set -e

if [ $(flatpak list | grep org.gnome.Shotwell | wc -l) -eq 1 ]
then
  echo "Shotwell is already installed"
else
  echo "installing shotwell ..."
  flatpak install -y flathub org.gnome.Shotwell > /dev/null 2>&1
  echo "Shotwell is installed"
fi