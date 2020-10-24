#!/usr/bin/env bash

#set -e
set -x

for ds in `mount |grep '\/mnt\/z' | awk '{print $1}'`; do zfs umount $ds; done
