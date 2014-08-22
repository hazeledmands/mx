#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_new_session_from_an_absolute_path() {
  run_mx "$MOCKS_DIR/red_sofa_project"

  expect_invocation_to_have_argument new-session "-s red_sofa_project"
  expect_invocation_to_have_argument new-session "-c $MOCKS_DIR/red_sofa_project"

  expect_successful_run
}

tap_test 3 creating_a_new_session_from_an_absolute_path
