#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

tap_diagnostic "Creating a session in current directory"
tap_plan 3

run_mx horse_js

expect_invocation_to_have_argument new-session "-s horse_js"
expect_invocation_to_have_argument new-session "-c $PWD"
expect_successful_run

tap_done
