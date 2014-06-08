#! /bin/bash
##################################################################
# Script: start-pcsx2.sh
# Version: 0.0.1
#
# Description:
# The script to start pcsx2 inside the container
# 
# by Gregory S. Hayes <ghayes@redhat.com>
#
##################################################################

# Set some colors
red='\e[0;31m'
lpurp='\e[1;35m'
yellow='\e[1;33m'
NC='\e[0m' # No Color

echo -e "${lpurp}Adding SSH Key${NC}" 
echo "$SSHKEY" >> /home/pcsx2/.ssh/authorized_keys

echo -e "${lpurp}Checking for Pulseaudio${NC}" 
if [ ! -e /tmp/.pulse-socket ];
then
    echo -e "${red}[ERROR] * No Pulseaudio socket transfered! Please connect container with \"-v /tmp/.pulse-socket:/tmp/.pulse-socket\"${NC}"
    echo -e "${red}          You can create a Pulseaudio socket by running:${NC}"
    echo
    exho -e "${yellow}pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.pulse-socket${NC}"
    echo
    exit 1
fi

/usr/sbin/sshd -D 
