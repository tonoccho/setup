#!/bin/bash
RC_OK=0
RC_SKIP=1
RC_NEED_REBOOT=2
RC_ERROR=9

function show_error_message() {
    local result_code=$1
    echo "finished with error,  ($1)"
}

function show_success_message() {
    echo "successfully finished"
}

function linfo() {
    local message=$1
    log "I" "$message"
}

function lwarn() {
    local message=$1
    log "W" "$message"
}

function lerror() {
    local message=$1
    log "E" "$message"
}

function log() {
    local time_stamp=$(date +"%Y-%m-%d %H:%M:%S")
    local log_level=$1
    local log_message=$2

    echo "$time_stamp $log_level $log_message"
}

function check_apt_pkg_installed() {
    local package_name=$1
    dpkg -s ${package_name} | grep "Status: install ok installed" | wc -l    
}