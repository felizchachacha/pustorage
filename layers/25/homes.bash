#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))
readonly DEFUSER="$(cat ${MYDIR}/../../lib/DEFUSER)"

pushd "${MYDIR}"/../..
	rsync -svahHP --backup --progress lib/home/ /etc/skel
	rsync -svahHP --backup --progress lib/home/ /root
	rsync -svahHP --backup --progress lib/home/ /home/"${DEFUSER}"
	#exe/ensure-path.bash /root/.ssh /home/"${DEFUSER}"/.ssh
	#chmod 0700 /etc/skel/.ssh /root/.ssh /home/"${DEFUSER}"/.ssh
	#cat ./lib/PUB | tee /root/.ssh/authorized_keys > /home/"${DEFUSER}"/.ssh/authorized_keys
	#chmod 0600 /etc/skel/ssh/authorized_keys /root/.ssh/authorized_keys /home/"${DEFUSER}"/.ssh/authorized_keys
	chown -R "${DEFUSER}":"${DEFUSER}" /home/"${DEFUSER}"
	systemctl restart ssh &
popd
