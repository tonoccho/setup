#!/usr/bin/env bash

declare -A setup_return=()

readonly setup_return_rc_key='setup_return_rc_key'
readonly setup_return_message_key='setup_return_message_key'
readonly setup_return_detailed_message_key='setup_return_detailed_message_key'

function setup_return_set_rc() {
    setup_return["${setup_return_rc_key}"]=$1
}

function setup_return_get_rc() {
    echo ${setup_return["${setup_return_rc_key}"]}
}

function setup_return_set_message() {
    setup_return["${setup_return_message_key}"]=$1
}

function setup_return_get_message() {
    echo ${setup_return["${setup_return_message_key}"]}
}

function setup_return_set_detailed_message() {
    setup_return["${setup_return_detailed_message_key}"]=$1
}

function setup_return_get_detailed_message() {
    echo ${setup_return["${setup_return_detailed_message_key}"]}
}

function setup_return_clear() {
    for key in "${!setup_return[@]}"; do
        unset setup_return[${key}]
    done
}
