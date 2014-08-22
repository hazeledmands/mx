#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_session_with_an_empty_tmux_file() {
  run_mx empty_tmux_file

  expect_invocation_to_have_argument new-session "-s empty_tmux_file"
  expect_invocation_to_have_argument new-session "-n shell"
  expect_no_invocation new-window
  expect_no_invocation send-keys

  expect_successful_run
}

tap_test 5 creating_a_session_with_an_empty_tmux_file
