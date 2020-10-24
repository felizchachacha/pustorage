#!/usr/bin/env bash

set -xe

if [ -e /etc/cron.daily/mlocate ]; then
	mv /etc/cron.daily/mlocate /etc/cron.weekly/
else
	exit 0
fi

