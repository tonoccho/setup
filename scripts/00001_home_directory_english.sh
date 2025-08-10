#!/usr/bin/env bash

LANG=C xdg-user-dirs-update --force

if [ $? -ne 0 ]
then
  exit 9
fi

exit 0
