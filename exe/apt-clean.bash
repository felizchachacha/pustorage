#!/usr/bin/env bash

set -x

apt-get clean

apt-get update

apt autoremove

aptitude clean

aptitude autoclean
