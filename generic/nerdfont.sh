#!/bin/sh

wget -O /tmp/UbuntuMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip
mkdir -p /usr/local/share/fonts/UbuntuMono
unzip -d /usr/local/share/fonts/UbuntuMono /tmp/UbuntuMono.zip
rm /usr/local/share/fonts/UbuntuMono/*Windows*
fc-cache -fv /usr/local/share/fonts
