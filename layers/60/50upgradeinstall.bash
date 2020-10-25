#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

pushd ${MYDIR}

	../../exe/apt-urls.bash	fromurl.list

	../../exe/aptilists.bash full-upgrade custom.list basic.list minimal.list withgui.list video.list

popd
