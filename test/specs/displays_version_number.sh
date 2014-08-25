#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

function displays_version_number() {
  run_mx --version

  expect_invocation_count 0
  expect_output "mx version"
  expect_successful_run
}

tap_test 3 displays_version_number
