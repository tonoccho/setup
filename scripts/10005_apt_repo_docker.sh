#!/usr/bin/env bash

set -e

# 依存パッケージをインストール
sudo apt update
sudo apt install -y ca-certificates curl gnupg

# Docker の GPG キーを登録
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Ubuntu / Pop!_OS のコードネームを取得
UBUNTU_CODENAME=$(source /etc/os-release && echo "$UBUNTU_CODENAME")

# Docker の APT リポジトリを追加
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

exit 0