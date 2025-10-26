#!/usr/bin/env bash
declare -A setup_context=()

readonly setup_context_key_os_type="setup_context_key_os_type"
function setup_context_set_os_type() {
    setup_context_set_value "${setup_context_key_os_type}" "$1"
}

function setup_context_get_os_type() {
    setup_context_get_value "${setup_context_key_os_type}"
}

function setup_context_is_os_type_linux() {
    local os_type=$(setup_context_get_os_type)
    if [ ${os_type} = "linux" ]
    then
      echo "yes"
    else
      echo "no"
    fi
}

function setup_context_set_value() {
    setup_context["${1}"]=$2
}

function setup_context_get_value() {
    echo ${setup_context["${1}"]}
}

function setup_context_clear() {
    for key in "${!setup_context[@]}"; do
        unset setup_context[${key}]
    done
}
