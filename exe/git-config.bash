#!/usr/bin/env bash

readonly MYDIR=$(dirname $(realpath ${0}))

pushd "${MYDIR}"/..
	git config --global credentials.helper store
	git config --global user.email "you@example.com"
	git config --global user.name "Your Name"
	[[ $(git remote -v) == '' ]] && git remote add origin https://github.com/felizchachacha/pustorage.git 
	git branch --set-upstream-to=origin/master
	git fetch
	git pull
popd
