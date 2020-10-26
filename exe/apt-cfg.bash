#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

cp -rv --backup apt-cfg/* /

apt update

pushd ${MYDIR}
	apt --fix-broken install -y

	apt install -y $(cat ../lib/apt.list)

	apt-file update 2>&1 >> /tmp/apt-file.log &

popd
