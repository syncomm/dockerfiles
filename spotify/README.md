# syncomm/spotify #

A docker container to enable Spotify on all Linux distributions.

> Note: You will need to turn off Hardware Acceleration under Edit->Preferences and restart spotify to enable images

## Build:

`git clone https://github.com/syncomm/dockerfiles.git`

`cd dockerfiles/spotify`

`sudo docker build -t syncomm/spotify .`

Run with the supplied script [docker-spotify.sh](https://raw.githubusercontent.com/syncomm/dockerfiles/master/spotify/docker-spotify.sh) to transfer your X11 cookie and set up the Pulseaudio socket.


