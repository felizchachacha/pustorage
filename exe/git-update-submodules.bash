#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

pushd ${MYDIR}

which git || apt -y install git

git submodule update --init
git submodule foreach git fetch
git submodule foreach git branch --set-upstream-to=origin master
git submodule foreach git checkout master
git submodule foreach git pull origin master
git pull --recurse-submodules
git submodule update --recursive

popd
