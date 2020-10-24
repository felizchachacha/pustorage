#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})

pushd ${MYDIR}

	packages/aptilists.bash full-upgrade extra.list basic.list withgui.list minimal.list custom.list

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

popd
