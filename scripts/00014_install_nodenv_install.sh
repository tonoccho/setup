#!/bin/bash
~/.nodenv/bin/nodenv init
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build

exit 0