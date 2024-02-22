#!/bin/bash
# Wraps aursync command to mount an amazon s3 bucket which contains a repository
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

CLONE_URL=git@github.com:evilTachyMeter/archBoot.git
GIT_NAME=archBoot
GIT_BRANCH=main
REPO_PATH=arch-pkgs
REPO_NAME=evilTachyMeter

PACKAGES=${@:-pkg/*}
CHROOT="$PWD/root"

DATA_DIR="$HOME/.local/share/arch-repo"
mkdir -p "$DATA_DIR"
mkdir -p "$CHROOT"

[[ -d "$CHROOT/root" ]] || mkarchroot -C /etc/pacman.conf "$CHROOT/root" base base-devel

for package in $PACKAGES; do
    cd "$package"
    rm -f *.pkg.tar.xz
    makechrootpkg -cur $CHROOT
    cd -
done

alias gitc='git -C "${DATA_DIR}/repo"'

if [[ -d "$DATA_DIR/repo" ]]; then
	gitc reset --hard
	gitc clean -xffd
	gitc checkout "$GIT_BRANCH"
	gitc pull
else
	git clone -b "$GIT_BRANCH" "$CLONE_URL" "$DATA_DIR/repo"
fi

repo-add "${DATA_DIR}/repo/$REPO_NAME.db.tar.xz" "${PACKAGES[@]}/"*.pkg.tar.xz

if ! gitc status | grep "nothing to commit, working tree clean" &>/dev/null; then
	gitc add --all
	gitc commit -m "aur sync $@"
	gitc push
fi
