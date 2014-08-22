#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_new_session_from_a_relative_path() {
  cd $MOCKS_DIR
  run_mx red_sofa_project

  expect_invocation_to_have_argument new-session -c "$MOCKS_DIR/red_sofa_project"
  expect_successful_run
}

tap_test 2 creating_a_new_session_from_a_relative_path
