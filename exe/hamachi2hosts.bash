#!/usr/bin/env bash

set -xe

hamachi list | awk '/^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ {print $4"\t"$3}' >> /etc/hosts

