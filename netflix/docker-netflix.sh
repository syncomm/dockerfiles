#! /bin/bash
XCOOKIE=`xauth list | grep unix | cut -f2 -d"/"`
docker run --rm -e XCOOKIE='$XCOOKIE' \
    -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
    -v /dev/video0:/tmp/video0 \
    -v /dev/snd/:/tmp/snd \
    -v /dev/dri/:/tmp/dri \
    -i -t syncomm/netflix
exit 0
