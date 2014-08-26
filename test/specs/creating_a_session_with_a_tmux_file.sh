#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_session_with_a_tmux_file() {
  run_mx good_conf

  expect_invocation_to_have_argument new-session -s wahoo
  expect_invocation_to_have_argument new-session -n first
  expect_invocation_to_have_argument new-session -c "$PROJECTS/good_conf"

  expect_invocation_to_have_argument new-window -n second

  expect_invocation_to_have_argument "'send-keys' '-t' 'wahoo:1'" 'echo Wahoo!' C-m
  expect_invocation_to_have_argument "'send-keys' '-t' 'wahoo:2'" 'echo Heya.' C-m

  expect_successful_run
}

tap_test 7 creating_a_session_with_a_tmux_file
