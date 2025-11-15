#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function debloat_plasma() {
    echo -e "${COLOR}// -- Debloat :) (kde spin) -- //${NOCOLOR}"
    sudo dnf remove \
    akregator \
    mediawriter \
    kmag \
    kgpg \
    qt5-qdbusviewer \
    kcharselect kcolorchooser \
    dragon \
    kmines \
    kmahjongg \
    kpat \
    kruler \
    kmousetool \
    kmouth \
    kolourpaint \
    konversation \
    krdc \
    kfind \
    kaddressbook \
    kmail \
    kontact \
    korganizer \
    ktnef \
    kf5-akonadi-* \
    dnfdragora -y
}