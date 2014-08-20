#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

tap_diagnostic "Creating a new session from an absolute path"
tap_plan 3

run_mx "$MOCKS_DIR/red_sofa_project"

expect_invocation_to_have_argument new-session "-s red_sofa_project"
expect_invocation_to_have_argument new-session "-c $MOCKS_DIR/red_sofa_project"

expect_successful_run

tap_done
