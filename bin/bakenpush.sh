#!/usr/bin/env bash

# This command indicates if we have any local commits
# waiting to be pushed:
#
#     git log --oneline FETCH_HEAD..HEAD
#
# This one indicates any commits in remote waiting to
# be pulled:
#
#      git log --oneline HEAD..FETCH_HEAD


set -e

WORK_DIR=$1
CURR_DIR=$(pwd)
QUIET_PERIOD=$2

# Bastardized from https://stackoverflow.com/q/929368/42188
#
# Figured out how bash functions work here:
# https://ryanstutorials.net/bash-scripting-tutorial/bash-functions.php
function am_i_online() {
    local rc=0
    for interface in $(ls /sys/class/net/ | grep -v lo);
    do
    	if [[ $(cat /sys/class/net/$interface/carrier 2> /dev/null) = 1 ]]; then
    	    rc=1
    	fi
    done
    echo $rc
}


cd $WORK_DIR

$HOME/bin/flashbake -q . $QUIET_PERIOD

ONLINE=$(am_i_online)
if [ $ONLINE -eq 1 ]; then
    git fetch -q
    if [[ $(git log --oneline HEAD..FETCH_HEAD) ]]; then
	git rebase -q
    fi
    if [[ $(git log --oneline FETCH_HEAD..HEAD) ]]; then
	git push -q
    fi
else
    echo "No Internet connection, skipping sync."
fi
    
cd $CURR_DIR
