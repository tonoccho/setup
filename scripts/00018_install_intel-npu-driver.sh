#!/bin/bash

for i in $(echo 'intel-npu-driver')
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

exit 0