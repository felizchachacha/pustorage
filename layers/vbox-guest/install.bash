#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})

pushd ${MYDIR}

apt install -y apt-transport-https

apt update

apt install -y $(cat vbox-guest.list)

popd

