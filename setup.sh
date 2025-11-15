#!/bin/bash

. /etc/os-release
os=$ID

source "${SCRIPT_DIR}/global/colors.sh"

echo -e "${COLOR}// -- Carregando modulos -- //${NOCOLOR}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
for module in "${SCRIPT_DIR}/modules"/*/*.sh; do
    if [ -f "$module" ]; then
        echo "  → Carregando: $(basename "$module")"
        source "$module"
    fi
done

if [[ $os = 'fedora' ]]; then
    # Atulizando sistema 
    update_system
    
    # Adicionando RPM fusion
    add_rpm_fusion

    # Adicionando vaapi
    add_hardware_decode

    # Adicionando apps dnf
    add_dnf_apps

    # Adicionando apps flatpak
    add_flatpak_apps
    
    # Configurando persmissoes flatpak
    flatpak_permissions

    # Configurando codecs
    add_codecs

    # Configurando alias
    add_aliases

    # Configurando python
    python_config

    # Cofigurando flutter
    flutter_config

    echo -e "${COLOR}// -- Agora é só reiniciar! -- //${NOCOLOR}"
else
    echo -e "${COLOR}// -- [Erro] Esse script só funciona no Fedora :( -- //${NOCOLOR}"
fi
