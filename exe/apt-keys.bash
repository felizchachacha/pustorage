#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))
readonly URLRE="(https?|ftp|file)://.*"
readonly KEYSFNAME="keys.bash.dict"
readonly KeyServers=("keyserver.ubuntu.com" "keyserver.linuxmint.com" "ha.pool.sks-keyservers.net")

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
				for serv in ${KeyServers[@]}; do
					apt-key adv --keyserver "${serv}" --recv-keys "${v}" && break
				done
			fi
	done

popd
