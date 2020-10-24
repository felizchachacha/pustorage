#!/usr/bin/env bash

set -e

readonly MYDIR="$(dirname $(realpath ${0}))"
readonly CACHED=/var/cache/apt/archives/
readonly PARTIALD=/var/cache/apt/archives/partial
readonly URLRE="(https?|ftp|file)://.*"

function process_package_url_line() {
	package_name=${1}
	deburl=${2}
	if "${MYDIR}"/apt-is-installed.bash "${package_name}"; then
		echo "${package_name} is already installed"
	else
		expected_fname=$(basename "${deburl}")
		if [ -e ${CACHED}/${expected_fname} ]; then
			dpkg -i ${CACHED}/${expected_fname}
		elif [ -e ${CACHED}/${package_name}.deb ]; then
			dpkg -i ${CACHED}/${package_name}.deb
		else 
			logtmpfile=$(mktemp /tmp/$(basename "${deburl}").XXXXXX)
			pushd ${PARTIALD}
				wget -c "${deburl}" 2>&1 | tee ${logtmpfile}
				downloaded_fname=$(tail -2 ${logtmpfile} | awk -vFS='‘|’' '/saved/ {print $2}')
				rm ${logtmpfile} &
				mv -v "${downloaded_fname}" ${CACHED}/
			popd
			pushd ${CACHED}
				[[ "${downloaded_fname}" == "${package_name}.deb" ]] || ln -v "${downloaded_fname}" "${package_name}.deb" &
				[[ "${downloaded_fname}" == "${expected_fname}" ]] || ln -v "${downloaded_fname}" "${expected_fname}" &
				dpkg -i ${downloaded_fname}
			popd
		fi
	fi
}

for arg in ${*}; do
	if [[ "${arg}" =~ ${URLRE} ]]; then
		deburl="${arg}"
		expected_fname=$(basename "${deburl}")
		expected_package_name="${expected_fname%.*}"
		process_package_url_line ${expected_package_name} ${deburl}
	elif [ -f "${arg}" ]; then
		listfile="${arg}"
		cat "${listfile}" | while read package_url_line; do
			process_package_url_line ${package_url_line}
		done <&0
	else
		echo "${arg} is not an url and not a list file"
	fi
done

apt install -f
apt --fix-broken install
