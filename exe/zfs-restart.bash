#!/usr/bin/env bash

set -ex

readonly MYDIR="$(dirname $(realpath ${0}))"


for device in /sys/block/sd*; do
     (udevadm info --query=property --path=$device | grep -q "^ID_BUS=usb") && removable_devs_expression+="|$(basename $device)"
done

pushd "${MYDIR}"
	./zfs-params_set.bash
	systemctl stop zfs-zed
	modprobe -r zfs
	./zfs-params_set.bash
popd

modprobe zfs
systemctl start zfs-zed

for device in /sys/block/sd*; do
     (udevadm info --query=property --path=$device | grep -q "^ID_BUS=usb") && removable_devs_expression+="|$(basename $device)"
done

