#!/usr/bin/env bash
set -e

if [ $(dpkg -l | grep -E "^ii +1password " | wc -l) -eq 1 ]
then
  echo "1password is already installed"
else
  curl -sS https://downloads.1password.com/linux/keys/1password.asc \
  | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg > /dev/null 2>&1

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] \
  https://downloads.1password.com/linux/debian/amd64 stable main" \
    | sudo tee /etc/apt/sources.list.d/1password.list > /dev/null 2>&1

  sudo apt install -y 1password > /dev/null 2>&1

  echo "1password is installed"
fi


