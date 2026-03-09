#!/bin/bash
set -e

if [ ! -d ${HOME}/.pyenv ]
then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  echo "pyenv is cloned"
else
  echo "pyenv is already installed"
fi

PACKAGES=(
    make 
    build-essential 
    libssl-dev
    zlib1g-dev
    libbz2-dev 
    libreadline-dev 
    libsqlite3-dev 
    curl 
    git
    libncursesw5-dev 
    xz-utils 
    tk-dev 
    libxml2-dev 
    libxmlsec1-dev 
    libffi-dev 
    liblzma-dev
    wget 
    llvm
    libncurses5-dev 
    python3-openssl 
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