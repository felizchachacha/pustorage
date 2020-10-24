#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

pushd ${MYDIR}

	../../exe/apt-urls.bash fromurl.list

	../../exe/aptilists.bash -y install custom.list basic.list withgui.list

popd
