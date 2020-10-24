#!/usr/bin/env bash

set -xe

#dpkg-reconfigure tzdata

#read -e -p "Enter timezone: " tz

pip install -U tzupdate

tzupdate
