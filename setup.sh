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
    yes | sudo apt install jq
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
    local packageSituation=`dpkg -l ${packageName} 2> /dev/null | grep ${packageName} | cut -d ' ' -f 1`
    if [ "${packageSituation}" = "ii" ]
    then
      skip "${packageName} is already installed"
    else
      yes | sudo apt install ${packageName} > /dev/null 2>&1
      local rc=$?
      if [ ${rc} -eq 0 ]
      then
        inst "${packageName} is installed"
      else
        fail "${packageName} is failed to install with ${rc}"
      fi
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
    local snapSituation=`snap list ${snapName} 2> /dev/null | grep ${snapName} | wc -l`
    if [ ${snapSituation} -eq 1 ]
    then
      skip "${snapName} is already installed"
    else
      sudo snap install ${snapName} ${snapOption} > /dev/null 2>&1
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
    local packageSituation=`dpkg -l ${dpkgPackage} 2> /dev/null | grep ${dpkgPackage} | cut -d ' ' -f 1`

    if [ ! -f ${HOME}/.setup/cache/${dpkgFile} ]
    then
      curl -o ${HOME}/.setup/cache/${dpkgFile} --create-dirs -s ${dpkgUrl}
    fi

    if [ "${packageSituation}" = "ii" ]
    then
      skip "${dpkgPackage} is already installed"
    else
      yes | sudo dpkg -i ${HOME}/.setup/cache/${dpkgFile} > /dev/null 2>&1
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
    local depth=`cat package.json | jq -r ".git.repos[${i}].depth"`
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
      local repourl="https://${host}/${repository}.git"

    elif [ ${protocol} = "ssh" ]
    then
      local repourl="git@${host}:${repository}.git"
    fi

    if [ ! ${depth} = "null" ]
    then
      local command="git clone --depth=${depth} ${repourl} ${cloneto}"
    else
      local command="git clone ${repourl} ${cloneto}"
    fi

    if [ -d ${cloneto} ]
    then
      skip "${repository} is already cloned"
    else
      ${command} > /dev/null 2>&1
      if [ $? -eq 0 ]
      then
        inst "${repository} is cloned"
      else
        fail "failed to run ${command}"
      fi
    fi

  done

}

processUrl() {
  local urlNum=`length .url`
  info "Processing ${urlNum} url"
  local urlMaxIndex=`decrement ${urlNum}`
  for i in `seq 0 ${urlMaxIndex}`
  do
    local dlto=`cat package.json | jq -r ".url[${i}].dlto"`
    local url=`cat package.json | jq -r ".url[${i}].url"`
    local file=`echo ${url} | rev | cut -d '/' -f 1 | rev`
    dlto=`eval echo ${dlto}`

    if [ -f ${dlto}/${file} ]
    then
      skip "${file} already exists"
    else
      curl -o ${dlto}/${file} --create-dirs -s ${url}
      if [ $? -eq 0 ]
      then
        inst "${file} is installed to ${dlto}"
      else
        fail "${file} is failed to download from ${url}"
      fi
    fi
  done
}

info "apt update ..."
apt update > /dev/null 2>&1
checkRequirement
processHome
processApt
processSnap
processDpkg
processGit
processUrl

info "finished"
