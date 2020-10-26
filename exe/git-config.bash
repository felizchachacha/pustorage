#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

pushd "${MYDIR}"/..
	git config --global credential.helper store
	git config --global user.email "you@example.com"
	git config --global user.name "Your Name"
	[[ $(git remote -v) == '' ]] && git remote add origin https://github.com/felizchachacha/pustorage.git 
	git branch --set-upstream-to=origin/master || git branch --set-upstream-to=origin/main
	git fetch
	git config pull.rebase false
	git pull
	git config credential.helper store
popd
