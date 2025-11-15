#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function add_aliases() {
    echo -e "${COLOR}// -- Adicionando custom aliases -- //${NOCOLOR}"
    
    ALIAS_BLOCK='
# external alias file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
'
    # Refer alias file in .bashrc
    if ! grep -Fxq "# external alias file" ~/.bashrc; then
        printf "\n%s\n" "$ALIAS_BLOCK" >> ~/.bashrc
    fi

    # Copy alias file to home
    if [ ! -f "$HOME/.bash_aliases" ]; then
        cp "$(dirname "$0")/.bash_aliases" "$HOME/.bash_aliases"
    fi
}
