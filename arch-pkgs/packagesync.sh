#!/bin/bash -x
# Wraps aursync command that stores built packages inside a git repo
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
shopt -s expand_aliases

CLONE_URL=git@github.com:evilTachyMeter/archBoot.git
GIT_BRANCH=main
REPO_PATH=arch-pkgs
REPO_NAME=evilTachyMeter

DATA_DIR="$HOME/.local/share/arch-repo"
mkdir -p "$DATA_DIR"
alias gitc='git -C "${DATA_DIR}/repo"'

if [[ -d "$DATA_DIR/repo" ]]; then
    # DATA_DIR exists, reset and pull any changes
    gitc reset --hard
    gitc clean -xffd
    gitc checkout "$GIT_BRANCH"
    gitc pull
else
    # DATA_DIR does not exist, so clone it
    git clone -b "$GIT_BRANCH" "$CLONE_URL" "$DATA_DIR/repo"
fi

mkdir -p "$DATA_DIR/repo/$REPO_PATH"

aur sync --repo "$REPO_NAME" --root "$DATA_DIR/repo/$REPO_PATH" "$@"

if ! gitc status | grep "nothing to commit, working tree clean" &>/dev/null; then
    gitc add --all
    gitc commit -m "aur sync $@"
    gitc push
fi

