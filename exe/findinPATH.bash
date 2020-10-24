#!/usr/bin/env bash

set -e

readonly TMPFILE=$(mktemp /tmp/$(basename $0).XXXXXX)

echo ${PATH} | sed "s/^/find \"/g; s/:/\" -iname ${*} \&\n\nfind \"/g; s/$/\" -iname ${*} \&\n\n/g" | tee "${TMPFILE}"

read -p "Are you sure to execute? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
	# do dangerous stuff
	bash -xe "${TMPFILE}"
fi


rm "${TMPFILE}" &
