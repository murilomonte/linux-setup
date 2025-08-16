#!/bin/bash

. /etc/os-release
os=$ID
variant=$VARIANT_ID
color='\033[33;45;1m'
nocolor='\033[0m'

if [[ $os = 'fedora' ]]; then
    echo -e "${color}// -- Atualizando sistema -- //${nocolor}"
    sudo dnf update -y

    echo -e "${color}// -- Configurando rpm fusion -- //${nocolor}"
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

    echo -e "${color}// -- Configurando aceleração de video via gpu -- //${nocolor}"
    sudo dnf install \
    ffmpeg-free \
    libavcodec-freeworld \
    libva-utils \
    intel-media-driver \
    --allowerasing -y
    
    echo -e "${color}// -- Instalando apps (dnf) -- //${nocolor}"
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
    eglinfo --skip-unavailable -y 
    
    echo -e "${color}// -- Adicionando suporte ao flathub -- //${nocolor}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Desinstalando libreoffice
    sudo dnf remove libreoffice-*

    # Desinstalando firefox
    sudo dnf remove firefox -y

    echo -e "${color}// -- Instalando apps flatpak -- //${nocolor}"
    flatpak install flathub \
    org.mozilla.firefox \
    com.github.tchx84.Flatseal \
    com.valvesoftware.Steam \
    org.telegram.desktop \
    org.kde.kdenlive \
    com.heroicgameslauncher.hgl \
    io.itch.itch \
    org.nickvision.tubeconverter \
    org.gnome.design.Contrast \
    io.github.nate_xyz.Paleta \
    org.gnome.Quadrapassel \
    io.gitlab.theevilskeleton.Upscaler \
    io.mrarm.mcpelauncher \
    com.spotify.Client \
    net.lutris.Lutris \
    com.obsproject.Studio \
    com.github.xournalpp.xournalpp \
    com.google.Chrome \
    org.freedesktop.Platform.VulkanLayer.gamescope \
    com.github.libresprite.LibreSprite \
    hu.kramo.Cartridges \
    page.kramo.Sly \
    org.gnome.Mines \
    com.calibre_ebook.calibre \
    org.localsend.localsend_app \
    org.onlyoffice.desktopeditors \
    com.discordapp.Discord \
    com.rafaelmardojai.Blanket \
    org.pgadmin.pgadmin4 \
    org.vinegarhq.Sober \
    com.google.AndroidStudio \
    org.libretro.RetroArch  -y

    sudo flatpak override --filesystem=$HOME/.themes
    sudo flatpak override --filesystem=$HOME/.icons
    sudo flatpak override --filesystem=/usr/share/themes
    sudo flatpak override --filesystem=/usr/share/icons

    echo -e "${color}// -- Configurando codecs necessários -- //${nocolor}"
    sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
    sudo dnf install lame\* --exclude=lame-devel -y
    sudo dnf group upgrade --with-optional Multimedia

    echo -e "${color}// -- Configurando UV (python) -- //${nocolor}"
    curl -LsSf https://astral.sh/uv/install.sh | sh

    if [[ $variant = 'workstation' ]]; then
        echo -e "${color}// -- Instalando outros apps (workstation) -- //${nocolor}"
        sudo dnf copr enable dusansimic/themes

        # dnf
        sudo dnf install \
        morewaita-icon-theme \
        nautilus-python \
        nautilus-extensions \
        adw-gtk3-theme \
        file-roller -y

        # flatpak
        flatpak install flathub \
        com.mattjakeman.ExtensionManager \
        de.haeckerfelix.Fragments \
        com.github.finefindus.eyedropper \
        org.gnome.SoundRecorder \
        io.github.celluloid_player.Celluloid \
        org.gnome.Epiphany \
        io.bassi.Amberol \
        be.alexandervanhee.gradia \
        io.github.nozwock.Packet \
        net.nokyan.Resources \
        org.gnome.Papers \
        app.drey.KeyRack \
        page.tesk.Refine -y

    else 
        echo -e "${color}// -- Debloat :) (kde spin) -- //${nocolor}"
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

        echo -e "${color}// -- Configurando tema dos apps flatpak (kde spin) -- //${nocolor}"
        flatpak install flathub org.gtk.Gtk3theme.Breeze -y
        # sudo flatpak override --system --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtkrc-2.0:ro  --filesystem=xdg-config/gtkrc:ro --env "GTK_THEME=Breeze"

        # flatpak
        flatpak install flathub \
        org.qbittorrent.qBittorrent \
        org.videolan.VLC -y
    fi
    echo -e "${color}// -- Agora é só reiniciar! -- //${nocolor}"
else
    echo "[Erro] Esse script só funciona no Fedora :(" 
fi
