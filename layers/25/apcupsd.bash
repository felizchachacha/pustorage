#!/usr/bin/env bash

# https://www.one-tab.com/page/hq_n5oC4QKy0vEaw5U1mPQ

set -xe

readonly MYDIR=$(dirname ${0})

pushd ${MYDIR}

	../../exe/apt-is-installed.bash apcupsd || apt -y install apcupsd

	cp -rv --backup apcupsd/* /

	systemctl restart apcupsd

	apcaccess status &

popd
