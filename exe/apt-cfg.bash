#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

cp -rv --backup apt-cfg/* /

apt update

pushd ${MYDIR}
	apt --fix-broken install

	apt install -y $(cat ../lib/apt.list)

	apt-file update &

popd
