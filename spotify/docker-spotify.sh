#! /bin/bash

#########################################################################
# Script: docker-spotify.sh                                             #
# Version: 0.1.0                                                        #
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
    pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.spotify-pulse-socket
fi

# Persistant cache and config 
if [ ! -e ~/.docker-spotify ];
then
    echo -e "${lpurp}Creating local user config and cache at ~/.docker-spotify${NC}"
    mkdir ~/.docker-spotify
    mkdir ~/.docker-spotify/config
    mkdir ~/.docker-spotify/cache
fi

# Launch syncomm/spotify container 
echo -e "${lpurp}Launching syncomm/spotify container${NC}" 
echo docker run --rm --name spotify -e XCOOKIE=\'$XCOOKIE\' -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /tmp/.spotify-pulse-socket:/tmp/.spotify-pulse-socket -v ~/.docker-spotify/cache:/home/spotify/.cache -v ~/.docker-spotify/config:/home/spotify/.config -t syncomm/spotify | sh
# Need to clean up Pulseaudio socket !!
# pactl unload-module module-native-protocol-unix

exit 0
