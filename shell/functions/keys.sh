#!/bin/bash
###############################################################################
# UNIVERSAL CHEATSHEET SEARCH (POPUP VERSION)
###############################################################################

function keys() {
    local cheatsheet="$DOTFILES/shell/cheatsheet.md"
    local query="$1"
    
    if [[ ! -f "$cheatsheet" ]]; then
        echo "Error: No se encontró el archivo cheatsheet en $cheatsheet"
        return 1
    fi

    # Opciones estéticas unificadas
    local fzf_color="header:bold:blue,info:green,pointer:red,border:blue"
    local fzf_header="Prefix Tmux: CTRL+SPACE | Prefix Hypr: SUPER (WIN)"

    # Opciones comunes para mantener la consistencia
    local common_opts=(
        --reverse
        --border=rounded
        --query="$query"
        --prompt="  Atajos: "
        --header="$fzf_header"
        --color="$fzf_color"
    )

    if [[ -n "$TMUX" ]]; then
        # Dentro de Tmux: Popup real (80% x 70%)
        grep "^\[" "$cheatsheet" | \
            column -t -s "|" | \
            fzf-tmux -p 80%,70% -- "${common_opts[@]}"
    else
        # Fuera de Tmux: Simular popup sin limpiar la pantalla (permite ver el fondo)
        # Altura del 70% y margen lateral del 10% para centrarlo horizontalmente
        grep "^\[" "$cheatsheet" | \
            column -t -s "|" | \
            fzf "${common_opts[@]}" \
                --height=70% \
                --margin="1,10%"
    fi
}
