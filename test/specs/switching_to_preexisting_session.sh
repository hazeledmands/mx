#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function switching_to_preexisting_session() {
  run_mx taco_tuesday

  expect_invocation_to_have_argument switch-client -t taco_tuesday
  expect_no_invocation new-session
  expect_successful_run
}

tap_test 3 switching_to_preexisting_session
