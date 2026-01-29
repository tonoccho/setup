#!/usr/bin/env bash

set -e

# Oracle の GPG キーを登録
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc \
  | sudo gpg --dearmor -o /usr/share/keyrings/oracle-vbox.gpg

# Ubuntu / Pop!_OS のバージョンを取得
UBUNTU_CODENAME=$(source /etc/os-release && echo "$UBUNTU_CODENAME")

# VirtualBox のリポジトリを追加
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-vbox.gpg] \
https://download.virtualbox.org/virtualbox/debian $UBUNTU_CODENAME contrib" \
  | sudo tee /etc/apt/sources.list.d/virtualbox.list

exit 0