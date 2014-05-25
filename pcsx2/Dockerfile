##################################################################
# Container: syncomm/pcsx2
# Version: 0.0.1-alpha (VERY ALPHA!)
#
# Description:
# A Playstation 2 emulator. Requires a dump of a real PS2 BIOS (not included)
# WARNING: It requires a CPU with SSE2 instructions. If your CPU does not
# support this instruction set, it does not have enough horse power to run
# this emulator anyway.
#
# by Gregory S. Hayes <ghayes@redhat.com>
#
##################################################################

FROM mjdsys/ubuntu-saucy-i386

# Package install
RUN sed 's/main universe$/main restricted universe multiverse/' -i /etc/apt/sources.list && echo 'deb http://ppa.launchpad.net/gregory-hainaut/pcsx2.official.ppa/ubuntu saucy main' >>  /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 508A982D7A617FF4 && apt-get update
RUN apt-get install -y pcsx2 xauth

# Locale setting
RUN dpkg-reconfigure locales && locale-gen en_US.UTF-8 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV DISPLAY unix:0
RUN touch /.Xauthority
# Need to share magic cookie here with xauth add to write a script to load it from the host

# Need to share volume here, weird problems
# VOLUME ["/tmp/.X11-unix/:/tmp/.X11-unix/"]

# Start pcsx2
# CMD /usr/games/pcsx2

# Run container with:
# docker run -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/user/pcsx-docker-drive:/.config/pcsx2 -i -t syncomm/pcsx2 /bin/bash
# then import magic cookie (for now!) and exec /usr/games/pcsx2
