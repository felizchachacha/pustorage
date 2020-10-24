#!/usr/bin/env bash

set -ex

#declare -a ZTries
#
#declare -a ZTryComp
#
#ZTryComp+=(-O compress=zstd -o compress=zstd -O compression=zstd -o compression=zstd)
#ZTryComp+=(-O compress=zstd -o compress=zstd -O compression=zstd -o compression=zstd)
#arr02=(4 '5 6')
#arr1=(arr01 arr02)
#arr=(arr1)
#
#declare -n elmv1 elmv2
#
#for elmv1 in "${arr[@]}"; do
#    for elmv2 in "${elmv1[@]}"; do
#        for elm in "${elmv2[@]}"; do
#            echo "<$elm>"
#        done
#    done
#done

declare -A ZEverys
ZEverys["ashift"]=12
ZEverys["autotrim"]='on'
ZEverys["acltype"]='posixacl'
ZEverys["dnodesize"]='auto'
ZEverys["normalization"]='formD'
ZEverys["atime"]='off'
ZEverys["checksum"]='on' # https://openzfs.github.io/openzfs-docs/Basic%20Concepts/Checksums.html
#ZEverys["xattr"]=('sa' 'on')

declare -A ZFeats
ZFeats["lz4_compress"]='enabled'
ZFeats["embedded_data"]='enabled'
ZFeats["empty_bpobj"]='enabled'
ZFeats["enabled_txg"]='enabled'
ZFeats["extensible_dataset"]='enabled'
ZFeats["filesystem_limits"]='enabled'
ZFeats["hole_birth"]='enabled'
ZFeats["large_blocks"]='enabled'
ZFeats["large_dnode"]='enabled'
ZFeats["bookmarks"]='enabled'
ZFeats["spacemap_histogram"]='enabled'
ZFeats["userobj_accounting"]='enabled'

declare	-A ZPoolOpts

declare	-A ZfsOpts
ZfsOpts['com.sun:auto-snapshot']='true'

#Optional
#    -O encryption=aes-256-gcm \
#    -O keylocation=prompt -O keyformat=passphrase \
#    -O encryption=aes-256-gcm \
#    -O keylocation=prompt -O keyformat=passphrase \
#keylocation
#keyformat
#dedup
#recordsize
#altroot

function update_opts() {
	declare -a Options=()

	for key in ${!ZEverys[@]}; do
		ZFeats["${key}"]=${ZEverys["${key}"]}
		ZPoolOpts["${key}"]=${ZEverys["${key}"]}
		ZfsOpts["${key}"]=${ZEverys["${key}"]}
	done

	for feature in ${!ZFeats[@]}; do
		ZPoolOpts["feature@${feature}"]=${ZFeats["${feature}"]}
	done

	for poolopt in ${!ZPoolOpts[@]}; do
		Options+=(-O "${poolopt}"="${ZPoolOpts[${poolopt}]}")
	done

	for zfsopt in ${!ZfsOpts[@]}; do
		Options+=(-o "${zfsopt}"="${ZfsOpts[${zfsopt}]}")
	done
}


function try_opts() {
	while ! "${cmd}"
}
readonly BASECMD="zpool create ${Options[@]}"

#zpool create -o altroot=/mnt -O compress=lz4 -O atime=off -m none -f "zroot" mirror  ada0p3 ada1p3
#
#zpool create \
#    -o ashift=12 \
#    -O acltype=posixacl -O canmount=off -O compression=lz4 \
#    -O dnodesize=auto -O normalization=formD -O relatime=on \
#    -O xattr=sa -O mountpoint=/ -R /mnt \
#    rpool ${DISK}-part4
#
#
#zpool create -o ashift=12 -o feature@lz4_compress=enabled -o feature@embedded_data=enabled -o feature@empty_bpobj=enabled -o feature@enabled_txg=enabled -o feature@extensible_dataset=enabled -o feature@filesystem_limits=enabled -o feature@hole_birth=enabled -o feature@large_blocks=enabled -o feature@large_dnode=enabled -o feature@bookmarks=enabled -o feature@spacemap_histogram=enabled -o feature@userobj_accounting=enabled -o autotrim=on -O acltype=posixacl -O compression=lz4 -O dnodesize=auto -O normalization=formD -O atime=off -O mountpoint=/mnt/fast -O encryption=on -O keylocation=prompt -O keyformat=passphrase -O sharesmb=on -O sharenfs=on -O dedup=off -O com.sun:auto-snapshot=true -R /mnt/z fastpool /dev/disk/by-id/ata-Corsair_Force_GT_11488203000009900017
