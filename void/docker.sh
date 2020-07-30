#!/bin/sh

xbps-install -Sy docker docker-compose
ln -s /etc/sv/containerd /var/service/
ln -s /etc/sv/docker /var/service/
