#!/usr/bin/env bash

set -xe

readonly MYDIR=$(dirname ${0})

pushd "${MYDIR}"

# Cloudflare +
# Another example DNS server you could use is OpenDNS - for example:
# 8.8.8.8 is Google's own DNS server.
../../exe/add-dns.bash 1.1.1.1 208.67.222.222 8.8.8.8

popd
