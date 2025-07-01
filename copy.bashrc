## Necessários para o flutter
export PATH="$PATH:$HOME/development/flutter/bin"
export PATH="$PATH:$HOME/Android/Sdk/cmdline-tools/latest/bin/"
export PATH="$PATH":"$HOME/.pub-cache/bin"

## Aliases
alias update='sudo dnf update && flatpak update'
alias neofetch='fastfetch --localip-show-ipv4 false'
alias steamcmd='flatpak run --command=steamcmd com.valvesoftware.Steam'
alias cl='clear'
alias flutter-reset='flutter clean && flutter pub get'
alias mvcf='mkdir src && cd src && mkdir model view controller data widgets'
alias mvce='mkdir src && cd src && mkdir model view controller public routes'