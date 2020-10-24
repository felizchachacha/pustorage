#!/bin/sh

set -x

uname -a

lsb_release -a

find /etc /proc -maxdepth 1 -type f '(' -iname '*release*' -or -iname '*version*' -or -iname '*issue*' ')' -execdir cat '{}' \+



