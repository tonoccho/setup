#!/usr/bin/env bash

# RC
#   0 : Normal end (and do not run again)
#   1 : Normal end (and run again)
#   9 : Error end (and run again)
which figlet > /dev/null 2>&1

if [ $? -ne 0 ]
then
  sudo apt install -y figlet > /dev/null 2>&1
fi

figlet "SETUP"

exit 1