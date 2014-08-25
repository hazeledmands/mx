#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function creating_a_session_from_the_projects_directory() {
  run_mx rice_crispies

  expect_invocation_to_have_argument new-session "-s rice_crispies"
  expect_invocation_to_have_argument new-session "-c $PROJECTS/rice_crispies"
  expect_successful_run
}

tap_test 3 creating_a_session_from_the_projects_directory
