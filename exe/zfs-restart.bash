#!/usr/bin/env bash

set -x

for device in /sys/block/sd*; do
     (udevadm info --query=property --path=$device | grep -q "^ID_BUS=usb") && removable_devs_expression+="|$(basename $device)"
done

source zfs-params_set.bash
systemctl stop zfs-zed
modprobe -r zfs
source zfs-params_set.bash
modprobe zfs
systemctl start zfs-zed

for device in /sys/block/sd*; do
     (udevadm info --query=property --path=$device | grep -q "^ID_BUS=usb") && removable_devs_expression+="|$(basename $device)"
done
