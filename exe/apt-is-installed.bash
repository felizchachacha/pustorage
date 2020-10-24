#!/usr/bin/env bash

set -xe

dpkg-query -W -f='${Status}' ${*}  | grep "ok installed"
exit $?
