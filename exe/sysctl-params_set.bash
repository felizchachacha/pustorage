#!/usr/bin/env bash

set -x

declare -A Params
 
Params["vm.swappiness"]=1
Params["fs.inotify.max_user_watches"]=1048576

for key in ${!Params[@]}; do
	val=${Params[${key}]}
	sysctl ${key}=${val}
	echo "${key}=${val}" | sudo tee /etc/sysctl.d/${key}.conf
done	
