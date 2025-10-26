#!/usr/bin/env bash
declare -A setup_session=()

function setup_session_set_value() {
    setup_session["${1}"]=$2
}

function setup_session_get_value() {
    echo ${setup_session["${1}"]}
}

function setup_session_clear() {
    for key in "${!setup_session[@]}"; do
        unset setup_session[${key}]
    done
}
