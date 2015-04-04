#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Must be run as root"
    exit
fi

echo "Compiling docker-spotify SELinux module"
checkmodule -M -m -o docker-spotify.mod docker-spotify.te
echo "Packaging module"
semodule_package -o docker-spotify.pp -m docker-spotify.mod
echo "Installing module"
semodule -i docker-spotify.pp
