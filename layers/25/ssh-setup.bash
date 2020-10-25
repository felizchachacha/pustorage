#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))
readonly DEFUSER="$(cat ${MYDIR}/../../lib/DEFUSER)"

pushd ${MYDIR}
	cp -rv --backup ssh-setup/* /
popd
pushd "${MYDIR}"/../..
	exe/ensure-path.bash /root/.ssh /home/"${DEFUSER}"/.ssh
	chmod 0700 /root/.ssh /home/"${DEFUSER}"/.ssh
	cat ./lib/PUB | tee /root/.ssh/authorized_keys > /home/"${DEFUSER}"/.ssh/authorized_keys
	chmod 0600 /root/.ssh/authorized_keys /home/"${DEFUSER}"/.ssh/authorized_keys
	chown -R "${DEFUSER}":"${DEFUSER}" /home/"${DEFUSER}"/.ssh
	systemctl restart ssh &
popd
