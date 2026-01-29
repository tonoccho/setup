#!/usr/bin/env bash
set -e

# pyenv 本体をクローン
if [ ! -d "$HOME/.pyenv" ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

# python-build プラグインを追加
mkdir -p ~/.pyenv/plugins
if [ ! -d "$HOME/.pyenv/plugins/python-build" ]; then
  git clone https://github.com/pyenv/python-build.git ~/.pyenv/plugins/python-build
fi

# シェル設定を追加
if ! grep -q 'pyenv init' ~/.bashrc; then
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
fi

# 現在のシェルに反映
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"