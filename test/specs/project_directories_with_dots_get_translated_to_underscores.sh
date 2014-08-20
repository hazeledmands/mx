#!/usr/bin/env bash
source "$( dirname "${BASH_SOURCE[0]}" )/../harness.sh"

tap_diagnostic "Project directories with dots get translated to underscores"
tap_plan 3

run_mx name.with.dots

expect_invocation_to_have_argument new-session "-s name_with_dots"
expect_invocation_to_have_argument new-session "-c $PROJECTS/name.with.dots"
expect_successful_run

tap_done
