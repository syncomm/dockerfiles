#! /bin/bash
##################################################################
# Script: docker-pcsx2.sh
# Version: 0.0.1-alpha (VERY ALPHA!)
#
# Description:
# A script for starting the PCSX2 docker container 
# It maps X11, sound, and persistant sotrage,
# 
# by Gregory S. Hayes <ghayes@redhat.com>
#
##################################################################

# Set some colors
red='\e[0;31m'
lpurp='\e[1;35m'
yellow='\e[1;33m'
NC='\e[0m' # No Color

echo -e "${lpurp}Passing ssh key${NC}" 
SSHKEY=`cat ~/.ssh/id_rsa.pub`

if [ ! -e /tmp/.pulse-socket ];
then
    echo -e "${lpurp}Adding Pulseaudio socket at /tmp/.pulse-socket${NC}" 
    pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.pulse-socket
fi

echo -e "${lpurp}Launching syncomm/pcsx2 container:${NC}" 
JOB=$(sudo docker run -d -e SSHKEY="$SSHKEY" -v /tmp/.pulse-socket:/tmp/.pulse-socket -v ~/.local/share/docker-pcsx2:/home/pcsx2/.config/pcsx2 -t syncomm/pcsx2)
IPADDR=$(sudo docker inspect $JOB | grep IPAd | awk -F'"' '{print $4}')
PID=$(sudo docker inspect $JOB | grep Pid |  awk -F'[:,]' '{print $2}')
echo -e "  ${lpurp}Image:${NC} syncomm/pcsx2"
echo -e "  ${lpurp}Container:${NC} $JOB"
echo -e "  ${lpurp}pid:${NC} $PID"
echo -e "  ${lpurp}IP:${NC} $IPADDR"
sleep 3
ssh -XCt -c blowfish-cbc,arcfour -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -oCheckHostIP=no pcsx2@$IPADDR "PULSE_SERVER=/tmp/.pulse-socket /usr/games/pcsx2 2>&1 >> /dev/null" 
