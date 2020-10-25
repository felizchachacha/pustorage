#!/usr/bin/env bash

set -e

readonly ORIGPLACE=/usr/sbin/grub-probe.orig

# grub-probe /
# grub-probe: error: failed to get canonical path of `/cow'.

function install() {
	set -x
	readonly THEPATH="/usr/sbin/grub-probe"
	readonly ME="${0}"
	diff -dq "${THEPATH}" "${0}" || cp --backup "${THEPATH}" "${ORIGPLACE}" && cp --backup "${ME}" "${THEPATH}"
}

if [[ "${1}" == "/" ]]; then
	echo "zfs"
elif [[ "${1}" == "install" ]]; then
	install
else
	"${ORIGPLACE}" ${*}
fi
