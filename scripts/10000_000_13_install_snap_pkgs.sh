
#!/usr/bin/env bash
# 終了メッセージを表示するだけのスクリプト。
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/../functions.sh
source ${SCRIPT_DIR}/../constants.sh

EXIT_CODE=$EXIT_CODE_OK
SHELL_PATH=$0
SHELL_DESCRIPTION="install snap packages"

info 0 "start ${SHELL_PATH} - ${SHELL_DESCRIPTION}"

info 2 "package check start"
## --classicがいるパッケージ
for i in $(echo 'intel-npu-driver vlc')
do
  INSTALLATION=$(snap list ${i} | grep latest/stable | wc -l)
  if [ ${INSTALLATION} -eq 0 ]
  then
    info 2 "installing $i ... "
    sudo snap install $i  > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      info 2 "$i is installed successfully"
    else
      error 2 "failed to install $i with $result"
      EXIT_CODE=$EXIT_CODE_ERROR
      break
    fi
  else
    info 2 "$i is already installed"
  fi
done

info 0 "finish ${SHELL_PATH} (${EXIT_CODE})"

exit $EXIT_CODE
