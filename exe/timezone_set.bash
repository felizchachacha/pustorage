#!/usr/bin/env bash

set -xe

#dpkg-reconfigure tzdata

#read -e -p "Enter timezone: " tz

timedatectl set-timezone "Europe/Minsk"
