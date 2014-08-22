#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_session_with_a_tmux_directory() {
  run_mx directory_conf

  expect_successful_run
}

tap_test 1 creating_a_session_with_a_tmux_directory
