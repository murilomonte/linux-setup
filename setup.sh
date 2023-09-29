#!/bin/bash

. /etc/os-release
os=$ID
variant=$VARIANT_ID
color='\033[33;45;1m'
nocolor='\033[0m'

# > Atenção <
# Esse algorítmo que identifica o modelo da cpu e pc foi feito com auxilio do gpt, pois sei bem pouco de bash.
# Mesmo sendo simples e não tendo muito esforço, aprendi algumas coisas com isso. Então... Talvez seja esse o futuro?
# De fato eu não sei, mas espero que não exploda meu pc :C 

# Função para obter informações sobre a CPU
get_cpu_model() {
    lscpu | grep -E "Model name|Nome do modelo" | awk -F: '{print $2}' | xargs
}

# Função para obter informações sobre o sistema usando dmidecode
get_system_info() {
    sudo dmidecode -t system | grep -E "Product Name|Nome do produto" | awk -F: '{print $2}' | xargs
}

# Obter informações sobre a CPU e o sistema
cpu_model=$(get_cpu_model)
model=$(get_system_info)

# (debug) Exibir informações sobre a CPU e o notebook
# echo "Modelo da CPU identificado: $cpu_model"
# echo "Nome do produto identificado: $model"

# Modelo desejado
modelo_desejado="550XDA"
modelo_cpu_desejado="Intel(R) Celeron(R) 6305 @ 1.80GHz"

# Verificar se o modelo do notebook e da CPU atende aos requisitos
if [[ "$model" == *"$modelo_desejado"* && "$cpu_model" == *"$modelo_cpu_desejado"* ]]; then
    echo -e "${color}// -- Modelo do Notebook e CPU suportados. Continuando com a execução do script... -- //${nocolor}"
    if [[ $os = 'fedora' ]]; then
        echo -e "${color}// -- Atualizando sistema -- //${nocolor}"
        sudo dnf update -y

        echo -e "${color}// -- Configurando rpm fusion -- //${nocolor}"
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

        echo -e "${color}// -- Adicionando suporte ao flathub -- //${nocolor}"
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

        echo -e "${color}// -- Configurando aceleração de video via gpu -- //${nocolor}"
        sudo dnf install \
        ffmpeg-free \
        libavcodec-freeworld \
        libva-utils \
        intel-media-driver --allowerasing -y

        echo -e "${color}// -- Instalando apps (dnf) -- //${nocolor}"
        # configurando repositório do github-desktop
        sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
        sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'

        # configurando repositório do vscode
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
        
        sudo dnf check-update
        sudo dnf install \
        neofetch \
        intel-gpu-tools \
        htop \
        github-desktop \
        code -y
        
        echo -e "${color}// -- Instalando apps flatpak -- //${nocolor}"
        flatpak install flathub \
        com.github.tchx84.Flatseal \
        md.obsidian.Obsidian \
        com.discordapp.Discord \
        com.valvesoftware.Steam \
        org.telegram.desktop \
        org.kde.kdenlive \
        com.heroicgameslauncher.hgl \
        io.itch.itch \
        
        com.obsproject.Studio -y

        echo -e "${color}// -- Configurando codecs necessários -- //${nocolor}"
        sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
        sudo dnf install lame\* --exclude=lame-devel
        sudo dnf group upgrade --with-optional Multimedia

        if [[ $variant = 'workstation' ]]; then
            echo -e "${color}// -- Instalando outros apps (workstation) -- //${nocolor}"
            sudo dnf copr enable dusansimic/themes

            # dnf
            sudo dnf install \
            gnome-tweak-tool \
            morewaita-icon-theme \
            file-roller -y

            # flatpak
            flatpak install \
            io.bassi.Amberol \
            com.mattjakeman.ExtensionManager \
            org.nickvision.tubeconverter \
            de.haeckerfelix.Fragments \
            com.github.finefindus.eyedropper \
            com.raggesilver.BlackBox \
            com.usebottles.bottles \
            com.belmoussaoui.Decoder \
            app.drey.Dialect \
            org.gnome.design.Contrast \
            io.github.nate_xyz.Paleta \
            org.gnome.Quadrapassel \
            it.mijorus.smile \
            org.gnome.gitlab.YaLTeR.VideoTrimmer \
            app.drey.Warp \
            org.gnome.SoundRecorder \
            io.github.mpobaschnig.Vaults \
            it.mijorus.smile \
            hu.kramo.Cartridges -y

            echo -e "${color}// -- Configurando tema dos apps flatpak (workstation) -- //${nocolor}"
            sudo dnf install adw-gtk3-theme -y

            flatpak install org.gtk.Gtk3theme.adw-gtk3 \
            org.gtk.Gtk3theme.adw-gtk3-dark -y
            
            sudo flatpak override --filesystem=$HOME/.themes
            sudo flatpak override --filesystem=$HOME/.icons
            sudo flatpak override --filesystem=/usr/share/themes
            sudo flatpak override --filesystem=/usr/share/icons
            sudo flatpak override --env=GTK_THEME=adw-gtk3-dark
            sudo flatpak override --env=ICON_THEME=adw-gtk3-dark
            
            # Configurando o tema de apps nativos
            gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
        else 
            echo -e "${color}// -- Debloat :) (kde spin) -- //${nocolor}"
            sudo dnf remove \
            akregator \
            kamoso \
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
            flatpak install org.gtk.Gtk3theme.Breeze -y
            sudo flatpak override --system --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtkrc-2.0:ro --filesystem=xdg-config/gtk-4.0:ro --filesystem=xdg-config/gtkrc:ro --env "GTK_THEME=Breeze"
        fi
        echo -e "${color}// -- Agora é só reiniciar! -- //${nocolor}"
    else
        echo "[Erro] Somente Fedora é suportado :(" 
    fi

else
    echo -e "${color}// -- Este script requer o modelo de notebook (550XDA) e CPU específicos :( -- //${nocolor}"
    echo "O modelo atual do notebook é: $model"
    echo "O modelo atual da CPU é: $cpu_model"
    exit 1  # Saia do script com um código de erro
fi

