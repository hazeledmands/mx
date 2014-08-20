#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

tap_diagnostic "Creating a session from the \$PROJECTS directory"
tap_plan 3

run_mx rice_crispies

expect_invocation_to_have_argument new-session "-s rice_crispies"
expect_invocation_to_have_argument new-session "-c $PROJECTS/rice_crispies"
expect_successful_run

tap_done
