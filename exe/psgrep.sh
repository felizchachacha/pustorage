#!/bin/sh

set -x

ps aux | egrep $* | egrep -v '(psgrep)|(egrep)'

