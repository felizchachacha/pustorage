#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})
readonly DefaultPresent=(apt.list basic.list minimal.list custom.list withgui.list)
readonly PURGELIST="${MYDIR}/../lib/purge.list"
readonly BACKEND=aptitude

while [ ${#} -gt 0 ]; do
	case ${1} in
		-*)
			opt=${1}
			shift # past option
			AptilistsOptions+=${opt}
		;;
		*-upgrade | install)
			readonly ACT=${1}
			shift # past action
			if [ ${#} -eq 0 ]; then 
				readonly Present=(${DefaultPresent[*]})
			else
				readonly Present=(${*})
			fi
			${BACKEND} ${AptilistsOptions[*]} ${ACT} $(sed 's/$/+/g' ${Present[*]}) $(sed 's/$/_/g' "${PURGELIST}") || apt --fix-broken install
			readonly CODE=$?
			apt autoremove
			exit ${CODE}
		;;
		*)
			readonly ACT=${1}
			shift # past action
			${BACKEND} ${AptilistsOptions[*]} ${ACT} ${*} || apt --fix-broken install
			CODE=$?
			apt autoremove
			exit ${CODE}
		;;
	esac
done
