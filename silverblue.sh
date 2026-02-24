#!/bin/bash

. /etc/os-release
os=$ID
variant=$VARIANT_ID
color='\033[33;45;1m'
nocolor='\033[0m'

if [[ $os = 'fedora' ]]; then
    if [[ $variant = 'silverblue' ]]; then
        echo -e "${color}// -- Instalando apps flatpak (silverblue) -- //${nocolor}"
        flatpak install flathub -y \
        com.google.AndroidStudio/x86_64/stable  \
        io.github.kolunmi.Bazaar/x86_64/stable \
        io.beekeeperstudio.Studio/x86_64/stable \
        com.rafaelmardojai.Blanket/x86_64/stable \
        studio.planetpeanut.Bobby/x86_64/stable \
        org.gnome.Boxes/x86_64/stable \
        io.github.diegopvlk.Cine/x86_64/stable \
        org.gnome.design.Contrast/x86_64/stable \
        io.github.pol_rivero.github-desktop-plus/x86_64/stable \
        com.discordapp.Discord/x86_64/stable \
        com.mattjakeman.ExtensionManager/x86_64/stable \
        com.github.finefindus.eyedropper/x86_64/stable \
        org.gnome.FileRoller/x86_64/stable \
        org.mozilla.firefox/x86_64/stable \
        org.gnome.Firmware/x86_64/stable \
        com.github.tchx84.Flatseal/x86_64/stable \
        io.github.tfuxu.floodit/x86_64/stable \
        de.haeckerfelix.Fragments/x86_64/stable \
        com.github.neithern.g4music/x86_64/stable \
        com.google.Chrome/x86_64/stable \
        be.alexandervanhee.gradia/x86_64/stable \
        com.heroicgameslauncher.hgl/x86_64/stable \
        org.kde.kdenlive/x86_64/stable \
        app.drey.KeyRack/x86_64/stable \
        org.localsend.localsend_app/x86_64/stable \
        net.lutris.Lutris/x86_64/stable \
        org.gnome.Mines/x86_64/stable \
        io.missioncenter.MissionCenter/x86_64/stable \
        com.obsproject.Studio/x86_64/stable \
        org.onlyoffice.desktopeditors/x86_64/stable \
        io.github.nozwock.Packet/x86_64/stable \
        org.nickvision.tubeconverter/x86_64/stable \
        org.pgadmin.pgadmin4/x86_64/stable \
        io.podman_desktop.PodmanDesktop/x86_64/stable \
        com.vysp3r.ProtonPlus/x86_64/stable \
        org.gnome.Quadrapassel/x86_64/stable \
        page.tesk.Refine/x86_64/stable \
        io.github.vikdevelop.SaveDesktop/x86_64/stable \
        org.gnome.SoundRecorder/x86_64/stable \
        com.spotify.Client/x86_64/stable \
        com.valvesoftware.Steam/x86_64/stable \
        org.telegram.desktop/x86_64/stable \
        dev.deedles.Trayscale/x86_64/stable \
        io.gitlab.theevilskeleton.Upscaler/x86_64/stable \
        org.gnome.Epiphany/x86_64/stable \
        com.github.xournalpp.xournalpp/x86_64/stable \
        dev.zed.Zed/x86_64/stable \
        com.ranfdev.DistroShelf/x86_64/stable \
        io.github.flattool.Warehouse/x86_64/stable

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
