#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function opens_an_editor_with_a_new_default_session() {
  cd $BASE_DIR
  run_mx

  expect_invocation_to_have_argument send-keys -t mx:1
  expect_invocation_to_have_argument send-keys derp-edit C-m
  expect_successful_run
}

tap_test 3 opens_an_editor_with_a_new_default_session
