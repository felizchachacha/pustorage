#!/usr/bin/env bash

set -xe

readonly DWNLD_LINK="https://repo1.maven.org/maven2/com/madgag/bfg/1.13.0/bfg-1.13.0.jar"
readonly MYDIR="$(dirname $(realpath ${0}))"
readonly TARGETJAR="/usr/local/lib/bfg.jar"
readonly DWNLD_D="$(dirname ${TARGETJAR})"

pushd ${MYDIR}
	# java present
	which java || aptitude -y install default-jre-headless
	cp -rv --backup bfg/* /
	../../exe/ensure-path.bash "${DWNLD_D}"
popd

pushd "${DWNLD_D}"
	readonly LOGTMPFILE=$(mktemp /tmp/$(basename "${0}").XXXXXX)
		# fetch bfg.jar
		wget -c "${DWNLD_LINK}" 2>&1 | tee "${LOGTMPFILE}"
		readonly DOWNLOADED_FNAME=$(tail -2 "${LOGTMPFILE}" | awk -vFS='‘|’' '/saved/ {print $2}')
		mv -v "${DOWNLOADED_FNAME}" "${TARGETJAR}" 
	rm "${LOGTMPFILE}" &
popd
