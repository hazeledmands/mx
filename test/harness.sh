set -o errexit
set -o nounset

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
TEST_DIR="$BASE_DIR/test"
STUBS_DIR=$TEST_DIR/stubs
MOCKS_DIR=$TEST_DIR/mocks

MX=$BASE_DIR/bin/mx

PATH=$STUBS_DIR:$PATH
PROJECTS=$MOCKS_DIR/projects

TAP_HEADER=false
TEST_PLANNED=-1
TEST_NUMBER=1

TEST_FAILURES=0

tap_header() {
  if $TAP_HEADER; then
    return 0
  fi
  echo "TAP version 13"
  TAP_HEADER=true
}

tap_diagnostic() {
  tap_header

  echo "# $1"
}

tap_plan() {
  tap_header

  if [[ $TEST_PLANNED -ge 0 ]]; then
    tap_harness_err "not ok Tried to plan twice"
  fi

  TEST_PLANNED=$1

  echo "1..$TEST_PLANNED"
}

tap_ran_test() {
  if [[ $TEST_NUMBER -gt $TEST_PLANNED ]]; then
    tap_harness_err "More tests ran than were planned"
  fi
  TEST_NUMBER=$((TEST_NUMBER+1))
}

tap_success() {
  tap_header
  echo "ok $TEST_NUMBER $1"
  tap_ran_test
}

tap_failure() {
  TEST_FAILURES=$((TEST_FAILURES+1))
  tap_header
  echo "not ok $TEST_NUMBER $1"
  tap_ran_test
}

tap_harness_err() {
  echo "not ok $1"
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

run_mx() {
  IFS=$'\n'
  if INVOCATIONS=($($MX "$@")); then
    LAST_RUN=$?
  else
    LAST_RUN=$?
  fi
  unset IFS

  for i in "${INVOCATIONS[@]}"; do
    echo $i
  done
}

expect_successful_run() {
  if [[ $LAST_RUN -eq 0 ]]; then
    tap_success "mx ran successfully"
  else
    tap_failure "mx failed with status $LAST_RUN"
  fi
}

expect_invocation_to_have_argument() {
  local subcmd=$1
  local arg=$2
  local invocation

  for invocation in "${INVOCATIONS[@]}"; do
    if [[ $invocation =~ $subcmd ]]; then
      if [[ $invocation =~ $arg ]]; then
        tap_success "sub-command '$subcmd' had argument '$arg'"
      else
        tap_failure "sub-command '$subcmd' did not have argument '$arg'"
      fi
      return 0
    fi
  done
}

expect_no_invocation() {
  local subcmd=$1

  for invocation in "${INVOCATIONS[@]}"; do
    if [[ $invocation =~ $subcmd ]]; then
      tap_failure "sub-command '$subcmd' was invoked"
      return 0
    fi
    tap_success "sub-command '$subcmd' was not invoked"
  done
}
