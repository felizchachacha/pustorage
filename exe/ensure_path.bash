#!/usr/bin/env bash

set -xe

if [[ "${*}" == '' ]]; then
	while read path; do
		[ -d "${path}" ] || [ -L "${path}" ] || mkdir "${path}"
	done <&0
else
	for path in ${*}; do 
		[ -d "${path}" ] || [ -L "${path}" ] || mkdir "${path}"
	done
fi
