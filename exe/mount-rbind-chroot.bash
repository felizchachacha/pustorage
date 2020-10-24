#!/usr/bin/env bash

set -xe

readonly T_ROOT=${1}

[[ ${TROOT} == '' ]] && exit 1

readonly RBINDS=(dev media proc run sys tmp)

for rbm in ${RBINDS[*]}; do
	target=${T_ROOT}/${rbm}
	[ -d ${target} ] || mkdir ${target}
	mount --rbind /${rbm} ${target}
done

chroot ${*}


