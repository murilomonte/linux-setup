#!/bin/bash

. /etc/os-release
os=$ID
variant=$VARIANT_ID
color='\033[33;45;1m'
nocolor='\033[0m'

if [[ $os = 'fedora' ]]; then
    if [[ $variant = 'silverblue' ]]; then
        echo -e "${color}// -- Instalando rpm apps (silverblue) -- //${nocolor}"
        rpm-ostree install distrobox

        echo -e "${color}// -- Instalando apps flatpak (silverblue) -- //${nocolor}"
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
        org.freedesktop.Platform.ffmpeg-full \
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
        org.libretro.RetroArch  \
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
        dev.zed.Zed \
        page.tesk.Refine -y

        sudo flatpak override --filesystem=$HOME/.themes
        sudo flatpak override --filesystem=$HOME/.icons

        echo -e "${color}// -- Reinstalando apps via flathub (silverblue) -- //${nocolor}"

        flatpak install --reinstall flathub $(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application | tail -n +1 ) -y
        flatpak remote-delete fedora
    fi

    echo -e "${color}// -- Agora é só reiniciar! -- //${nocolor}"
else
    echo "[Erro] Esse script só funciona no Fedora :("
fi
