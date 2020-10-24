#!/usr/bin/env bash

set -xe

[ -d /opt/storj ] || mkdir /opt/storj

pushd /opt/storj

# https://documentation.storj.io/dependencies/identity

wget https://github.com/storj/storj/releases/latest/download/identity_linux_amd64.zip -O identity_linux_amd64.zip
unzip -o identity_linux_amd64.zip
chmod +x identity

rm identity_linux_amd64.zip &

./identity create storagenode &>./identity.log &


popd


