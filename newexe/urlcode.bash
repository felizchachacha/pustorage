#!/usr/bin/env bash

set -e

readonly R=$(curl --head ${@} 2>/dev/null | awk '/HTTP/ {print $2}')

echo ${R}

if (( R == 200 )); then
	exit 0
else
	exit ${R}
fi

