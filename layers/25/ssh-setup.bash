#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))
readonly DEFUSER="$(cat ${MYDIR}/../../lib/DEFUSER)"


pushd ${MYDIR}

	cp -rv --backup ssh-setup/* /

popd
pushd "${MYDIR}"/../..
	exe/ensure_path.bash ~root/.ssh ~"${DEFUSER}"/.ssh
	chmod 0700 ~root/.ssh ~"${DEFUSER}"/.ssh
	cat ./lib/PUB | tee ~/.ssh/authorized_keys > ~"${DEFUSER}"/.ssh/authorized_keys
	chmod 0600 ~/.ssh/authorized_keys ~"${DEFUSER}"/.ssh/authorized_keys
	chown -R "${DEFUSER}":"${DEFUSER}" ~"${DEFUSER}"/.ssh

	systemctl restart ssh &
popd
