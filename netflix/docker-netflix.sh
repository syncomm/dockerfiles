#! /bin/bash

#########################################################################
# Script: docker-netflix.sh                                             #
# Version: 0.2.1                                                        #
#                                                                       #
# Description:                                                          #
# The script to start the syncomm/netflix container                     #
#                                                                       #
# Copyright (C) 2015, Gregory S. Hayes <ghayes@redhat.com>              #
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

# Stop screensaver (need to detect gsettings)
echo -e "${lpurp}Stopping Screensaver${NC}" 
xset s off
xset s noblank
xset -dpms
# TODO: Figure out what is happening on gnome 3
# gsettings set org.gnome.desktop.session idle-delay 0
# gsettings set org.gnome.desktop.screensaver lock-delay 3600
# gsettings set org.gnome.desktop.screensaver lock-enabled false
# gsettings set org.gnome.desktop.screensaver idle-activation-enabled false

# Get the X11 Cookie to pass
echo -e "${lpurp}Grabbing X11 Cookie of host${NC}" 
XCOOKIE=`xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g'`

# Create the Pulseaudio Socket
if [ ! -e /tmp/.netflix-pulse-socket ];
then
    echo -e "${lpurp}Adding Pulseaudio socket at /tmp/.netflix-pulse-socket${NC}" 
    NETFLIXSOCKET=`pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.netflix-pulse-socket`
fi

# Persistant cache and config 
CONTAINER=$USER-netflix-data
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)
if [ $? -eq 1 ]; then
  echo -e "${lpurp}Creating user config and cache container $CONTAINER${NC}"
  CONTAINER_ID=$(docker create -v /home/netflix --name $CONTAINER syncomm/netflix)
  echo -e "${lpurp}Container $CONTAINER created with id $CONTAINER_ID{NC}"
fi

echo -e "${lpurp}Launching syncomm/netflix container${NC}" 
echo docker run --rm -e XCOOKIE=\'$XCOOKIE\' \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v /tmp/.netflix-pulse-socket:/tmp/.netflix-pulse-socket \
  --volumes-from $CONTAINER \
  -t syncomm/netflix | sh

# Resume screensaver
echo -e "${lpurp}Resuming Screensaver${NC}" 
xset s on
xset +dpms
# TODO: Figure out what is happening on gnome 3
# gsettings set org.gnome.desktop.session idle-delay 300

# Clean up Pulseaudio socket
echo -e "${lpurp}Removing Pulseaudio socket at /tmp/.netflix-pulse-socket${NC}" 
pactl unload-module $NETFLIXSOCKET

exit 0
