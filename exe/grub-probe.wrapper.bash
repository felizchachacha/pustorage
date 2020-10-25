#!/usr/bin/env bash

set -ex

readonly ORIGPLACE=/usr/sbin/grub-probe.orig

# grub-probe /
# grub-probe: error: failed to get canonical path of `/cow'.

declare -a Params=()

function install() {
	set -x
	readonly THEPATH="/usr/sbin/grub-probe"
	readonly ME="${0}"
	diff -dq "${ME}" "${THEPATH}" || if (( $? == 1)); then
		[ -e "${ORIGPLACE}" ] || cp --backup "${THEPATH}" "${ORIGPLACE}"
		ln --backup "${ME}" "${THEPATH}" || cp --backup "${ME}" "${THEPATH}"
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
			Params+="${1}"
                        shift # past param
		;;
	esac
done


"${ORIGPLACE}" ${Params[@]}

