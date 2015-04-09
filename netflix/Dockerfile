#########################################################################
# Container: syncomm/netflix                                            #
# Version: 0.5.0                                                        #
#                                                                       #
# Description:                                                          #
# A container for running firefox and pipelight to access netflix       #
#                                                                       #
# Copyright (C) 2014,2015 Gregory S. Hayes <syncomm@gmail.com>          #
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

FROM fedora:21

MAINTAINER Gregory S. Hayes <syncomm@gmail.com>

# Install Pipelight
RUN curl http://download.opensuse.org/repositories/home:/DarkPlayer:/Pipelight/Fedora_21/home:DarkPlayer:Pipelight.repo > /etc/yum.repos.d/pipelight.repo && yum -y install attr isdn4k-utils unixODBC sane-backends-libs libv4l mesa-libOSMesa samba-devel libxslt firefox xauth pipelight http://sourceforge.net/projects/mscorefonts2/files/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm && yum clean all

# Enable Pipelight
RUN mkdir ~/.config && touch ~/.config/wine-wininet-installer.accept-license
RUN WINE=/usr/bin/wine pipelight-plugin --update &>/dev/null
RUN WINE=/usr/bin/wine pipelight-plugin --accept --enable silverlight

# Custom userChrome.css
RUN echo 'pref("general.useragent.override", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120427 Firefox/15.0a1");' >> /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js && echo 'pref("signon.rememberSignons", false);' >> /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
ADD userChrome.css /usr/lib64/firefox/browser/defaults/profile/chrome/userChrome.css

# Add netflix user
RUN useradd -d /home/netflix -p "!" -m -g video -c "Docker-Netflix" netflix
USER netflix
ENV HOME /home/netflix

# Add start script
ADD start-netflix.sh /usr/bin/start-netflix.sh

VOLUME /home/netflix

ENTRYPOINT "/usr/bin/start-netflix.sh"
