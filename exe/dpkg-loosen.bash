#!/usr/bin/env bash

set -ex

readonly D="/var/lib/dpkg/info"

for package in ${@}; do
	for f in "${D}"/"${package}".*; do
		if [[ $(file "${f}") =~ "script, ASCII text executable" ]]; then
			sed -i 's/^set -e$//g' "${D}"/"${package}".*
			echo "exit 0" >> "${f}"
		fi
	done
done
