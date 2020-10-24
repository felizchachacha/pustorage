#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})

pushd ${MYDIR}

cp -rv --backup syncthing/* /

systemctl daemon-reload

systemctl enable syncthing

systemctl restart syncthing

systemctl status syncthing

popd
