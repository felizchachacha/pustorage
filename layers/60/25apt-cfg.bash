#!/usr/bin/env bash

set -xe

cp -rv --backup apt-cfg/* /

apt update

apt --fix-broken install

apt-file update &

