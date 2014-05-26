#! /bin/bash
touch /.Xauthority
xauth add $XCOOKIE
ln -s /tmp/dri/ /dev/dri
ln -s /tmp/video0 /dev/video0
ln -s /tmp/snd/ /dev/snd   
WINE=/usr/bin/wine /usr/share/pipelight/pipelight-hw-accel --disable
firefox http://www.netflix.com

