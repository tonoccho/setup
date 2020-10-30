#!/bin/bash
info() {
  echo -e "[\e[37mINFO\e[m] ${1}"
}
skip() {
  echo -e "[\e[33mSKIP\e[m] ${1}"
}

inst() {
  echo -e "[\e[32mINST\e[m] ${1}"
}

fail() {
  echo -e "[\e[31mFAIL\e[m] ${1}"
}

checkRequirement() {
  if  which jq > /dev/null 2>&1
  then
    info "jq is installed ..."
  else
    info "Installing jq"
    yes | apt install jq
  fi
}

setupHome() {
  local HOME_PACKAGE_NUM=`cat package.json | jq '.home | length'`
  local HOME_MAX_PACKAGE_INDEX=`echo "${HOME_PACKAGE_NUM}-1" | bc`
  
  info "Processing ${HOME_PACKAGE_NUM} home preparation ..."
  
  for i in `seq 0 ${HOME_MAX_PACKAGE_INDEX}`
  do
    local TYPE=`cat package.json | jq -r .home[${i}].type`
    local NAME=`cat package.json | jq -r .home[${i}].name`
    local TARGET_HOME=`cat /etc/passwd | grep ${SUDO_USER} | cut -f 6 -d ":"`
  
    if [ ${TYPE} = "directory" ]
    then
      local DIR_TO_MAKE=${TARGET_HOME}/${NAME}
      if [ -d ${DIR_TO_MAKE} ]
      then
        skip ${DIR_TO_MAKE}
      else
        mkdir -p ${DIR_TO_MAKE}
        chown ${SUDO_USER} ${DIR_TO_MAKE}
        inst ${DIR_TO_MAKE}
      fi
    fi
  done
}

setupApt() {
  local APT_PACKAGE_NUM=`cat package.json | jq '.apt | length'`
  local APT_MAX_PACKAGE_INDEX=`echo "${APT_PACKAGE_NUM}-1" | bc`
  info "Processing ${APT_PACKAGE_NUM} apt packages ..."
  
  for i in `seq 0 ${APT_MAX_PACKAGE_INDEX}`
  do
    local PACKAGE=`cat package.json | jq -r .apt[${i}].package`
    local DPKG_RESULT=`dpkg -l ${PACKAGE} | tail -n 1 | cut -b 2`
    if [ "${DPKG_RESULT}" = "i" ]
    then
      skip ${PACKAGE}
    else
      yes | apt install ${PACKAGE} > /dev/null 2>&1
  
      local APT_RESULT=$?
  
      if [ ${APT_RESULT} -eq 0 ]
      then
        inst ${PACKAGE}
      else
        fail "${PACKAGE} apt rc : ${APT_RESULT}" 
      fi
    fi
  done
}

setupDpkg() {
  local DPKG_PACKAGE_NUM=`cat package.json | jq '.dpkg | length'`
  local DPKG_MAX_PACKAGE_INDEX=`echo "${DPKG_PACKAGE_NUM}-1" | bc`
  info "Processing ${DPKG_PACKAGE_NUM} dpkg packages ..."
  
  for i in `seq 0 ${DPKG_MAX_PACKAGE_INDEX}`
  do
    local PACKAGE=`cat package.json | jq -r .dpkg[${i}].package`
    local URL=`cat package.json | jq -r .dpkg[${i}].url`
    local FILE=`cat package.json | jq -r .dpkg[${i}].file`
    
    local DPKG_RESULT=`dpkg -l ${PACKAGE} | tail -n 1 | cut -b 2`
    if [ "${DPKG_RESULT}" = "i" ]
    then
      skip ${PACKAGE}
    else
      wget -P /tmp ${URL} > /dev/null 2>&1
      yes | apt install /tmp/${FILE} > /dev/null 2>&1
  
      local APT_RESULT=$?
  
      if [ ${APT_RESULT} -eq 0 ]
      then
        inst ${PACKAGE}
      else
        fail "${PACKAGE} apt rc : ${APT_RESULT}" 
      fi
    fi
  done
}

setupSnap() {
  local SNAP_PACKAGE_NUM=`cat package.json | jq '.snap | length'`
  local SNAP_MAX_PACKAGE_INDEX=`echo "${SNAP_PACKAGE_NUM}-1" | bc`
  info "Processing ${SNAP_PACKAGE_NUM} snap packages ..."
  
  for i in `seq 0 ${SNAP_MAX_PACKAGE_INDEX}`
  do
    local PACKAGE=`cat package.json | jq -r .snap[${i}].package`
    local OPTION=`cat package.json | jq -r .snap[${i}].option`
  
    local SNAP_PKG_INSTALLED=`snap list | grep ${PACKAGE} | wc -l`
  
    if [ ${SNAP_PKG_INSTALLED} -eq 0 ]
    then
      local SNAP_CMD="snap install ${PACKAGE} ${OPTION}"
      eval "${SNAP_CMD}" > /dev/null 2>&1
  
      local SNAP_RESULT=$?
  
      if [ ${SNAP_RESULT} -eq 0 ]
      then
        inst ${PACKAGE}
      else
        fail "${PACKAGE} snap rc : ${SNAP_RESULT}"
      fi
    else
      skip ${PACKAGE}
    fi
  done
}

setupGit(){
  local GIT_PACKAGE_NUM=`cat package.json | jq '.git | length'`
  local GIT_MAX_PACKAGE_INDEX=`echo "${GIT_PACKAGE_NUM}-1" | bc`
  info "Processing ${GIT_PACKAGE_NUM} git packages ..."
  
  for i in `seq 0 ${GIT_MAX_PACKAGE_INDEX}`
  do
    local HOST=`cat package.json | jq -r .git[${i}].host`
    local USER=`cat package.json | jq -r .git[${i}].user`
    local REPO=`cat package.json | jq -r .git[${i}].repo`
    local POSTCMD=`cat package.json | jq -r .git[${i}].postcmd`
    local VIA=`cat package.json | jq -r .git[${i}].via`
    local LINK=`cat package.json | jq -r .git[${i}].link`
  
    if [ ${HOST} = "github.com" ] || [ ${HOST} = "bitbucket.org" ]
    then
      if [ ${VIA} = "ssh" ]
      then
        local REPO_URL=git@${HOST}:${USER}/${REPO}.git
  
      else
        local REPO_URL=https://${HOST}/${USER}/${REPO}.git
      fi
    else
      local REPO_URL=${LINK}
    fi  
  
    local TARGET_HOME=`cat /etc/passwd | grep ${SUDO_USER} | cut -f 6 -d ":"`
    local TARGET_DIR=${TARGET_HOME}/.gitrepos/${HOST}/${USER}/${REPO}
  
    if [ -d ${TARGET_DIR} ]
    then
      skip ${REPO}
    else
      su - ${SUDO_USER} -c "git clone ${REPO_URL} ${TARGET_DIR}"
      chown -R ${SUDO_USER} ${TARGET_HOME}/.gitrepos
      su - ${SUDO_USER} -c "${TARGET_DIR}/${POSTCMD}"
      inst ${REPO_URL}
    fi
  done
}

info "apt update ..."
apt update > /dev/null 2>&1
checkRequirement
setupHome
setupApt
setupDpkg
setupSnap
setupGit