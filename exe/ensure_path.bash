#!/usr/bin/env bash

set -xe

function process_path() {
	while read path; do
		[ -d "${path}" ] || [ -L "${path}" ] || mkdir "${path}"
	done <&0
}

if [[ "${*}" == '' ]]; then
	process_path
else
	echo ${*} | process_path
fi


