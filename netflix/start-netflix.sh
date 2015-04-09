#! /bin/bash

#########################################################################
# Script: start-netflix.sh                                              #
# Version: 0.5.0                                                        #
#                                                                       #
# Description:                                                          #
# The script to start netflix inside the container                      #
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
if [ ! -e /home/netflix/.Xauthority ];
then
    touch /home/netflix/.Xauthority
fi
if [ ! -d /tmp/.X11-unix/ ];
then
    echo -e "${red}[ERROR] * No X11 socket transfered! Start this container with docker-spotify.sh${NC}"
    exit 1
fi
export DISPLAY="unix:0"

echo -e "${lpurp}Adding X11 Cookie $XCOOKIE ${NC}"
xauth add $XCOOKIE

echo -e "${lpurp}Checking for Pulseaudio${NC}" 
if [ ! -e /tmp/.netflix-pulse-socket ];
then
    echo -e "${red}[ERROR] * No Pulseaudio socket transfered! Start this container with docker-spotify.sh${NC}"
    echo
    exit 1
fi
export PULSE_SERVER=/tmp/.netflix-pulse-socket

export WINE=/usr/bin/wine
# Reduce output
export WINEDEBUG=-all

echo -e "${red}[WARNING] * Disabling HW accelleration${NC}" 
/usr/share/pipelight/pipelight-hw-accel --disable &>/dev/null
export PIPELIGHT_GPUACCELERATION=0
echo -e "${lpurp}Updating Pipelight${NC}" 
pipelight-plugin --update &>/dev/null

# Clean up on second run only
if [ -e ~/first-run ]; then
  echo -e "${lpurp}Cleaning up from first run${NC}" 
  rm -rf ~/.mozilla
  rm ~/first-run
fi

# Detect first run and enable Pipelight
if [ ! -e ~/.config ]; then
  echo -e "${yellow}Detected First Run${NC}" 
  mkdir ~/.config/
  touch ~/.config/wine-wininet-installer.accept-license
  touch ~/first-run
  echo -e "${lpurp}Enabling Pipelight [silverlight]${NC}" 
  pipelight-plugin --accept --enable silverlight
  echo -e "${yellow}"
  pipelight-plugin --system-check 2>&1 | grep -E 'PASS|FAIL|32 bit|64 bit|missing'
  echo -e "${NC}"
fi

echo -e "${lpurp}Launching NetFlix!${NC}"
firefox -no-remote http://www.netflix.com &>/dev/null

echo -e "${lpurp}Exiting! Goodbye${NC}"
exit 0
