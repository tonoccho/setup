#!/usr/bin/env bash
# 必ずやる処理
set -e

source $1
groups=(video docker render)

# check precondition
for i in "${goups[@]}"
do
  echo -n "checking $LOGNAME is a member of $i ... "
  if id -nG "$LOGNAME" | grep -qw $i
  then
    linfo "already the member of $i"
  elif [ $result -eq 0 ]
  then
    echo -n "adding $LOGNAME to group $i ... "
    if sudo usermod -a -G $i $LOGNAME > /dev/null 2>&1
    then
      linfo "$LOGNAME is now the member of $i"
    else
      lerror "failed to add $LOGNAME to $i by $?"
      exit 9
    fi
  fi
done

exit 0