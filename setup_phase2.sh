#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Script must be run as root!"
	exit 1
fi

apt-get update
if [ $? -ne 0 ]; then
    echo "ERROR: apt-get update failed! Are you connected to the Internet?"
    exit 1
fi

apt-get -y upgrade
if [ $? -ne 0 ]; then
    echo "ERROR: apt-get upgrade failed! Are you connected to the Internet?"
    exit 1
fi

apt-get -y install sunxi-tools
if [ $? -ne 0 ]; then
    echo "ERROR: Installing sunxi-tools failed! Are you connected to the Internet?"
    exit 1
fi

fex2bin orange_pi2.fex > /media/boot/script.bin

sed -i -re 's/^#+gpio-sunxi$/gpio-sunxi/' /etc/modules

echo "SYSTEM WILL NOW REBOOT"
reboot

