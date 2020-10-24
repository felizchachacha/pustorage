#!/usr/bin/env bash

set -x

declare -A Params
 
Params["top_maxinflight"]=128
Params["resilver_min_time_ms"]=6000
Params["resilver_delay"]=0
Params["vdev_scheduler"]="none"

for key in ${!Params[@]}; do
	val=${Params[${key}]}
	sysctl vfs.zfs.${key}=${val}
	echo "${val}" > /sys/module/zfs/parameters/zfs_${key}
	echo "options zfs zfs_${key}=${val}" >> /etc/modprobe.d/zfs.conf
done	

#sysctl vfs.zfs.top_maxinflight=128
#sysctl vfs.zfs.resilver_min_time_ms=6000
#sysctl vfs.zfs.resilver_delay=0

#echo "options zfs zfs_vdev_scheduler=none" > /etc/modprobe.d/zfs.conf

#/sys/module/zfs/parameters/zfs_resilver_min_time_ms
#!/usr/bin/env bash


#echo "none" > /sys/module/zfs/parameters/zfs_vdev_scheduler
#echo "options zfs zfs_vdev_scheduler=none" > /etc/modprobe.d/zfs.conf

