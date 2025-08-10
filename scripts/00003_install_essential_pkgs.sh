#!/bin/bash

for i in $(echo 'git flatpak snapd')
do
  INSTALLATION=$(dpkg -l | grep "^ii  ${i} .*$" | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    sudo apt install -y ${i}
    if [ $? -ne 0 ]
    then
      exot 9
    fi
  fi
done

exit 0