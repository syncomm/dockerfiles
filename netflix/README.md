# docker-netflix #

Container to enable a Netflix player through PipeLight and Firefox.

Working:
* You can log in and watch Netflix!
  * Silverlight (using PipeLight)
  * Video (via X11 sockets and cookie transfer)
  * Sound (through Pulseaudio socket) 

Todo:
* The container is too bloated! Need to trim down the size.
* HW acceleration (possibly through sharing /dev/video0 and /dev/dri)

Build:

```
git clone https://github.com/syncomm/dockerfiles.git
cd dockerfiles/netflix
sudo docker build -t syncomm/netflix .
```
Run with the supplied script `docker-netflix.sh` to transfer your X11 cookie and set up the Pulseaudio socket.

