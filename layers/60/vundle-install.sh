#!/usr/bin/env bash

set -xe

readonly DEFUSER="$(cat ${MYDIR}/../../lib/DEFUSER)"

vim +PluginInstall +qall

su - "${DEFUSER}" vim +PluginInstall +qall
