#! /bin/bash

#########################################################################
# Script: docker-spotify.sh                                             #
# Version: 0.5.0                                                        #
#                                                                       #
# Description:                                                          #
# The script to start the syncomm/netflix container                     #
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

# Get the X11 Cookie to pass
echo -e "${lpurp}Grabbing X11 Cookie of host${NC}" 
XCOOKIE=`xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g'`

# Create the Pulseaudio Socket
if [ ! -e /tmp/.spotify-pulse-socket ];
then
    echo -e "${lpurp}Adding Pulseaudio socket at /tmp/.spotify-pulse-socket${NC}" 
    SPOTIFYSOCKET=`pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.spotify-pulse-socket`
fi

# Persistant cache and config 
CONTAINER=$USER-spotify-data
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ $? -eq 1 ]; then
    echo -e "${lpurp}Creating user config and cache container $CONTAINER${NC}"
    CONTAINER_ID=$(docker create -v /home/spotify --name $CONTAINER syncomm/spotify)
    echo -e "${lpurp}Container $CONTAINER created with id $CONTAINER_ID{NC}"
fi

# Launch syncomm/spotify container 
echo -e "${lpurp}Launching syncomm/spotify container${NC}" 
echo docker run --rm --name spotify \
  -e XCOOKIE=\'$XCOOKIE\' \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v /tmp/.spotify-pulse-socket:/tmp/.spotify-pulse-socket \
  --volumes-from $CONTAINER \
  -t syncomm/spotify | sh

# Clean up Pulseaudio socket
echo -e "${lpurp}Removing Pulseaudio socket at /tmp/.spotify-pulse-socket${NC}" 
pactl unload-module $SPOTIFYSOCKET

exit 0
