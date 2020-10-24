#/usr/bin/env bash

set -xe

for f in ${*}; do
	tmpfile=$(mktemp /tmp/$(basename $0).XXXXXX)
	awk -vOFS='\n' 'NF' ${f} | sort -u > ${tmpfile}
	mv ${tmpfile} ${f}
done

pushd $(dirname ${f})
git add $(basename ${f})
popd


