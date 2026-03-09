#!/bin/bash
set -e

if [ $(dpkg -l | grep -E "^ii +microsoft-edge-stable " | wc -l) -eq 1 ]
then
  echo "Microsoft edge is already installed"
else  
  # Microsoft GPG キーを取得して登録
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg > /dev/null 2>&1
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ > /dev/null 2>&1
  rm microsoft.gpg > /dev/null 2>&1
  
  # Microsoft Edge APT リポジトリを追加（Stable チャンネル）
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | \
    sudo tee /etc/apt/sources.list.d/microsoft-edge.list  > /dev/null 2>&1
  
  # パッケージ情報更新 & Edge インストール
  sudo apt update  > /dev/null 2>&1
  sudo apt install -y microsoft-edge-stable  > /dev/null 2>&1
  
  echo "Microsoft edge is installed"
fi
