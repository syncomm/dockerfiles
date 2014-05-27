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

MAINTAINER Gregory S. Hayes <ghayes@redhat.com>

# Package install
RUN sed 's/main universe$/main restricted universe multiverse/' -i /etc/apt/sources.list && echo 'deb http://ppa.launchpad.net/gregory-hainaut/pcsx2.official.ppa/ubuntu saucy main' >>  /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 508A982D7A617FF4 && apt-get update
RUN apt-get install -y pcsx2 xauth

# Locale setting
RUN dpkg-reconfigure locales && locale-gen en_US.UTF-8 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV DISPLAY unix:0

# Add start script
ADD start-pcsx2.sh /usr/bin/start-pcsx2.sh
RUN chmod +x /usr/bin/start-pcsx2.sh

# Start pcsx2
ENTRYPOINT /usr/bin/start-pcsx2.sh
