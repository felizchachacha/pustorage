#!/usr/bin/env bash

set -xe

#read -e -p "Enter hostname: " HN

readonly HN="casa"

hostname ${HN}

sed -i "s/kubuntu/${HN}/g" /etc/hostname /etc/hosts

