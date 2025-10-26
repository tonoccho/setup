#!/usr/bin/env bash

declare -A setup_args=()

function setup_args_set_value() {
    setup_args["${1}"]=$2
}

function setup_args_get_value() {
    echo ${setup_args[${1}]}
}

function setup_args_clear() {
    for key in "${!setup_args[@]}"; do
        unset setup_args[${key}]
    done
}