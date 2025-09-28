#!/bin/bash

for i in $(echo 'krita darktable inkscape gimp')
do
  INSTALLATION=$(snap list $i | grep $i | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    sudo snap install $i
    if [ $? -ne 0 ]
    then
      exit 9
    fi
  fi
done

for i in $(echo 'com.obsproject.Studio')
do
  INSTALLATION=$(flatpak list | grep $i | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    flatpak install -y --user flathub $i
    if [ $? -ne 0 ]
    then
      exit 9
    fi
  fi
done

exit 0