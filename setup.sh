#/usr/bin/env bash
#
# Setup script runner
#
# This script runs scripts under scripts directory by dictionery order.
# Once the script finished successfully, it is recorded.
#
WORK_SPACE=${HOME}/.local/share/toastee/
DATABASE_PATH=${WORK_SPACE}/toastee.db 
WORKING_DIRECTORY=$(cd $(dirname $0);pwd)

source ${WORKING_DIRECTORY}/functions.sh

# ワークスペースディレクトリがあるかを確認し、なければ作る。
if [ ! -d ${WORK_SPACE} ]
then
  mkdir -p ${WORK_SPACE}
  result=$?
  if [ $result -eq 0 ]
  then
    warn "${WORK_SPACE} not found, but created successfully"
  else
    error "${WORK_SPACE} not found, and fialed to create with [$result]"
    exit 255
  fi
else
  info "${WORK_SPACE} found"
fi

# 実行管理用のsqlite3がインストールされているかを確認し、インストールされていなければインストールする
if [ $(check_apt_pkg_installed sqlite3) -eq 1 ]
then
  info "sqlite3 is already installed"
else
  sudo apt install -y sqlite3 > /dev/null 2>&1
  result=$?
  if [ $result -eq 0 ]
  then
    warn "sqlite3 is not installed but successfully installed"
  else
    error "sqlite3 is not installed and failed to install with $result"
    exit 9
  fi
fi

# 実行管理用のデータベースがあるかをチェックする、なければ作る。
if [ -f ${DATABASE_PATH} ]
then
  info "${DATABASE_PATH} is found"
else
  sqlite3 ${DATABASE_PATH} "CREATE TABLE IF NOT EXISTS CHANGELOG(script_path text, run_at timestamp)"
  result=$?
  if [ $result -eq 0 ]
  then
    warn "${DATABASE_PATH} is not found, but successfully created"
  else
    error "${DATABASE_PATH} is not found and failed to create with ${result}"
    exit 9
  fi
fi

# メインループ、scriptsディレクトリ以下のスクリプトを順次チェックしつつ実行していく
for i in $(find ${WORKING_DIRECTORY}/scripts -type f | sort)
do
  info "checking history of $i"
  
  # 実行履歴にスクリプトがあるかを確認する
  if [ $(sqlite3 ${DATABASE_PATH} "SELECT COUNT(*) FROM CHANGELOG WHERE SCRIPT_PATH='$i'") -eq 0 ]
  then
    info "running $i"
    $i
    result=$?
    if [ $result -eq 0 ]
    then
      sqlite3 ${DATABASE_PATH} "INSERT INTO CHANGELOG VALUES('$i', CURRENT_TIMESTAMP)"
      info "invocation of $i finished successfully, changelog is recorded"
      continue
    elif [ $result -eq 1 ]
    then
      info "invocation of $i finished successfully, changelog is NOT recorded meand it is run next time"
      continue
    elif [ $result -eq 3 ]
    then
      sqlite3 ${DATABASE_PATH} "INSERT INTO CHANGELOG VALUES('$i', CURRENT_TIMESTAMP)"
      info "invocation of $i finished successfully, please reboot the system to continue"
      exit 0
    elif [ $result -eq 9 ]
    then
      error "invocation of $i is failed, process aborted"
      exit 9
    fi
  else
    info "$i is already finished successfully"
  fi  
done

