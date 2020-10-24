#!/usr/bin/env bash

set -xe

readonly CONFD=/etc/resolvconf/resolv.conf.d/

[ -d ${CONFD} ] || mkdir -p ${CONFD}
for s in ${*}; do 
	echo "nameserver ${s}" | tee -a /etc/resolv.conf | tee ${CONFD}/${s}
done
