#!/bin/bash

. /etc/os-release
os=$ID
variant=$VARIANT_ID

if [[ $os = 'ubuntu' ]]; then
    echo ""
    echo "#===================#"
    echo "Atualizando sistema"
    echo "#===================#"
    sudo apt update
    sudo apt upgrade -y

    echo ""
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

    echo ""
    echo '# To prevent repository packages from triggering the installation of Snap,
    # this file forbids snapd from being installed by APT.
    # For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html

    Package: snapd
    Pin: release a=*
    Pin-Priority: -10
    ' | sudo tee -a /etc/apt/preferences.d/nosnap.pref

    echo ""
    echo "#===================#"
    echo "Adicionando suporte a flatpak"
    echo "#===================#"
    sudo apt install flatpak -y
    sudo apt install plasma-discover-backend-flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y

    # instalando firefox flatpak
    flatpak install flathub org.mozilla.firefox -y

    echo ""
    echo "#===================#"
    echo "Instalando icones"
    echo "#===================#"
    sudo add-apt-repository ppa:papirus/papirus -y && sudo apt update && sudo apt install papirus-icon-theme papirus-folders -y && papirus-folders -C breeze --theme Papirus-Dark
   
    echo ""
    echo "#===================#"
    echo "Instalando outros apps"
    echo "#===================#"
    sudo apt install neofetch intel-gpu-tools htop scrcpy obs-studio -y

elif [[ $os = 'fedora' ]]; then
    echo ""
    echo "#===================#"
    echo "Atualizando sistema"
    echo "#===================#"
    sudo dnf update -y

    echo ""
    echo "#===================#"
    echo "Configurando rpm fusion"
    echo "#===================#"
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

    echo ""
    echo "#===================#"
    echo "Configurando video decode vaapi"
    echo "#===================#"
    sudo dnf install ffmpeg libva-utils intel-media-driver --allowerasing -y

    echo ""
    echo "#===================#"
    echo "Adicionando suporte a flatpak"
    echo "#===================#"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    echo ""
    echo "#===================#"
    echo "Instalando apps"
    echo "#===================#"
    # configurando repositório do github-desktop
    sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
    sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'

	# configurando repositório do vscode
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    
    sudo dnf check-update
    sudo dnf install neofetch intel-gpu-tools htop papirus-icon-theme steam kdenlive obs-studio telegram-desktop discord github-desktop code btop -y

    echo "#===================#"
    echo "Configurando codecs necessários"
    echo "#===================#"
	sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
    sudo dnf install lame\* --exclude=lame-devel
    sudo dnf group upgrade --with-optional Multimedia

    if [[ $variant = 'workstation' ]]; then
        echo ""
        echo "#===================#"
        echo "Instalando outros apps (workstation)"
        echo "#===================#"
        sudo dnf copr enable dusansimic/themes
        flatpak install io.bassi.Amberol com.mattjakeman.ExtensionManager org.nickvision.tubeconverter de.haeckerfelix.Fragments com.github.finefindus.eyedropper -y
        sudo dnf install gnome-tweak-tool morewaita-icon-theme file-roller -y

        echo ""
        echo "#===================#"
        echo "Configurando tema dos apps flatpak (workstation)"
        echo "#===================#"
        sudo dnf install adw-gtk3-theme -y
        flatpak install org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y
        
        sudo flatpak override --filesystem=$HOME/.themes
        sudo flatpak override --filesystem=$HOME/.icons
        sudo flatpak override --filesystem=/usr/share/themes
        sudo flatpak override --filesystem=/usr/share/icons
        sudo flatpak override --env=GTK_THEME=adw-gtk3-dark
        sudo flatpak override --env=ICON_THEME=adw-gtk3-dark
        
        # Configurando o tema de apps nativos
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
    else 
        echo ""
        echo "#===================#"
        echo "Debloat :) (kde spin)"
        echo "#===================#"
        sudo dnf remove akregator kamoso mediawriter kmag kgpg qt5-qdbusviewer kcharselect kcolorchooser dragon kmines kmahjongg kpat kruler kmousetool kmouth kolourpaint konversation krdc kfind kaddressbook kmail kontact korganizer ktnef kf5-akonadi-* dnfdragora -y

        echo ""
        echo "#===================#"
        echo "Configurando tema dos apps flatpak (kde spin)"
        echo "#===================#"
        # confirando temas 
        flatpak install org.gtk.Gtk3theme.Breeze -y
        sudo flatpak override --system --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtkrc-2.0:ro --filesystem=xdg-config/gtk-4.0:ro --filesystem=xdg-config/gtkrc:ro --env "GTK_THEME=Breeze"
    fi
fi

echo ""
echo "#===================#"
echo "Instalando apps flatpak"
echo "#===================#"
flatpak install flathub com.github.tchx84.Flatseal md.obsidian.Obsidian -y

echo ""
echo "#===================#"
echo "Agora é só reiniciar!"
echo "#===================#"
