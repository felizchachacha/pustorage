#!/usr/bin/env bash

set -e

if [ -L /dev/disk/by-label/Ubuntu-Studio\\x2020.10\\x20amd64 ]; then
	realpath /dev/disk/by-label/Ubuntu-Studio\\x2020.10\\x20amd64
elseif [ -L /dev/disk/by-label/Ubuntu-Studio\\x2020_10\\x20amd64 ]; t
hen
	realpath /dev/disk/by-label/Ubuntu-Studio\\x2020_10\\x20amd64
else
	readonly RWPARTNO=1
	readonly LIVEDISK=$(mount | awk -vFS='[0-9]|[[:space:]]' '$4=="/cdrom" {print $1}')
	echo "${LIVEDISK}${RWPARTNO}"
fi
