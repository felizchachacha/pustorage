#!/usr/bin/env bash

set -e

readonly MYDIR=$(dirname ${0})
readonly ZMNTR="/mnt/z"

pushd "${MYDIR}"

	declare -A MountedFss="( $(mount | awk '{print "["$3"]="$5}') )"

	for d in $(cat ../lib/rbinds.list); do
		echo d=${d}
		echo fs=${MountedFss[${d}]}
		echo tdir="${ZMNTR}${d}/.."
		if [[ "${MountedFss[${d}]}" == 'zfs' ]]; then
			echo "${d} is zfs-mounted already"
		else
			tdir="${ZMNTR}${d}/.."
			[ -e "${tdir}" ] || mkdir -p "${tdir}"
			rsync -svahcHPxXlit --progress --remove-source-files "${d}" "${tdir}"/
			find "${d}" -mindepth 1 -empty -delete
			mount -v --rbind "${ZMNTR}${d}" "${d}"
		fi
	done

popd
