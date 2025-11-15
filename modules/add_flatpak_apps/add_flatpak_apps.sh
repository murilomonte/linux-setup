#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function add_flatpak_apps() {
    echo -e "${COLOR}// -- Adicionando suporte ao flathub -- //${NOCOLOR}"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Desinstalando libreoffice
    sudo dnf remove libreoffice-*

    # Desinstalando firefox
    sudo dnf remove firefox -y

    echo -e "${COLOR}// -- Instalando apps flatpak -- //${NOCOLOR}"
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
    io.github.kolunmi.Bazaar \
    io.beekeeperstudio.Studio \
    io.github.ciromattia.kcc \
    com.vysp3r.ProtonPlus \
    io.github.vikdevelop.SaveDesktop \
    dev.deedles.Trayscale \
    app.zen_browser.zen \
    org.libretro.RetroArch \
    com.mattjakeman.ExtensionManager \
    de.haeckerfelix.Fragments \
    com.github.finefindus.eyedropper \
    org.gnome.SoundRecorder \
    io.github.celluloid_player.Celluloid \
    org.gnome.Epiphany \
    be.alexandervanhee.gradia \
    io.github.nozwock.Packet \
    org.gnome.Papers \
    app.drey.KeyRack \
    com.mattjakeman.ExtensionManager \
    com.github.neithern.g4music \
    io.missioncenter.MissionCenter \
    page.tesk.Refine -y
}