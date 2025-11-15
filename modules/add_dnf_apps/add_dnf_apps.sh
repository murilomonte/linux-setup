#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function add_dnf_apps() {
    echo -e "${COLOR}// -- Instalando apps (dnf) -- //${NOCOLOR}"
    # configurando repositório do github-desktop
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'

    # configurando repositório do vscode
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    
    # Configurando copr do scrcpy
    sudo dnf copr enable zeno/scrcpy -y

    sudo dnf check-update

    sudo dnf install \
    screenfetch \
    intel-gpu-tools \
    inxi \
    htop \
    github-desktop \
    android-tools \
    scrcpy \
    wine-core \
    libheif-freeworld \
    blueman \
    ibm-plex-mono-fonts \
    earlyoom \
    libgtop2-devel \
    lm_sensors \
    code \
    java-21-openjdk \
    clang \
    cmake \
    ninja-build \
    gtk3-devel \
    morewaita-icon-theme \
    nautilus-python \
    nautilus-extensions \
    adw-gtk3-theme \
    file-roller \
    eglinfo --skip-unavailable -y 
}