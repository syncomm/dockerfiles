#! /bin/bash
##################################################################
# Script: start-netflix.sh
# Version: 0.2.0
#
# Description:
# The script to start netflix inside the container
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
if [ ! -e /home/netflix/.Xauthority ];
then
    touch /home/netflix/.Xauthority
fi
if [ ! -d /tmp/.X11-unix/ ];
then
    echo -e "${red}[ERROR] * No X11 socket transfered! Please connect container with \"-v /tmp/.X11-unix:/tmp/.X11-unix\"${NC}"
    exit 1
fi
export DISPLAY="unix:0"

echo -e "${lpurp}Adding X11 Cookie $XCOOKIE ${NC}"
xauth add $XCOOKIE

echo -e "${lpurp}Checking for Pulseaudio${NC}" 
if [ ! -e /tmp/.netflix-pulse-socket ];
then
    echo -e "${red}[ERROR] * No Pulseaudio socket transfered! Please connect container with \"-v /tmp/.netflix-pulse-socket:/tmp/.netflix-pulse-socket\"${NC}"
    echo -e "${red}          You can create a Pulseaudio socket by running:${NC}"
    echo
    echo -e "${yellow}pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.netflix-pulse-socket${NC}"
    echo
    exit 1
fi

# TODO:
# Possibly needed for HW accel and alsa:
# pass /dev/device as /tmp/device and link
# ln -s /tmp/dri/ /dev/dri
# ln -s /tmp/video0 /dev/video0
# ln -s /tmp/snd/ /dev/snd   

# Reduce output
export WINEDEBUG=-all

echo -e "${lpurp}Checking Pipelight Install${NC}" 
WINE=/usr/bin/wine pipelight-plugin --system-check 2>&1 | grep -E 'PASS|FAIL'

echo -e "${red}[WARNING] * Disabling HW accelleration${NC}" 
# WINE=/usr/bin/wine /usr/share/pipelight/pipelight-hw-accel --disable 2>&1 >> /dev/null

echo -e "${lpurp}Launching NetFlix!${NC}"
PULSE_SERVER=/tmp/.netflix-pulse-socket PIPELIGHT_GPUACCELERATION=0 firefox -no-remote http://www.netflix.com 2>&1 >> /dev/null

echo -e "${lpurp}Exiting! Goodbye${NC}"
exit 0
