#!/usr/bin/env bash

set -ex

readonly MYDIR="$(dirname $(realpath ${0}))"
readonly DEFUSER="$(cat ${MYDIR}/../lib/DEFUSER)"

#cat ~/.Xauthority | sudo -u user2 -i tee .Xauthority > /dev/null
su - "${DEFUSER}" -c "DISPLAY=:0.0 /bin/systemsettings5 kcm_kscreen" &


