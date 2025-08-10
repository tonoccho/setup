#!/bin/bash

for i in $(echo 'libapr1 libaprutil1 libxcb-composite0 libxcb-cursor0 libxcb-damage0')
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