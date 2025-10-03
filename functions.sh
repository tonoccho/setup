#!/bin/bash
RC_OK=0
RC_NEED_REBOOT=3
RC_ERROR=9

function show_error_message() {
    local result_code=$1
    echo "finished with error,  ($1)"
}

function show_success_message() {
    echo "successfully finished"
}