#!/usr/bin/env bash

apt install --reinstall xserver-xorg-video-amdgpu
dpkg --configure -a
dpkg-reconfigure xserver-xorg-video-amdgpu

# you can enable accelerated video:
apt-get install mesa-vdpau-drivers

# Then to test the VDPAU driver with mpv use:
mpv --hwdec=vdpau yourvideofile


