#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname $(realpath ${0}))
readonly HOTKEYS_RELDIR=".local/share/kxmlgui5/konsole"
readonly SOURCE_F=${MYDIR}/konsole/sessionui.rc

pushd /home
for u in root *; do
	eval homedir="$(printf "~${u}/%q")" # safe tilde expansion https://stackoverflow.com/questions/3963716/how-to-manually-expand-a-special-variable-ex-tilde-in-bash/29310477#29310477
	eval targetdir="$(printf "~${u}/%q" "$HOTKEYS_RELDIR")" # safe tilde expansion https://stackoverflow.com/questions/3963716/how-to-manually-expand-a-special-variable-ex-tilde-in-bash/29310477#29310477
	[ -d "${targetdir}" ] || mkdir -p "${targetdir}"
	cp -v "${SOURCE_F}" "${targetdir}"/
	chown -R ${u}:${u} ${homedir} &
done

popd

