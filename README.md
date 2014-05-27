# syncomm's Dockerfiles #

These are a collection of my dockerfiles. Most are X based for now,
as that is the area which is giving me the most interest. 

## X11 and Docker ##
To forward X11 through docker efficiently, all you need to do is set
the DISPLAY environment to unix:(your host DISPLAY) and share the 
host filesystem socket (ex. /tmp/.X11-unix/X0). This can be done in
most cases with:

*Host:*
```
sudo docker run -rm -v /tmp/.X11-unix/:/tmp/.X11-unix/ -i -t fedora /bin/bash
```

*Container:*
```
export DISPLAY=unix:0
```

_-v_ is for volume mapping and can be invoked multiple times for the same container.
Sound can also be forwarded this way through sharing Pulseaudio, sockets and setting 
`PULSE_SERVER` on the container to point at the socket.


