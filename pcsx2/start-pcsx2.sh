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

echo -e "${lpurp}Checking for X11${NC}" 
if [ ! -e /.Xauthority ];
then
    touch /.Xauthority
fi
if [ ! -d /tmp/.X11-unix/ ];
then
    echo -e "${red}[ERROR] * No X11 socket transfered! Please connect container with \"-v /tmp/.X11-unix:/tmp/.X11-unix\"${NC}"
    exit 1
fi

echo -e "${lpurp}Adding X11 Cookie $XCOOKIE ${NC}"
xauth add $XCOOKIE

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

# TODO:
# Possibly needed for HW accel and alsa
# ln -s /tmp/dri/ /dev/dri
# ln -s /tmp/video0 /dev/video0
# ln -s /tmp/snd/ /dev/snd   

echo -e "${lpurp}Launching PCSX2!${NC}"
PULSE_SERVER=/tmp/.pulse-socket /usr/games/pcsx2 2>&1 >> /dev/null
echo -e "${lpurp}Exiting! Goodbye${NC}"
