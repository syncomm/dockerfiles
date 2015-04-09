## **syncomm/spotify** 

A docker container to enable [Spotify](https://www.spotify.com) on all Linux distributions

![spotify](https://raw.githubusercontent.com/syncomm/dockerfiles/master/spotify/spotify.png) 

### **Features:**

* Ubuntu based container with the official Spotify package
* Pulseaudio connectivity for audio
* X11 socket sharing
* Runs as a normal user (in the [docker group](http://docs.docker.com/installation/ubuntulinux/#giving-non-root-access))
* Uses a volume container for persistent config and cache

Launch with [docker-spotify.sh](https://raw.githubusercontent.com/syncomm/dockerfiles/master/spotify/docker-spotify.sh) 

*Note: For those who wish to keep SELinux enabled, please see my [docker-spotify SELinux policy](https://github.com/syncomm/dockerfiles/tree/master/spotify/selinux). Hardware acceleration is disabled, and for proper operation it needs to remain this way. If you don't see images on the very first run, you may need to restart spotify (once or twice) to enable them.* 

### **Install:**

On a system with docker installed, run the following command:

```
curl -s https://raw.githubusercontent.com/syncomm/dockerfiles/master/spotify/docker-spotify.sh | bash 
```

Running `docker-spotify.sh` will download the syncomm/spotify container, set up the user's cache container, create the sockets for X11 and Pulseaudio, and launch spotify.

### **Build:**

```
git clone https://github.com/syncomm/dockerfiles.git
cd dockerfiles/spotify
docker build -t syncomm/spotify .
```

Run with the supplied script [docker-spotify.sh](https://raw.githubusercontent.com/syncomm/dockerfiles/master/spotify/docker-spotify.sh) to transfer your X11 cookie and set up the Pulseaudio socket.

