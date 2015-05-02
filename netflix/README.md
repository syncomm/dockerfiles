# syncomm/netflix #

A docker container to enable a Netflix player through PipeLight and Firefox.

#### Table of Contents
1. [Overview](#overview)
    * [Features](#features)
2. [Installation](#installation)
    * [Requirements](#requirements)
    * [Run docker-netflix.sh](#run-docker-netflix.sh)
    * [Build From Source](#build-from-source)
3. [Usage](#usage)
5. [Limitations](#limitations)
    * [Todo](#todo)

## Overview

Using Netflix on Linux is a cumbersome process today. Getting it up and running requires [Microsoft Silverlight](http://www.microsoft.com/silverlight/). Unfortunately, Microsoft doesn't have native Silverlight for Linux yet. This means deploying Silverlight on a Linux host involves a variety of workarounds, config changes, and even wine patches. The syncomm/netflix container simplifies the process of launching and using Netflix on Linux.

### Features

* Launch, log in, and enjoy Netflix!
  * Silverlight (using [PipeLight](http://pipelight.net/cms/))
  * Video (via X11 sockets and cookie transfer)
  * Sound (through Pulseaudio socket) 

## Installation

### Requirements

* Linux OS
* X11 and Pulseaudio 
* docker
* This should be run as a **normal user** in the [docker group](http://docs.docker.com/installation/ubuntulinux/#giving-non-root-access)

### Run docker-netflix.sh

Installing the syncomm/netflix container is very simple, as it is in the [Docker Registry](https://registry.hub.docker.com/). The easiest method is to download and run the docker-netflix.sh script: 

```
wget https://raw.githubusercontent.com/syncomm/dockerfiles/master/netflix/docker-netflix.sh
chmod +x ./docker-netflix.sh
sudo mv ./docker-netflix.sh /usr/local/bin
```

OR, you can always stay up-to-date by invoking the script straight from github:

```
curl -s https://raw.githubusercontent.com/syncomm/dockerfiles/master/netflix/docker-netflix.sh | bash
```

### Build From Source

To build this container yourself, please follow the instructions below:

```
git clone https://github.com/syncomm/dockerfiles.git
cd dockerfiles/netflix
sudo docker build -t syncomm/netflix .
```

Then run with the supplied script [docker-netflix.sh](https://raw.githubusercontent.com/syncomm/dockerfiles/master/netflix/docker-netflix.sh).

## Usage

1. Invoke docker-netflix.sh
2. When the firefox window appears on the very first run it will indicate it is installing [Silverlight](http://www.microsoft.com/silverlight/) and display the various License information. If you **do not** agree with the eula, then hit ctrl-c and do not proceed. *This container doesn't distribute those components as they are not GPL.*
3. When installation of the plugins to your local docker volume is complete, close the firefox window
4. Launch docker-netflix.sh again and log into Netflix
5. Play a movie! (Hit "Activate Pipelight" and "Always Remember" if prompted)

## Limitations

Hardware acceleration is disabled, and the OpenGL piplight system test will fail. However, there are no known issues with viewing content on Netflix. If you discover a problem, please report it at https://github.com/syncomm/dockerfiles/issues

###Todo

1. Currently, the container is very large (1.3 GB) and I need to trim down the size
    * Difficult due to the dependencies to install firefox and pipelight
    * Investigating other base containers such as debian and ubuntu
2. Enable HW acceleration
    * Still trying to determine how to map the devices from the host
