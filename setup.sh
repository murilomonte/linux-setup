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
    code --skip-unavailable -y
    
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
    com.calibre_ebook.calibre \
    org.localsend.localsend_app \
    org.onlyoffice.desktopeditors \
    com.discordapp.Discord \
    com.rafaelmardojai.Blanket \
    org.libretro.RetroArch  -y

    sudo flatpak override --filesystem=$HOME/.themes
    sudo flatpak override --filesystem=$HOME/.icons
    sudo flatpak override --filesystem=/usr/share/themes
    sudo flatpak override --filesystem=/usr/share/icons

    echo -e "${color}// -- Configurando codecs necessários -- //${nocolor}"
    sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
    sudo dnf install lame\* --exclude=lame-devel -y
    sudo dnf group upgrade --with-optional Multimedia

    if [[ $variant = 'workstation' ]]; then
        echo -e "${color}// -- Instalando outros apps (workstation) -- //${nocolor}"
        sudo dnf copr enable dusansimic/themes

        # dnf
        sudo dnf install \
        morewaita-icon-theme \
        nautilus-python \
        nautilus-extensions \
        libgtop2-devel \
        lm_sensors \
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
        net.nokyan.Resources \
        org.gnome.Mines \
        page.tesk.Refine -y

        # echo -e "${color}// -- Configurando tema dos apps flatpak (workstation) -- //${nocolor}"
        # sudo dnf install adw-gtk3-theme -y
        # flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y

        # sudo flatpak override --env=GTK_THEME=adw-gtk3-dark
        # sudo flatpak override --env=ICON_THEME=adw-gtk3-dark
        
        # Configurando o tema de apps nativos
        # gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

        # gsettings set org.gnome.desktop.background picture-uri-dark file:///home/$HOME/linux-setup/wallpaper/wallpaper02.jpg
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
        org.kde.ktorrent \
        org.videolan.VLC -y
    fi
    echo -e "${color}// -- Agora é só reiniciar! -- //${nocolor}"
else
    echo "[Erro] Esse script só funciona no Fedora :(" 
fi
