#!/bin/bash

. /etc/os-release
os=$ID

if [[ $os = 'ubuntu' ]]; then
    echo "#===================#"
    echo "Atualizando sistema"
    echo "#===================#"
    sudo apt update
    sudo apt upgrade -y

    echo "#===================#"
    echo "Removendo snap"
    echo "#===================#"
    sudo snap remove gtk-common-themes
    sudo snap remove gnome-3-38-2004
    sudo snap remove firefox
    sudo snap remove firefox
    sudo snap remove core20
    sudo snap remove bare
    sudo snap remove snapd

    sudo apt purge snap snapd
    sudo apt autoremove

    echo '# To prevent repository packages from triggering the installation of Snap,
    # this file forbids snapd from being installed by APT.
    # For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html

    Package: snapd
    Pin: release a=*
    Pin-Priority: -10
    ' | sudo tee -a /etc/apt/preferences.d/nosnap.pref

    echo "#===================#"
    echo "Adicionando suporte a flatpak"
    echo "#===================#"
    sudo apt install flatpak -y
    sudo apt install plasma-discover-backend-flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # instalando firefox flatpak
    flatpak install -y flathub org.mozilla.firefox

    echo "#===================#"
    echo "Instalando icones"
    echo "#===================#"
    sudo add-apt-repository ppa:papirus/papirus -y && sudo apt update && sudo apt install papirus-icon-theme papirus-folders -y && papirus-folders -C breeze --theme Papirus-Dark

    echo "#===================#"
    echo "Instalando outros apps"
    echo "#===================#"
    sudo apt install neofetch intel-gpu-tools htop scrcpy obs-studio

elif [[ $os = 'fedora' ]]; then
    echo "#===================#"
    echo "Atualizando sistema"
    echo "#===================#"
    sudo dnf update -y

    echo "#===================#"
    echo "Configurando rpm fusion"
    echo "#===================#"
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    echo "#===================#"
    echo "Configurando video decode vaapi"
    echo "#===================#"
    sudo dnf install ffmpeg libva-utils intel-media-driver

    echo "#===================#"
    echo "Adicionando suporte a flatpak e instalando apps"
    echo "#===================#"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    echo "#===================#"
    echo "Instalando outros apps"
    echo "#===================#"
    sudo dnf install neofetch intel-gpu-tools htop gnome-tweak-tool scrcpy papirus-icon-theme -y
fi

echo "#===================#"
echo "Instalando apps flatpak"
echo "#===================#"
# firefox github-desktop telegram flatseal steam
flatpak install -y flathub io.github.shiftey.Desktop org.telegram.desktop com.github.tchx84.Flatseal com.valvesoftware.Steam com.github.libresprite.LibreSprite

echo "#===================#"
echo "Configurando tema dos apps flatpak"
echo "#===================#"
# confirando temas 
flatpak install org.gtk.Gtk3theme.Breeze
sudo flatpak override --system --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtkrc-2.0:ro --filesystem=xdg-config/gtk-4.0:ro --filesystem=xdg-config/gtkrc:ro --env "GTK_THEME=Breeze"


echo "#===================#"
echo "Reiniciando"
echo "#===================#"
#reboot
