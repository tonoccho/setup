#!/bin/bash
set -e

if [ $(dpkg -l | grep -E "^ii +code " | wc -l) -eq 1 ]
then
  echo "vscode is already installed"
else  
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg  > /dev/null 2>&1
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/  > /dev/null 2>&1
  rm microsoft.gpg  > /dev/null 2>&1
  
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" | \
    sudo tee /etc/apt/sources.list.d/vscode.list  > /dev/null 2>&1
  
  sudo apt install -y code  > /dev/null 2>&1
  
  echo "vscode is installed"
fi
