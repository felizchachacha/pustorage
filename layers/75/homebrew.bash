#!/usr/bin/env bash

set -xe

readonly MYDIR="$(dirname $(realpath ${0}))"

readonly DWNLD_LINK="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
readonly TARGET_F="/tmp/homebrew_install.sh"

pushd "${MYDIR}"
	wget -c "${DWNLD_LINK}" -O "${TARGET_F}"
	chmod +x "${TARGET_F}"
	"${TARGET_F}" || if [[ $("${TARGET_F}") == "Don't run this as root!" ]]; then
		readonly U="$(cat ../../lib/DEFUSER)"
		chown "${U}":"${U}" "${TARGET_FNAME}"
		su - "${U}" -c "${TARGET_FNAME}"
	fi
popd
