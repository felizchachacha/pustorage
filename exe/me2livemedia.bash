#!/usr/bin/env bash

set -xe

readonly MYDIR="$(dirname $(realpath ${0}))"
#readonly LIVEWRITEABLE=$("${MYDIR}"/get-livemedia-dev.bash)
readonly LIVEWRITEABLE="/dev/disk/by-label/Ubuntu-Studio\\x2020_10\\x20amd64"
readonly MYDRIVE=$(df -P "${MYDIR}" | awk 'END {print $1}')
readonly DEF_MOUNTP="/media/live"

pushd ${MYDIR}/..

	if [[ "${LIVEWRITEABLE}" == "${MYDRIVE}" ]]; then
		echo "${MYDIR} we are on live media ${LIVEWRITEABLE}"
	else
		mountpoint=$(mount | awk "\$1==\"${LIVEWRITEABLE}\" {print \$3}")
		if [[ "${mountpoint}" == '' ]]; then
			mountpoint="${DEF_MOUNTP}"
			[ -d "${mountpoint}" ] || mkdir -p "${mountpoint}"
			mount "${LIVEWRITEABLE}" "${mountpoint}" -o noatime,rw
		fi

		readonly DIRNAME=$(basename `git rev-parse --show-toplevel`)
		readonly TARGET="${mountpoint}/${DIRNAME}"

		rsync -svauchHPxXlit --progress . "${TARGET}"/
		
		sync &
	fi


popd
