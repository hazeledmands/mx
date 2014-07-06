#!/usr/bin/env bash

set -o errexit
set -o nounset

npm version $1
git push --follow-tags
