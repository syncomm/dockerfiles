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
# by Gregory S. Hayes <syncomm@gmail.com>
#
##################################################################
FROM mjdsys/ubuntu-saucy-i386

MAINTAINER Gregory S. Hayes <syncomm@gmail.com>

RUN sed 's/main universe$/main restricted universe multiverse/' -i /etc/apt/sources.list && echo 'deb http://ppa.launchpad.net/gregory-hainaut/pcsx2.official.ppa/ubuntu saucy main' >>  /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 508A982D7A617FF4 && apt-get update
RUN apt-get install -y pcsx2 xauth openssh-server
RUN dpkg-reconfigure locales && locale-gen en_US.UTF-8 && /usr/sbin/update-locale LANG=en_US.UTF-8
RUN echo "X11Forwarding yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir -p /var/run/sshd
RUN useradd -p 1234567890 -s /bin/bash -d /home/pcsx2 pcsx2
RUN mkdir -p /home/pcsx2/.ssh
RUN touch /home/pcsx2/.ssh/authorized_keys
RUN chmod 0640 /home/pcsx2/.ssh/authorized_keys
RUN touch /home/pcsx2/.Xauthority
RUN mkdir -p /home/pcsx2/.config/pcsx2
RUN chown -R pcsx2:pcsx2 /home/pcsx2

ADD start-pcsx2.sh /usr/bin/start-pcsx2.sh
RUN chmod +x /usr/bin/start-pcsx2.sh

EXPOSE 22

# ENTRYPOINT /usr/bin/start-pcsx2.sh
/bin/bash
