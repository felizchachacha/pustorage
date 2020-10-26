#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})
readonly U="$(cat ${MYDIR}/../../lib/DEFUSER)"

readonly DWNLD_LINK="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
readonly TARGET_F="/tmp/homebrew_install.sh"

pushd "${MYDIR}"
	wget -c "${DWNLD_LINK}" -O "${TARGET_F}"
	chmod +x "${TARGET_F}"
	"${TARGET_F}" || if [[ $("${TARGET_F}") == "Don't run this as root!" ]]; then
		chown "${U}":"${U}" "${TARGET_F}"
		su - "${U}" -c "${TARGET_F}"
	fi
popd
