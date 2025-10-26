#!/usr/bin/env bash

# スクリプト実行ディレクトリの取得
SCRIPT_DIR=$(cd $(dirname $0);pwd)

# 関数の読み込み
source ${SCRIPT_DIR}/source/setup_args.sh
source ${SCRIPT_DIR}/source/setup_return.sh
source ${SCRIPT_DIR}/source/setup_session.sh
source ${SCRIPT_DIR}/source/setup_context.sh

source ${SCRIPT_DIR}/source/setup_context_initialize.sh

setup_context_initialize
