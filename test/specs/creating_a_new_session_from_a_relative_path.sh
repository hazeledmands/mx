#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

tap_diagnostic "Creating a new session from a relative path"
tap_plan 2

cd $MOCKS_DIR
run_mx red_sofa_project

expect_invocation_to_have_argument new-session "-c $MOCKS_DIR/red_sofa_project"
expect_successful_run

tap_done
