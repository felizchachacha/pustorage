#!/usr/bin/env bash

set -e
set -x


for ds in `zfs list -H -o name,canmount,mountpoint,type | awk '$4=="filesystem" && $2=="on" && $3!="none" && $3!="legacy" {print $1" "$3}' | sort -k2 | awk '{print $1}'`; do zfs mount $ds; done
