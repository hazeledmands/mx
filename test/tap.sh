#!/usr/bin/env bash

set -o errexit
set -o nounset

# this file should be sourced only once
[[ ${REQUIRED_TAP:-1} -eq 0 ]] && return
REQUIRED_TAP=0

TAP_HEADER=false

TAP_PREREGISTER_COUNT=1
TAP_REGISTER_COUNT=0
TAP_SPEC_FUNCTIONS=()

TEST_PLANNED=0
TEST_NUMBER=1
TEST_FAILURES=0

tap_preregister() {
  TAP_PREREGISTER_COUNT=$1
}

tap_test() {
  tap_plan $1
  tap_register $2
}

tap_plan() {
  TEST_PLANNED=$(($TEST_PLANNED+$1))
}

tap_register() {
  TAP_REGISTER_COUNT=$(($TAP_REGISTER_COUNT+1))
  TAP_SPEC_FUNCTIONS+=($1)
  if [[ $TAP_REGISTER_COUNT -ge $TAP_PREREGISTER_COUNT ]]; then
    tap_run
  fi
}

tap_run() {
  for spec in "${TAP_SPEC_FUNCTIONS[@]}"; do
    tap_diagnostic $spec
    eval $spec
  done
  TAP_SPEC_FUNCTIONS=()
  TAP_REGISTER_COUNT=0
  tap_done
}

tap_header() {
  if $TAP_HEADER; then
    return 0
  fi
  echo "TAP version 13"
  echo "# Using bash $BASH_VERSION"
  echo "1..$TEST_PLANNED"
  TAP_HEADER=true
}

tap_diagnostic() {
  tap_header

  echo "# $1"
}

tap_ran_test() {
  if [[ $TEST_NUMBER -gt $TEST_PLANNED ]]; then
    tap_harness_err "More tests ran than were planned"
  fi
  TEST_NUMBER=$((TEST_NUMBER+1))
}

tap_success() {
  tap_header
  echo "ok $TEST_NUMBER - $1"
  tap_ran_test
}

tap_failure() {
  TEST_FAILURES=$((TEST_FAILURES+1))
  tap_header
  echo "not ok $TEST_NUMBER - $1"
  tap_ran_test
}

tap_harness_err() {
  echo "not ok - $1"
  exit -1
}

tap_done() {
  TEST_NUMBER=$((TEST_NUMBER-1))
  if [[ $TEST_NUMBER -lt $TEST_PLANNED ]]; then
    tap_harness_err "Planned for $TEST_PLANNED tests; only $TEST_NUMBER ran."
  fi

  if [[ $TEST_FAILURES -gt 0 ]]; then
    exit -1
  fi
}
