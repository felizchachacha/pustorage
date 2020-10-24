#!/bin/sh

set -e

echo ${PATH} | sed 's/^/"/g; s/\:/"\n"/g; s/$/"/g'

