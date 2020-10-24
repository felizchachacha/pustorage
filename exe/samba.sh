#!/bin/sh

systemctl restart smbd
systemctl restart nmbd

testparm


