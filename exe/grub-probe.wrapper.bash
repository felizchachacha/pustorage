#!/usr/bin/env bash

set -e

readonly ORIGPLACE=/usr/sbin/grub-probe.orig

# grub-probe /
# grub-probe: error: failed to get canonical path of `/cow'.

declare -a Params=()

function install() {
	set -x
	readonly THEPATH="/usr/sbin/grub-probe"
	readonly ME="${0}"
	diff -dq "${THEPATH}" "${0}" || cp --backup "${THEPATH}" "${ORIGPLACE}" && cp --backup "${ME}" "${THEPATH}"
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
			Params+="${1}"
                        shift # past param
		;;
	esac
done


"${ORIGPLACE}" ${Params[@]}

