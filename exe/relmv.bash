#!/usr/bin/env bash

set -xe

readonly SOURCE_RELPATH=${1}
readonly TARG_PATH=${2}
readonly NICE=${3:-"19"}

function process_relpath() {
	while read relpath; do
		local targpath="${*}/${relpath}"
		echo Rel path: "${relpath}" → Target path: "${targpath}"
		if [ -e "${targpath}" ]; then
			if [ "${relpath}" -ef "${targpath}" ]; then
				echo "${relpath}" IS the "${targpath}" 
			elif [ -d "${targpath}" ]; then
				pushd "${relpath}"
					nice -n ${NICE} find -maxdepth 1 | grep -v '^\.$' |  process_relpath "${targpath}/${relpath}"
				popd
				find "${relpath}" -empty -delete &
			else
				[[ "" = $(nice -n ${NICE} diff -dq "${relpath}" "${targpath}" | head -n1) ]] && rm -rvf "${relpath}"
			fi
		else
			nice -n ${NICE} mv -v "${relpath}" "${targpath}"
		fi
	done <&0
}

echo "${SOURCE_RELPATH}" | process_relpath "${TARG_PATH}"

