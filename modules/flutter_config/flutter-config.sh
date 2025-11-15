#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function flutter_config() {
    
    if command -v flutter >/dev/null 2>&1; then
        echo -e "${COLOR}// -- Configurando Flutter -- //${NOCOLOR}"
        ## Use android studio flatpak
        flutter config --android-studio-dir /var/lib/flatpak/app/com.google.AndroidStudio/current/active/files/extra
    else
        echo -e "${COLOR}// -- Flutter não instalado. Pulando config -- //${NOCOLOR}"
    fi
}