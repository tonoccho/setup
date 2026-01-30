#!/usr/bin/env bash
# 必ずやる処理
set -e
source $1
if [ -d ${HOME}/Document ]
then
  lwarn "home directory is already engish"
  exit $RC_OK
else
  if LC_ALL=C xdg-user-dirs-update --force
  then
    linfo "home directory is now english"
  else
    lerror "changing home directory is failed with $?"
    exit $RC_ERROR
  fi
fi
exit $RC_OK