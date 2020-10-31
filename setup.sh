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

length() {
  cat package.json | jq "${1} | length"
}

decrement() {
  echo "${1}-1" | bc
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
  local num=`length ".home"`
  local maxIndex=`decrement ${num}`
  
  info "Processing ${num} home preparation ..."
  
  for i in `seq 0 ${maxIndex}`
  do
    local type=`cat package.json | jq -r .home[${i}].type`
    local name=`cat package.json | jq -r .home[${i}].name`
    local targetHome=`cat /etc/passwd | grep ${SUDO_USER} | cut -f 6 -d ":"`
  
    if [ ${type} = "directory" ]
    then
      local dirToMake=${targetHome}/${name}
      if [ -d ${dirToMake} ]
      then
        skip ${dirToMake}
      else
        mkdir -p ${dirToMake}
        chown ${SUDO_USER} ${dirToMake}
        inst ${dirToMake}
      fi
    fi
  done
}

setupApt() {
  local num=`length ".apt"`
  local nummaxIndex=`decrement ${num}`
  info "Processing ${num} apt packages ..."
  
  for i in `seq 0 ${nummaxIndex}`
  do
    local package=`cat package.json | jq -r .apt[${i}].package`
    local result=`dpkg -l ${package} | tail -n 1 | cut -b 2`
    if [ "${result}" = "i" ]
    then
      skip ${package}
    else
      yes | apt install ${package} > /dev/null 2>&1
  
      local result=$?
  
      if [ ${result} -eq 0 ]
      then
        inst ${package}
      else
        fail "${package} apt rc : ${result}" 
      fi
    fi
  done
}

setupDpkg() {
  local num=`length ".dpkg"`
  local maxIndex=`decrement ${num}`
  info "Processing ${num} dpkg packages ..."
  
  for i in `seq 0 ${maxIndex}`
  do
    local package=`cat package.json | jq -r .dpkg[${i}].package`
    local url=`cat package.json | jq -r .dpkg[${i}].url`
    local file=`cat package.json | jq -r .dpkg[${i}].file`
    
    local result=`dpkg -l ${package} | tail -n 1 | cut -b 2`
    if [ "${result}" = "i" ]
    then
      skip ${package}
    else
      wget -P /tmp ${url} > /dev/null 2>&1
      yes | apt install /tmp/${file} > /dev/null 2>&1
  
      local result=$?
  
      if [ ${result} -eq 0 ]
      then
        inst ${package}
      else
        fail "${package} apt rc : ${result}" 
      fi
    fi
  done
}

setupSnap() {
  local num=`length ".snap"`
  local maxIndex=`decrement ${num}`
  info "Processing ${num} snap packages ..."
  
  for i in `seq 0 ${maxIndex}`
  do
    local package=`cat package.json | jq -r .snap[${i}].package`
    local option=`cat package.json | jq -r .snap[${i}].option`
  
    local installed=`snap list | grep ${package} | wc -l`
  
    if [ ${installed} -eq 0 ]
    then
      local snapCmd="snap install ${package} ${option}"
      eval "${snapCmd}" > /dev/null 2>&1
  
      local result=$?
  
      if [ ${result} -eq 0 ]
      then
        inst ${package}
      else
        fail "${package} snap rc : ${result}"
      fi
    else
      skip ${package}
    fi
  done
}

setupGit(){
  local num=`length ".git"`
  local maxIndex=`decrement ${num}`
  info "Processing ${num} git packages ..."
  
  for i in `seq 0 ${maxIndex}`
  do
    local host=`cat package.json | jq -r .git[${i}].host`
    local user=`cat package.json | jq -r .git[${i}].user`
    local repo=`cat package.json | jq -r .git[${i}].repo`
    local postCommand=`cat package.json | jq -r .git[${i}].postcmd`
    local protocol=`cat package.json | jq -r .git[${i}].via`
    local url=`cat package.json | jq -r .git[${i}].link`
  
    if [ ${host} = "github.com" ] || [ ${host} = "bitbucket.org" ]
    then
      if [ ${protocol} = "ssh" ]
      then
        local repo_url=git@${host}:${user}/${repo}.git
  
      else
        local repo_url=https://${host}/${user}/${repo}.git
      fi
    else
      local repo_url=${url}
    fi  
  
    local targetHome=`cat /etc/passwd | grep ${SUDO_USER} | cut -f 6 -d ":"`
    local targetDir=${targetHome}/.gitrepos/${host}/${user}/${repo}
  
    if [ -d ${targetDir} ]
    then
      skip ${repo}
    else
      su - ${SUDO_USER} -c "git clone ${repo_url} ${targetDir}"
      chown -R ${SUDO_USER} ${targetHome}/.gitrepos
      su - ${SUDO_USER} -c "${targetDir}/${postCommand}"
      inst ${repo_url}
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