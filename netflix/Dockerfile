##################################################################
# Container: syncomm/netflix
# Version: 0.1.1
#
# Description:
# A container for running firefox and pipelight to access netflix
# 
# by Gregory S. Hayes <ghayes@redhat.com>
#
##################################################################
FROM fedora

MAINTAINER Gregory S. Hayes <ghayes@redhat.com>

RUN yum -y install firefox xauth cabextract wget xorg-x11-font-utils
RUN yum -y groupinstall Fonts
RUN yum -y update
RUN wget http://download.opensuse.org/repositories/home:/DarkPlayer:/Pipelight/Fedora_20/home:DarkPlayer:Pipelight.repo -O /etc/yum.repos.d/pipelight.repo
RUN rpm -i http://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
RUN yum -y install pipelight
RUN pipelight-plugin --update
RUN /usr/bin/yes | pipelight-plugin --enable silverlight
RUN echo 'pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120427 Firefox/15.0a1");' >> /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
RUN echo 'pref("browser.tabs.forceHide", true);' >> /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
RUN wget http://ix.io/8H3 -O /usr/share/pipelight/pipelight-hw-accel
RUN chmod +x /usr/share/pipelight/pipelight-hw-accel
RUN sed -i.bak -e 's/...usr.bin.id -u. -eq 0/1 \-eq 0/g' /usr/share/pipelight/pipelight-hw-accel

ENV DISPLAY unix:0

ADD start-netflix.sh /usr/bin/start-netflix.sh
RUN chmod +x /usr/bin/start-netflix.sh

ENTRYPOINT "/usr/bin/start-netflix.sh"
