#!/bin/sh

set -x

ps aux | grep $* | grep -v grep | tr -s " " | cut -d " " -f 2 | xargs kill -9

