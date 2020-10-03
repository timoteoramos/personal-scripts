#!/bin/sh

wget -O /tmp/FiraMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraMono.zip
mkdir -p /usr/local/share/fonts/FiraMono
unzip -o -d /usr/local/share/fonts/FiraMono /tmp/FiraMono.zip
rm /usr/local/share/fonts/FiraMono/*Windows*
rm /usr/local/share/fonts/FiraMono/Fura*
fc-cache -fv /usr/local/share/fonts
