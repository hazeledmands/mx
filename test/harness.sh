#!/usr/bin/env bash

set -o errexit
set -o nounset

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
TEST_DIR="$BASE_DIR/test"
STUBS_DIR=$TEST_DIR/stubs
MOCKS_DIR=$TEST_DIR/mocks

MX=$BASE_DIR/bin/mx

export PATH=$STUBS_DIR:$PATH
export TMUX='foo' # pretend to be in a tmux session even if we aren't
export PROJECTS=$MOCKS_DIR/projects
export EDITOR='derp-edit'

source $TEST_DIR/tap.sh

run_mx() {
  local all_mx_output=$($MX "$@" 2>~errfile)
  LAST_RUN=$?

  MX_STDOUT=()
  MX_STDERR=$(<~errfile)
  rm ~errfile
  INVOCATIONS=()

  while read mx_line; do
    if [[ "$mx_line" =~ ':::STUB_TMUX:::' ]]; then
      INVOCATIONS[${#INVOCATIONS[@]}]="${mx_line:15}"
    else
      MX_STDOUT[${#MX_STDOUT[@]}]=$mx_line
    fi
  done <<< "$all_mx_output"
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
  shift

  local unquoted_args=$@
  local quoted_args=()
  for arg; do
    quoted_args+=("'$arg'")
  done
  quoted_args="${quoted_args[@]}"

  invocations_with_subcommands "$subcmd"
  if [[ "${#SUB_INVOCATIONS[@]}" -eq 0 ]]; then
    tap_failure "sub-command '$subcmd' was never invoked"
    return
  fi

  for invocation in "${SUB_INVOCATIONS[@]}"; do
    if [[ "$invocation" =~ "$quoted_args" ]]; then
      tap_success "sub-command '$subcmd' had argument(s) '$unquoted_args'"
    else
      tap_failure "sub-command '$subcmd' did not have argument(s) '$unquoted_args'"
    fi
    return
  done
}

expect_no_invocation() {
  local subcmd=$1

  invocations_with_subcommands "$subcmd"
  if [[ "${#SUB_INVOCATIONS[@]}" -gt 0 ]]; then
    tap_failure "sub-command '$subcmd' was invoked"
    return 0
  fi

  tap_success "sub-command '$subcmd' was not invoked"
}

expect_invocation_count() {
  if [[ ${#INVOCATIONS[@]} -eq $1 ]]; then
    tap_success "tmux was invoked $1 times"
  else
    tap_failure "tmux was invoked ${#INVOCATIONS[@]} times, expected $1"
  fi
}

expect_output() {
  local expected_output=$1

  if [[ ${#MX_STDOUT[@]} -gt 0 ]]; then
    for output in "${MX_STDOUT[@]}"; do
      if [[ $output =~ $expected_output ]]; then
        tap_success "outputted $expected_output"
        return 0
      fi
    done
  fi

  tap_failure "did not output $expected_output"
  return -255
}

expect_no_stderr() {
  if [[ -n $MX_STDERR ]]; then
    tap_failure "expected no output to stderr; got \"$MX_STDERR\""
  else
    tap_success "no output to stderr"
  fi
}

invocations_with_subcommands() {
  local subcmd=$1
  SUB_INVOCATIONS=()

  for invocation in "${INVOCATIONS[@]}"; do
    if [[ "$invocation" =~ "$subcmd" ]]; then
      SUB_INVOCATIONS[${#SUB_INVOCATIONS[@]}]="$invocation"
    fi
  done
}
