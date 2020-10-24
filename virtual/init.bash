#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})
readonly RCD=${MYDIR}/..
readonly GAMP=/media/guestadd
readonly GADEV=$(find /dev/disk/by-label -iname 'vbox*ga*' | head -1)

apt update

apt install -y gcc make perl

if [[ ${GADEV} == '' ]]; then
	${MYDIR}/../packages/*apt-cfg.bash
	apt install -y $(cat ${MYDIR}/../packages/vbox-guest.list)
else
	mkdir ${GAMP} && mount ${GADEV} ${GAMP}
	find ${GAMP} -type f '(' -iname '*.sh' -or -iname '*.bash' -or -iname '*.run' ')' -exec '{}' \;

fi

#find ${RCD} -maxdepth 1 -regex '.+/[0-9]+.bash' -execdir '{}' \+


