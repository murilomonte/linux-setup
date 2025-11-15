#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/../../global/colors.sh"

function python_config() {
    echo -e "${COLOR}// -- Configurando UV (python) -- //${NOCOLOR}"
    curl -LsSf https://astral.sh/uv/install.sh | sh
}


