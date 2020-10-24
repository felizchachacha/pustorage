#!/usr/bin/env bash

set -e

readonly RWPARTNO=1
readonly LIVEDISK=$(mount | awk -vFS='[0-9]|[[:space:]]' '$4=="/cdrom" {print $1}')

echo "${LIVEDISK}${RWPARTNO}"
