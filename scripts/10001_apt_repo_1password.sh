#!/usr/bin/env bash

set -e

# 1Password の GPG キーを登録
curl -sS https://downloads.1password.com/linux/keys/1password.asc \
  | sudo gpg --dearmor -o /usr/share/keyrings/1password.gpg

# APT リポジトリを追加
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] \
https://downloads.1password.com/linux/debian/amd64 stable main" \
  | sudo tee /etc/apt/sources.list.d/1password.list

exit 0