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

processDpkg() {
  local dpkgNum=`length .dpkg`
  info "Processing ${dpkgNum} dpkgs"
  local dpkgMaxIndex=`decrement ${dpkgNum}`
  for i in `seq 0 ${dpkgMaxIndex}`
  do
    local dpkgPackage=`cat package.json | jq -r ".dpkg[${i}].package"`
    local dpkgUrl=`cat package.json | jq -r ".dpkg[${i}].url"`
    local dpkgFile=`echo ${dpkgUrl} | rev | cut -d '/' -f 1 | rev`
    local packageSituation=`dpkg -l ${dpkgPackage} | grep ${dpkgPackage} | cut -d ' ' -f 1`

    if [ ! -f ${HOME}/.cache/setup/${dpkgFile} ]
    then
      curl -o ${HOME}/.cache/setup/${dpkgFile} --create-dirs -s ${dpkgUrl}
    fi

    if [ ${packageSituation} = "ii" ]
    then
      skip "${dpkgPackage} is already installed"
    else
      yes | sudo dpkg -i ${HOME}/.cache/setup/${dpkgFile} > /dev/null 2>&1
      inst "${dpkgPackage} is installed"
    fi
  done
}

processGit() {
  local gitrNum=`length .git.repos`
  info "Processing ${gitrNum} git repositories"
  local gitMaxIndex=`decrement ${gitrNum}`
  for i in `seq 0 ${gitMaxIndex}`
  do
    local host=`cat package.json | jq -r ".git.repos[${i}].host"`
    local protocol=`cat package.json | jq -r ".git.repos[${i}].protocol"`
    local repository=`cat package.json | jq -r ".git.repos[${i}].repo"`
    local cloneto=`cat package.json | jq -r ".git.repos[${i}].cloneto"`
    cloneto=`eval echo ${cloneto}`

    if [ ${host} = "null" ]
    then
      host="github.com"
    fi

    if [ ${protocol} = "null" ]
    then
      protocol="https"
    fi

    if [ ${cloneto} = "null" ]
    then
      cloneto="${HOME}/.gitrepos/${host}/${repository}"
    fi

    if [ ${protocol} = "https" ]
    then
      local command="git clone https://${host}/${repository}.git ${cloneto}"

    elif [ ${protocol} = "ssh" ]
    then
      local command="git clone git@${host}:${repository}.git ${cloneto}"
    fi

    if [ -d ${cloneto} ]
    then
      skip "${repository} is already cloned"
    else
      ${command} > /dev/null 2>&1
      inst "${repository} is cloned"
    fi

  done

}
info "apt update ..."
#apt update > /dev/null 2>&1
#checkRequirement
processHome
processApt
processSnap
processDpkg
processGit
info "finished"
