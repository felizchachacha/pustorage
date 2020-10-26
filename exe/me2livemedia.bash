#!/usr/bin/env bash

set -xe

readonly MYDIR="$(dirname $(realpath ${0}))"
readonly LIVEPARTDEV=$("${MYDIR}"/get-livemedia-dev.bash)
readonly MYDRIVE=$(df -P "${MYDIR}" | awk 'END {print $1}')
readonly DEF_MOUNTP="/media/live"

pushd ${MYDIR}/..

	if [[ "${LIVEPARTDEV}" == "${MYDRIVE}" ]]; then
		echo "${MYDIR} we are on live media ${LIVEPARTDEV}"
	elif exe/get-ro-fss.sh | grep "${LIVEPARTDEV}"; then
		echo "Live media is read-only"
		exit 0
	else
		mountpoint=$(mount | awk "\$1==\"${LIVEPARTDEV}\" {print \$3}")
		if [[ "${mountpoint}" == '' ]]; then
			mountpoint="${DEF_MOUNTP}"
			if mount | grep -- "${DEF_MOUNTP}"; then
				"${DEF_MOUNTP}" is already mounted
			else
				exe/ensure-path.bash "${DEF_MOUNTP}"
				mount "${LIVEPARTDEV}" "${mountpoint}" -o noatime,rw
			fi
		fi

		readonly DIRNAME=$(basename `git rev-parse --show-toplevel`)
		readonly TARGET="${mountpoint}/${DIRNAME}"

		rsync -svauchHPxXlit --progress . "${TARGET}"/
		
		sync &
	fi

popd
