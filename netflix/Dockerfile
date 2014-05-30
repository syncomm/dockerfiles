##################################################################
# Container: syncomm/netflix
# Version: 0.2.1
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
RUN sed -i.bak -e 's/...usr.bin.id -u. -eq 0/1 \-eq 0/g' /usr/share/pipelight/pipelight-hw-accel
RUN chmod +x /usr/share/pipelight/pipelight-hw-accel

ADD start-netflix.sh /usr/bin/start-netflix.sh
RUN chmod +x /usr/bin/start-netflix.sh

RUN echo 'pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120427 Firefox/15.0a1");' >> /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
RUN echo 'pref("signon.rememberSignons", false);' >> /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
ADD userChrome.css /usr/lib64/firefox/browser/defaults/profile/chrome/userChrome.css

RUN echo 'netflix ALL = NOPASSWD: ALL' > /etc/sudoers.d/netflix && chmod 0440 /etc/sudoers.d/netflix
RUN useradd -d /home/netflix -p "!" -m -g video -c "Docker-Netflix" netflix
USER netflix
ENV HOME /home/netflix

ENTRYPOINT "/usr/bin/start-netflix.sh"
