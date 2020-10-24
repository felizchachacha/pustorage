#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})

pushd ${MYDIR}

cp -rv --backup logrotate/* /

popd
