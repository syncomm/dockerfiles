# Docker Netflix #

Container to enable a Netflix player through PipeLight and FireFox.

Working:
* You can log in and watch Netflix!
  * Silverlight (using PipeLight)
  * Video (via X11 sockets and cookie transfer)
  * Sound (through Pulseaudio socket) 

Todo:
* The container is too bloated! Need to trim down the size.
* HW acceleration (possibly through sharing /dev/video0 and /dev/dri)
