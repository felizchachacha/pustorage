#!/usr/bin/env bash

set -ex

readonly MYDIR="$(dirname $(realpath ${0}))"
readonly OLDHOSTNAME="$(cat ${MYDIR}/../lib/OLDHOSTNAME)"

#read -e -p "Enter hostname: " HN

readonly HN="casa"

hostname ${HN}

sed -i "s/${OLDHOSTNAME}/${HN}/g" /etc/hostname /etc/hosts

