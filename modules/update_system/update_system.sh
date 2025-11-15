#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function update_system() {
    echo -e "${COLOR}// -- Atualizando sistema -- //${NOCOLOR}"
    sudo dnf update -y
}