#!/usr/bin/env bash

set -ex

readonly MYDIR="$(dirname $(realpath ${0}))"
readonly OLDHOSTNAME="$(cat ${MYDIR}/../lib/OLDHOSTNAME)"
readonly HN="$(cat ${MYDIR}/../lib/HN)"
#read -e -p "Enter hostname: " HN

hostname ${HN}

sed -i "s/${OLDHOSTNAME}/${HN}/g" /etc/hostname /etc/hosts

