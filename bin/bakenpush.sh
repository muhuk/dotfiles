#!/usr/bin/env sh

set -e

WORK_DIR=$1
CURR_DIR=$(pwd)
QUIET_PERIOD=$2

cd $WORK_DIR

flashbake -q . $QUIET_PERIOD
git fetch -q
git rebase -q
git push -q

cd $CURR_DIR
