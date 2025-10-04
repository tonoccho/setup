#/usr/bin/env bash
#
# Setup script runner
#
# This script runs scripts under scripts directory by dictionery order.
# Once the script finished successfully, it is recorded.
#
if [ ! -d ${HOME}/.local/share/toastee/ ]
then
  mkdir -p ${HOME}/.local/share/toastee/
fi

CURRENT=$(cd $(dirname $0);pwd)
DATABASE_PATH=${HOME}/.local/share/toastee/toastee.db 

which sqlite3 > /dev/null 2>&1
if [ $? -ne 0 ]
then
  sudo apt install -y sqlite3 > /dev/null 2>&1
fi

echo ".open ${DATABASE_PATH}" | sqlite3
sqlite3 ${DATABASE_PATH} "CREATE TABLE IF NOT EXISTS CHANGELOG(script_path text, run_at timestamp)"

for i in `ls ${CURRENT}/scripts`
do
  echo -n "running ${CURRENT}/scripts/$i ... "
  count=$(sqlite3 ${DATABASE_PATH} "SELECT COUNT(*) FROM CHANGELOG WHERE script_path=\"${CURRENT}/scripts/$i\"")
  if [ $count -eq 1 ]
  then
    echo "skipped"   
  else
    ${CURRENT}/scripts/$i
    rc=$?
    if [ $rc -eq 0 ]
    then
      sqlite3 ${DATABASE_PATH} "INSERT INTO CHANGELOG VALUES(\"${CURRENT}/scripts/$i\", CURRENT_TIMESTAMP)"
      echo "success"
      
    elif [ $rc -eq 1 ]
    then
      sqlite3 ${DATABASE_PATH} "INSERT INTO CHANGELOG VALUES(\"${CURRENT}/scripts/$i\", CURRENT_TIMESTAMP)"
      echo "success, but will be run next time"

    elif [ $rc -eq 3 ]
    then
      sqlite3 ${DATABASE_PATH} "INSERT INTO CHANGELOG VALUES(\"${CURRENT}/scripts/$i\", CURRENT_TIMESTAMP)"
      
      break    

    elif [ $rc -eq 9 ]
    then
      echo "failed"
      break
    fi
  fi
done
echo "setup finished, show ing CHANGELOG"
sqlite3 ${DATABASE_PATH} "SELECT * FROM CHANGELOG"

