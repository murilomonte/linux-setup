#!/bin/bash

## Flutter
export PATH="$PATH:$HOME/development/flutter/bin"
export PATH="$PATH:$HOME/Android/Sdk/cmdline-tools/latest/bin/"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export CHROME_EXECUTABLE="/var/lib/flatpak/app/com.google.Chrome/current/active/export/bin/com.google.Chrome"; 

## Other
alias update='sudo dnf update && flatpak update'
alias neofetch='fastfetch --localip-show-ipv4 false'
alias steamcmd='flatpak run --command=steamcmd com.valvesoftware.Steam'
alias up='update'
alias cl='clear'
alias flutter-reset='flutter clean && flutter pub get'
alias mvcf='mkdir src && cd src && mkdir model view controller data widgets'
alias mvce='mkdir src && cd src && mkdir model view controller public routes'
alias runserver='python manage.py runserver'
alias createapp='python manage.py createapp'
alias createvite='npm create vite@latest .'
alias vitecreate='createvite'