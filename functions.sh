#!/bin/bash
info() {
    local level=$1
    local message=$2
    log "[INFO]" $1 "$2"
}

error() {
    local level=$1
    local message=$2
    log "[ERROR]" $1 "$2"
}

log() {
    local prefix=$1
    local level=$2
    local message="$3"
    
    echo "$(date '+%Y/%m/%d %H:%M:%S.%N') $(printf '%*s\n' "$level") ${message}"
}