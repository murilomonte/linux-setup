#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function add_hardware_decode() {
    echo -e "${COLOR}// -- Configurando aceleração de video via gpu -- //${NOCOLOR}"
    sudo dnf install \
    ffmpeg-free \
    libavcodec-freeworld \
    libva-utils \
    intel-media-driver \
    --allowerasing -y
}