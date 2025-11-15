#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function flatpak_permissions() {
    echo -e "${COLOR}// -- Configurando permissões flatpak -- //${NOCOLOR}"
    sudo flatpak override --filesystem=home/.themes
    sudo flatpak override --filesystem=home/.icons
    sudo flatpak override --filesystem=/usr/share/themes
    sudo flatpak override --filesystem=/usr/share/icons
}