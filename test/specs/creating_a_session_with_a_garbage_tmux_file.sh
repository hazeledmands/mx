#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_session_with_a_garbage_tmux_file() {
  run_mx garbage_tmux_file

  expect_successful_run
}

tap_test 1 creating_a_session_with_a_garbage_tmux_file
