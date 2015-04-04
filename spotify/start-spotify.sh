#! /bin/bash

#########################################################################
# Script: start-spotify.sh                                              #
# Version: 0.2.1                                                        #
#                                                                       #
# Description:                                                          #
# The script to start spotify inside the container                      #
#                                                                       #
# Copyright (C) 2014, Gregory S. Hayes <ghayes@redhat.com>              #
#                                                                       #
# This program is free software; you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation; either version 2 of the License, or     #
# (at your option) any later version.                                   #
#                                                                       #
# This program is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of        #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
# GNU General Public License for more details.                          #
#                                                                       #
# You should have received a copy of the GNU General Public License     #
# along with this program; if not, write to the                         #
# Free Software Foundation, Inc.,                                       #
# 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
#                                                                       #
#########################################################################

# Set some colors
red='\e[0;31m'
lpurp='\e[1;35m'
yellow='\e[1;33m'
NC='\e[0m' # No Color

echo -e "${lpurp}Checking for X11${NC}" 
if [ ! -e /home/spotify/.Xauthority ];
then
    touch /home/spotify/.Xauthority
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
if [ ! -e /tmp/.spotify-pulse-socket ];
then
    echo -e "${red}[ERROR] * No Pulseaudio socket transfered! Please connect container with \"-v /tmp/.spotify-pulse-socket:/tmp/.spotify-pulse-socket\"${NC}"
    echo -e "${red}          You can create a Pulseaudio socket by running:${NC}"
    echo
    echo -e "${yellow}pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.spotify-pulse-socket${NC}"
    echo
    exit 1
fi

echo -e "${lpurp}Launching Spotify!${NC}"
pulseaudio -D &
PULSE_SERVER=/tmp/.spotify-pulse-socket spotify --ui.hardware_acceleration=false &>/dev/null

echo -e "${lpurp}Exiting! Goodbye${NC}"
exit 0
