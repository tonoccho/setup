#!/bin/bash

for i in $(echo 'ibus-mozc mozc-data mozc-server mozc-utils-gui')
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

exit 0