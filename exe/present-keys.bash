#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))
readonly URLRE="(https?|ftp|file)://.*"
readonly KEYSFNAME="keys.bash.dict"

source "${KEYSFNAME}"
echo ${Keys}

pushd ${MYDIR}/../lib/keys

	for keyname in "${!Keys[@]}"; do
		v=${Keys["${keyname}"]}
		# if such key file is imported successfully locally
		apt-key add "${keyname}" || if [[ "${v}" =~ ${URLRE} ]]; then
				wget -cO "${keyname}" "${v}"
				apt-key add "${keyname}"
			else
				apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "${v}"
			fi
	done

popd
