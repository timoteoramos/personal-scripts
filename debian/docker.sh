#!/bin/bash

apt remove --purge -y docker docker-engine docker.io containerd runc
apt update
apt install -y apt-transport-https ca-certificates curl gnupg-agent lsb-release software-properties-common

if [ -z $DISTRO ]; then DISTRO=`lsb_release -is | awk '{print tolower($0)}'`; fi
if [ -z $CODENAME ]; then CODENAME=`lsb_release -cs`; fi

curl -fsSL https://download.docker.com/linux/$DISTRO/gpg | apt-key add -
add-apt-repository "deb https://download.docker.com/linux/$DISTRO $CODENAME stable"
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose
