#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))
readonly KEYSCACHED=${MYDIR}/../lib/"trusted.gpg.d"
readonly URLRE="(https?|ftp|file)://.*"
readonly KEYSFNAME="keys.bash.dict"
readonly KeyServers=("keyserver.ubuntu.com" "keyserver.linuxmint.com" "ha.pool.sks-keyservers.net")

source "${KEYSFNAME}"
echo ${Keys}

pushd "${KEYSCACHED}"
	
	cp -blvu * /etc/apt/trusted.gpg.d/ || cp -bvu * /etc/apt/trusted.gpg.d/

	for keyname in "${!Keys[@]}"; do
		v=${Keys["${keyname}"]}
		# if such key file is imported successfully locally
		keyfile="${keyname}.gpg"
		apt-key add "${keyfile}" || if [[ "${v}" =~ ${URLRE} ]]; then
				wget -cO "${keyfile}" "${v}"
				apt-key add "${keyfile}"
			else
				for serv in ${KeyServers[@]}; do
					apt-key adv --keyserver "${serv}" --recv-keys "${v}" && break
				done
			fi
	done

	cp -blvu * /etc/apt/trusted.gpg.d/ || cp -bvu * /etc/apt/trusted.gpg.d/

popd
