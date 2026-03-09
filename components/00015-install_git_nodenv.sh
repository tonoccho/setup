#!/bin/bash
set -e

if [ ! -d ${HOME}/.nodenv ]
then
  git clone https://github.com/nodenv/nodenv.git ~/.nodenv
  echo "nodenv is cloned"
else
  echo "nodenv is already installed"
fi

if [ ! -d ~/.nodenv/plugins/node-build ]
then
  git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build
  echo "node build cloned"
else
  echo "node build is already cloned"
fi