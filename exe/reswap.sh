#!/usr/bin/env bash

set -xe

readonly SWAPS=$(swapon --show --noheadings | cut -f1 -d' ')

for ${s} in ${SWAPS}; do
	swapoff -v ${s} && swapon -v ${s}
done
