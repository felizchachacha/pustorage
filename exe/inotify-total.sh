#!/usr/bin/env sh

find /proc/*/fd -user "$USER" -lname anon_inode:inotify \
	   -printf '%hinfo/%f\n' 2>/dev/null |
	      xargs cat | grep -c '^inotify'
