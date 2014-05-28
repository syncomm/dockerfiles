##################################################################
# Container: syncomm/netflix
# Version: 0.2.0
#
# Description:
# A container for running firefox and pipelight to access netflix
# 
# by Gregory S. Hayes <ghayes@redhat.com>
#
##################################################################
FROM fedora

MAINTAINER Gregory S. Hayes <ghayes@redhat.com>

RUN curl http://download.opensuse.org/repositories/home:/DarkPlayer:/Pipelight/Fedora_20/home:DarkPlayer:Pipelight.repo > /etc/yum.repos.d/pipelight.repo
RUN yum -y install firefox xauth pipelight http://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
RUN pipelight-plugin --update && pipelight-plugin --accept --enable silverlight

ADD pipelight-hw-accel /usr/share/pipelight/pipelight-hw-accel
RUN chmod +x /usr/share/pipelight/pipelight-hw-accel

ADD start-netflix.sh /usr/bin/start-netflix.sh
RUN chmod +x /usr/bin/start-netflix.sh

ENTRYPOINT "/usr/bin/start-netflix.sh"
