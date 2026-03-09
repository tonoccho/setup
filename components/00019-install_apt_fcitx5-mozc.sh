#/usr/bin/env bash
set -e

PACKAGES=(
  fcitx5-mozc
)
# check prerequisite packeges, and install if not found
for ((i=0; i<${#PACKAGES[@]}; i++))
do
  if [ $(dpkg -l | grep -E "^ii +${PACKAGES[$i]} " | wc -l) -eq 1 ]
  then
    echo "${PACKAGES[$i]} is already installed"
  else
    echo -n "installing ${PACKAGES[$i]} ... "
    sudo apt install -y ${PACKAGES[$i]} > /dev/null 2>&1
    result=$?
    if [ $result -eq 0 ]
    then
      echo "success"
    else
      echo "failed with $result"
      exit 1
    fi
  fi
done

exit 0