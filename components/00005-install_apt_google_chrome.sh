#!/bin/bash
set -e

if [ $(dpkg -l | grep -E "^ii +google-chrome-stable " | wc -l) -eq 1 ]
then
  echo "Google Chrome is already installed"
else  
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > google.gpg  > /dev/null 2>&1
  sudo install -o root -g root -m 644 google.gpg /etc/apt/trusted.gpg.d/  > /dev/null 2>&1
  rm google.gpg  > /dev/null 2>&1
  
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | \
    sudo tee /etc/apt/sources.list.d/google-chrome.list  > /dev/null 2>&1
  
  sudo apt install -y google-chrome-stable  > /dev/null 2>&1
  
  echo "Google Chrome is installed"
fi
