#!/bin/sh
zpool status -v | tail -12 | sed 's/^[[:space:]]*/rm -v \"/g;s/\/$//g;s/$/\";/g'
