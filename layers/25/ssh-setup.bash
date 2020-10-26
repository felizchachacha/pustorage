#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

pushd ${MYDIR}
	cp -rv --backup ssh-setup/* /
popd

systemctl restart ssh &
