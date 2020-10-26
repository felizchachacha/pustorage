#!/usr/bin/env bash

set -e

readonly MYDIR=$(dirname ${0})
readonly DEFUSER="$(cat ${MYDIR}/../../lib/DEFUSER)"

teamviewer daemon enable
teamviewer repo
teamviewer daemon start
teamviewer info
readonly TVID=$(teamviewer info | awk '/TeamViewer ID/ {print $NF}')
teamviewer daemon status

if (( TVID > 0 )); then
	read -e -p "Enter teamviewer temporary password (at least 8 characters): " TP
	teamviewer passwd ${TP}
	teamviewer daemon restart
	echo -e "Now you can try:
	ID:\t${TVID}
	with a temp password:\t${TP}
	"
else
	su - "${DEFUSER}" -c "DISPLAY=:0.0 teamviewer" &
fi

