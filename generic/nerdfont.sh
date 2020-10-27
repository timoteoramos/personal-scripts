#!/bin/bash

if [ -z $PREFIX ]; then PREFIX=/usr/local; fi
if [ -z $TMP ]; then TMP=/tmp; fi

install_nerdfont () {
    wget -O $TMP/$1.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$1.zip
    mkdir -p $PREFIX/share/fonts/$1
    unzip -o -d $PREFIX/share/fonts/$1 $TMP/$1
    rm $PREFIX/share/fonts/$1/*Windows*
    rm $TMP/$1.zip
}

CHECK=$(dialog --stdout \
    --title "Nerd Fonts" --checklist "Select the desired fonts to download and install" 0 0 0 \
    FiraMono "Mozilla typeface, dotted zero" off \
    Meslo "Slashed zeros, customized version of Apple's Menlo" off \
    Ubuntu "Specially created for Ubuntu" off \
)

if [ $? -eq 0 ]; then
    if [[ ! $CHECK = *"FiraMono"* ]]; then rm -Rf $PREFIX/share/fonts/FiraMono; fi
    if [[ ! $CHECK = *"Meslo"* ]]; then rm -Rf $PREFIX/share/fonts/Meslo; fi
    if [[ ! $CHECK = *"Ubuntu"* ]]; then rm -Rf $PREFIX/share/fonts/Ubuntu; fi

    for ITEM in $CHECK; do
        install_nerdfont $ITEM
    done

    fc-cache -fv $PREFIX/share/fonts
fi
