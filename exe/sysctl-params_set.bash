#!/usr/bin/env bash

set -x

declare -A Params
 
Params["vm.swappiness"]=1
Params["fs.inotify.max_user_watches"]=1048576
Params["net.ipv6.conf.all.disable_ipv6"]=0
Params["net.ipv6.conf.default.disable_ipv6"]=0

# #disable ipv6
#net.ipv6.conf.all.disable_ipv6 = 1
#net.ipv6.conf.default.disable_ipv6 = 1
#net.ipv6.conf.lo.disable_ipv6 = 1
#net.ipv6.conf.eth0.disable_ipv6 = 1

for key in ${!Params[@]}; do
	val=${Params[${key}]}
	sysctl ${key}=${val}
	echo "${key}=${val}" | sudo tee /etc/sysctl.d/${key}.conf
done	
