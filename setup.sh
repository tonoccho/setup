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
    yes | sudo pt install jq
  fi
}

processHome() {
  local directoryNum=`length .home.directories`
  info "Processing ${directoryNum} directories"
  local directoryMaxIndex=`decrement ${directoryNum}`
  for i in `seq 0 ${directoryMaxIndex}`
  do
    local directoryName=`cat package.json | jq -r ".home.directories[${i}]"`
    if [ -d ${HOME}/${directoryName} ]
    then
      skip "${HOME}/${directoryName} is already exists"
    else
      mkdir -p ${HOME}/${directoryName}
      inst "${HOME}/${directoryName} is created"
    fi
  done

  info "Finished directory process"
}

processApt() {
  local packageNum=`length .apt`
  info "Processing ${packageNum} apt packages"
  local packageMaxIndex=`decrement ${packageNum}`
  for i in `seq 0 ${packageMaxIndex}`
  do
    local packageName=`cat package.json | jq -r ".apt[${i}]"`
    local packageSituation=`dpkg -l ${packageName} | grep ${packageName} | cut -d ' ' -f 1`
    if [ ${packageSituation} = "ii" ]
    then
      skip "${packageName} is already installed"
    else
      yes | sudo apt install ${packageName} > /dev/null 2>&1
      inst "${packageName} is installed"
   fi
  done
  info "Finished apt package process"
}

processSnap() {
  local snapNum=`length .snap`
  info "Processing ${snapNum} snap packages"
  local snapMaxIndex=`decrement ${snapNum}`
  for i in `seq 0 ${snapMaxIndex}`
  do
    local snapName=`cat package.json | jq -r ".snap[${i}].package"`
    local snapOption=`cat package.json | jq -r ".snap[${i}].option" | grep -v null`
    local snapSituation=`snap list ${snapName} | grep ${snapName} | wc -l`
    if [ ${snapSituation} -eq 1 ]
    then
      skip "${snapName} is already installed"
    else
      sudo snap install ${snapName} ${snapOption}
      inst "${snapName} is installed"
    fi
  done
}


info "apt update ..."
#apt update > /dev/null 2>&1
#checkRequirement
processHome
processApt
processSnap
info "finished"
