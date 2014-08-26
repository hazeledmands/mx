#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function project_directories_with_dots_get_translated_to_underscores() {
  run_mx name.with.dots

  expect_invocation_to_have_argument new-session -s name_with_dots
  expect_invocation_to_have_argument new-session -c "$PROJECTS/name.with.dots"
  expect_successful_run
}

tap_test 3 project_directories_with_dots_get_translated_to_underscores
