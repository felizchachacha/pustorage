#!/usr/bin/env bash

set -ex

readonly MYDIR=$(dirname ${0})

teamviewer daemon enable
#teamviewer daemon status # interactive
teamviewer repo
read -e -p "Enter teamviewer temporary password: " TP
teamviewer passwd ${TP}
teamviewer info
readonly TVID=$(teamviewer info | awk '/TeamViewer ID/ {print $NF}')
teamviewer daemon start
teamviewer daemon status
echo -e "Now you can try:
ID:\t${TVID}
with a temp password:\t${TP}
"

[[ "${TVID}" == *[^[:space:]]* ]] && "${MYDIR}"/../../exe/sux.sh $(cat "${MYDIR}"/../../lib/DEFUSER) -c teamviewer
