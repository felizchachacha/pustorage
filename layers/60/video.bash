#!/usr/bin/env bash

#apt install --reinstall xserver-xorg-video-amdgpu
#dpkg --configure -a
#dpkg-reconfigure xserver-xorg-video-amdgpu

# you can enable accelerated video:
#aptitude -y install vdpauinfo libvdpau-va-gl1 mesa-vdpau-drivers

# Then to test the VDPAU driver with mpv use:
mpv --hwdec=vdpau yourvideofile


