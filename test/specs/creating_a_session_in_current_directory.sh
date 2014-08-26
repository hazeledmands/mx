#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_session_in_current_directory() {
  run_mx horse_js

  expect_invocation_to_have_argument new-session -s horse_js
  expect_invocation_to_have_argument new-session -c "$PWD"
  expect_successful_run
}

tap_test 3 creating_a_session_in_current_directory
