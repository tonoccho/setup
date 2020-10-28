#!/bin/bash
apt update

if  which jq > /dev/null 2>&1
then
  echo "jq is installed ..."
else
  echo "Installing jq"
  yes | apt install jq
fi

APT_PACKAGE_NUM=`cat package.json | jq '.apt | length'`
APT_MAX_PACKAGE_INDEX=`echo "${APT_PACKAGE_NUM}-1" | bc`
echo "Processing ${APT_PACKAGE_NUM} apt packages ..."

for i in `seq 0 ${APT_MAX_PACKAGE_INDEX}`
do
  PACKAGE=`cat package.json | jq -r .apt[${i}].package`
  DPKG_RESULT=`dpkg -l ${PACKAGE} | tail -n 1 | cut -b 2`
  if [ "${DPKG_RESULT}" = "i" ]
  then
    echo "[SKIP] ${PACKAGE}"
  else
    yes | apt install ${PACKAGE} > /dev/null 2>&1

    APT_RESULT=$?

    if [ ${APT_RESULT} -eq 0 ]
    then
      echo "[INST] ${PACKAGE}"
    else
      echo "[FAIL] ${PACKAGE} apt rc : ${APT_RESULT}" 
    fi
  fi
done

SNAP_PACKAGE_NUM=`cat package.json | jq '.snap | length'`
SNAP_MAX_PACKAGE_INDEX=`echo "${SNAP_PACKAGE_NUM}-1" | bc`
echo "Processing ${SNAP_PACKAGE_NUM} snap packages ..."

for i in `seq 0 ${SNAP_MAX_PACKAGE_INDEX}`
do
  PACKAGE=`cat package.json | jq -r .snap[${i}].package`
  OPTION=`cat package.json | jq -r .snap[${i}].option`

  SNAP_PKG_INSTALLED=`snap list | grep ${PACKAGE} | wc -l`

  if [ ${SNAP_PKG_INSTALLED} -eq 0 ]
  then
    SNAP_CMD="snap install ${PACKAGE} ${OPTION}"
    eval "${SNAP_CMD}" > /dev/null 2>&1

    SNAP_RESULT=$?

    if [ ${SNAP_RESULT} -eq 0 ]
    then
      echo "[INST] ${PACKAGE}"
    else
      echo "[FAIL] ${PACKAGE} snap rc : ${SNAP_RESULT}"
    fi
  else
    echo "[SKIP] ${PACKAGE}"
  fi
done

GIT_PACKAGE_NUM=`cat package.json | jq '.git | length'`
GIT_MAX_PACKAGE_INDEX=`echo "${GIT_PACKAGE_NUM}-1" | bc`
echo "Processing ${GIT_PACKAGE_NUM} git packages ..."

for i in `seq 0 ${GIT_MAX_PACKAGE_INDEX}`
do
  HOST=`cat package.json | jq -r .git[${i}].host`
  USER=`cat package.json | jq -r .git[${i}].user`
  REPO=`cat package.json | jq -r .git[${i}].repo`
  POSTCMD=`cat package.json | jq -r .git[${i}].postcmd`
  VIA=`cat package.json | jq -r .git[${i}].via`
  LINK=`cat package.json | jq -r .git[${i}].link`

  if [ ${HOST} = "github.com" ] || [ ${HOST} = "bitbucket.org" ]
  then
    if [ ${VIA} = "ssh" ]
    then
      REPO_URL=git@${HOST}:${USER}/${REPO}.git

    else
      REPO_URL=https://${HOST}/${USER}/${REPO}.git
    fi
  else
    REPO_URL=${LINK}
  fi  

  TARGET_HOME=`cat /etc/passwd | grep ${SUDO_USER} | cut -f 6 -d ":"`
  TARGET_DIR=${TARGET_HOME}/.gitrepos/${HOST}/${USER}/${REPO}
  
  su - ${SUDO_USER} -c "git clone ${REPO_URL} ${TARGET_DIR}"

  chown -R ${SUDO_USER} ${TARGET_HOME}/.gitrepos

  su - ${SUDO_USER} -c "${TARGET_DIR}/${POSTCMD}"
done
