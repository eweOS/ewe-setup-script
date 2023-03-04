#!/bin/sh
# ewe-setup-script
# This script is part of eweOS project. See https://os.ewe.moe for details.
# Copyright (c) 2023 Ziyao.
# By MIT License.


compositorList="sway"

usage() {
	echo "$0: Setup Wayland Compositors"
	echo "Usage:"
	echo "$0 <username> <compositor>"
	echo "Available compositors:"
	echo $compositorList
}

fix_driver() {
	if lspci | grep "Virtio GPU" > /dev/null
	then
		if [ ! -f /usr/lib/libLLVM.so ]
		then
			pacman -Sy llvm		# llvm15.so is needed
		fi
	fi
}

if [ `whoami` != root ]
then
	echo "Run me as root."
	exit 1
fi

if [ $1x = x ]
then
	usage
	exit 1
fi

pacman -Syu
if [ $2x = x ]
then
	echo "No compositor specified. Only permission will be adjusted."
elif echo $compositorList | grep $2 > /dev/null
then
	echo "Specified compositor $gCompositor."
	pacman -Syu $2
else
	echo "No compositor specified. Only permission will be adjusted."
fi

fix_driver

addgroup $1 video
addgroup $1 input
