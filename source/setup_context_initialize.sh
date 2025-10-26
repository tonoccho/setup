#!/usr/bin/env bash

function setup_context_initialize() {
  setup_context_clear
  build_system_context
}

# システムコンテキストを作ります。
function build_system_context() {
  setup_context_set_os_type $(uname -a | cut -d ' ' -f 1 | tr [A-Z] [a-z])
}