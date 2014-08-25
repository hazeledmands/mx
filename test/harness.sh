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
  local all_mx_output=$($MX "$@")
  LAST_RUN=$?

  MX_OUTPUT=()
  INVOCATIONS=()

  while read mx_line; do
    if [[ $mx_line =~ ':::STUB_TMUX:::' ]]; then
      INVOCATIONS[${#INVOCATIONS[@]}]="${mx_line:15}"
    else
      MX_OUTPUT[${#MX_OUTPUT[@]}]=$mx_line
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
  local args=("$@")

  unset args[0]
  args=("${args[@]}")

  local arg=''
  local pretty_arg=''
  local arg_segment

  for arg_segment in ${args[@]}; do
    if [[ "${#arg}" -ne 0 ]]; then
      arg+=' '
      pretty_arg+=' '
    fi
    arg+="'$arg_segment'"
    pretty_arg+="$arg_segment"
  done

  local invocation

  for invocation in "${INVOCATIONS[@]}"; do
    if [[ $invocation =~ $subcmd ]]; then
      if [[ $invocation =~ $arg ]]; then
        tap_success "sub-command '$subcmd' had argument(s) '$pretty_arg'"
      else
        tap_failure "sub-command '$subcmd' did not have argument(s) '$pretty_arg'"
      fi
      return 0
    fi
  done
  tap_failure "sub-command '$subcmd' was never invoked"
}

expect_no_invocation() {
  local subcmd=$1

  for invocation in "${INVOCATIONS[@]}"; do
    if [[ $invocation =~ $subcmd ]]; then
      tap_failure "sub-command '$subcmd' was invoked"
      return 0
    fi
  done
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

  if [[ ${#MX_OUTPUT[@]} -gt 0 ]]; then
    for output in "${MX_OUTPUT[@]}"; do
      if [[ $output =~ $expected_output ]]; then
        tap_success "outputted $expected_output"
        return 0
      fi
    done
  fi

  tap_failure "did not output $expected_output"
  return -255
}
