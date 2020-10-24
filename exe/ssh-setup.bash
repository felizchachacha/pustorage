#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))

pushd "${MYDIR}"/..
	cat ./lib/PUB >> ~/.ssh/authorized_keys
	chmod 0600 ~/.ssh/authorized_keys
	systemctl restart ssh &
popd
