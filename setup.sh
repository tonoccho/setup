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


info "apt update ..."
#apt update > /dev/null 2>&1
#checkRequirement
processHome
info "finished"
