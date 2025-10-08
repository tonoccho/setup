#!/usr/bin/env bash
# 開始メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK_BUT_NOT_REGISTER
SHELL_PATH=$0
SHELL_DESCRIPTION="just showing start message"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"
info 2 "SETUP START" ''
info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE