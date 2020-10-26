#!/usr/bin/env bash

set -ex

readonly MYDIR="$(dirname $(realpath ${0}))"

"${MYDIR}"/../../exe/grub-probe.wrapper.bash install
