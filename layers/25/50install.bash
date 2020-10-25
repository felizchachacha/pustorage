#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

pushd ${MYDIR}

	../../exe/apt-urls.bash fromurl.list

	../../exe/dpkg-loosen.bash plymouth-theme-ubuntustudio

	../../exe/aptilists.bash -y install custom.list basic.list withgui.list

	../../exe/dpkg-loosen.bash plymouth-theme-ubuntustudio

popd
