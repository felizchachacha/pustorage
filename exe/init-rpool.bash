#!/usr/bin/env bash

set -xe

zpool import -fR /mnt/z -d /dev/disk/by-id rpool
zfs load-key rpool                                                                     
zpool resilver rpool        
#zpool scrub rpool        

