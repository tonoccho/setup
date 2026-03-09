#/usr/bin/env bash
set -e
# check prerequisite packeges, and install if not found
if [ -x $(which figlet > /dev/null 2>&1) ]
then
  sudo apt install figlet > /dev/null 2>&1
fi

# call command
figlet "SETUP"
