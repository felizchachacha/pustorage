#!/usr/bin/env bash

set -ex

readonly TARGDIR="/usr/sbin"
readonly ORIGPLACE="${TARGDIR}"/grub-probe.orig
readonly COWEXP=".*: error: failed to get canonical path of \`/cow'."
readonly THEPATH="${TARGDIR}"/"grub-probe"
readonly ME="${0}"
readonly MYDIR="$(dirname $(realpath ${ME}))"
readonly Dependencies=(get-livemedia-dev.bash  get-ro-fss.sh)

declare -a Params=()

function install() {
	set -x
	diff -dq "${ME}" "${THEPATH}" || if (( $? == 1)); then
		if [ -e "${ORIGPLACE}" ]; then
			file "${THEPATH}" | grep ELF && cp --backup "${THEPATH}" "${ORIGPLACE}" 
		else
			cp --backup "${THEPATH}" "${ORIGPLACE}"
		fi
		ln --backup "${ME}" "${THEPATH}" || cp --backup "${ME}" "${THEPATH}"
		for d in ${Dependencies[@]}; do
			ln --backup "${MYDIR}"/${d} "${TARGDIR}"/ || cp --backup "${ME}" "${TARGDIR}"/
		done
	fi
}

while [ ${#} -gt 0 ]; do
	case ${1} in
		'install')
			install
			exit 0
		;;
		'/')
			echo "zfs"
			exit 0
		;;
		*)
			Params+=("${1}")
                        shift # past param
		;;
	esac
done

readonly ORIGOUT=$("${ORIGPLACE}" ${Params[@]} 2>&1 )

if [[ "${ORIGOUT}" =~ ${COWEXP} ]]; then
	"${MYDIR}"/get-livemedia-dev.bash
else
	"${ORIGPLACE}" ${Params[@]}
fi


