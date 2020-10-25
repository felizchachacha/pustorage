#!/bin/sh

set -e

awk '$4~/(^|,)ro($|,)/' /proc/mounts
