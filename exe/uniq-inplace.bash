#!/usr/bin/env bash

set -xe

readonly UNIQ="$(dirname $(realpath $0))/uniq.awk"

for f in ${*}; do
	tmpfile=$(mktemp /tmp/$(basename $0).XXXXXX)
	${UNIQ} ${f} > ${tmpfile}
	mv ${tmpfile} ${f}
done

pushd $(dirname ${f})
git add $(basename ${f})
popd
