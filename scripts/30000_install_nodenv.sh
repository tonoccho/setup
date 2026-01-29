#!/usr/bin/env bash
set -e

# nodenv をクローン
if [ ! -d "$HOME/.nodenv" ]; then
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv
fi

# node-build プラグインを追加
mkdir -p ~/.nodenv/plugins
if [ ! -d "$HOME/.nodenv/plugins/node-build" ]; then
  git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
fi

# nodenv 初期化設定をシェルに追加
if ! grep -q 'nodenv init' ~/.bashrc; then
  echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(nodenv init -)"' >> ~/.bashrc
fi

# 現在のシェルに反映
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
