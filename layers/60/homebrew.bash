#!/usr/bin/env bash

set -xe

readonly MYDIR="$(dirname $(realpath ${0}))"

readonly DWNLD_LINK="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
readonly TARGET_FNAME="homebrew_install.sh"

pushd "${MYDIR}"
	wget -c "${DWNLD_LINK}" -O "${TARGET_FNAME}"
	chmod +x "${TARGET_FNAME}"
	./"${TARGET_FNAME}" || if [[ $(./"${TARGET_FNAME}") == "Don't run this as root!" ]]; then
		readonly U="$(cat ../../lib/DEFUSER)"
		#ln -vb "${TARGET_FNAME}" /tmp/"${TARGET_FNAME}" || cp -b "${TARGET_FNAME}" /tmp/"${TARGET_FNAME}"
		mv -v "${TARGET_FNAME}" /tmp/"${TARGET_FNAME}"
		chown "${U}":"${U}" /tmp/"${TARGET_FNAME}"
		su - "${U}" -c /tmp/"${TARGET_FNAME}"
	fi
popd
