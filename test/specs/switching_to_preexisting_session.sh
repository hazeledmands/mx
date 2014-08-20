#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

tap_diagnostic "Switching to preexisting session"
tap_plan 3

run_mx taco_tuesday

expect_invocation_to_have_argument switch-client "-t taco_tuesday"
expect_no_invocation new-session
expect_successful_run

tap_done
