#!/usr/bin/env bash

set -ex

readonly MYDIR="$(dirname $(realpath ${0}))"
readonly DEFUSER="$(cat ${MYDIR}/../lib/DEFUSER)"

smbpasswd -a "${DEFUSER}"
smbpasswd -a root

