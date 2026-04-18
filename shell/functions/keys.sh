#!/bin/bash
###############################################################################
# UNIVERSAL KEYBINDINGS & ALIASES SEARCH (WITH DESCRIPTIONS)
###############################################################################

function keys() {
  local filter="$1"

  # Fuentes de datos
  local aliases_file="$DOTFILES/shell/aliases.sh"
  local tmux_file="$DOTFILES/os/linux/tmux/tmux.conf"
  local tmux_reset_file="$DOTFILES/os/linux/tmux/tmux.reset.conf"
  local hypr_file="$DOTFILES/os/linux/hypr/hyprland.conf"
  local functions_dir="$DOTFILES/shell/functions"

  (
    # 1. Extraer Aliases: alias name='cmd' # [cat] Descripcion
    if [[ -f "$aliases_file" ]]; then
      grep -E "^alias " "$aliases_file" | sed -E 's/alias ([^=]+)=(.+) # \[([^]]+)\] (.*)/ [\3] \1 \t= \4 (\2)/'
      # Fallback para los que no tienen descripción aún
      grep -E "^alias " "$aliases_file" | grep -v "\] " | sed -E 's/alias ([^=]+)=(.+) # \[([^]]+)\]/ [\3] \1 \t= \2/'
    fi

    # 2. Extraer Binds de Tmux (con soporte para comentarios al final)
    for f in "$tmux_file" "$tmux_reset_file"; do
      if [[ -f "$f" ]]; then
        grep -E "^bind " "$f" | sed -E 's/bind (-r |-n | )*([^ ]+) ([^#]+)(# (.*))?/ [tmux] \2 \t= \5 (\3)/'
      fi
    done

    # 3. Extraer Binds de Hyprland
    if [[ -f "$hypr_file" ]]; then
       grep -E "^bind" "$hypr_file" | sed -E 's/bind[dmeilre]* = ([^,]*), ([^,]*), ([^,]*),? ?([^#]*)(# (.*))?/ [hypr] \1+\2 \t= \6 (\3 \4)/'
    fi

    # 4. Listar funciones con descripción (busca comentario arriba)
    if [[ -d "$functions_dir" ]]; then
      find "$functions_dir" -maxdepth 1 -name "*.sh" -exec awk '
        /^# / { last_comment = substr($0, 3) }
        /^function / { 
          split($2, a, "("); 
          printf " [%s] %s \t= %s (function)\n", FILENAME, a[1], last_comment;
          last_comment = ""
        }
        /^[a-zA-Z0-9_-]+\(\)/ {
          split($1, a, "(");
          printf " [%s] %s \t= %s (function)\n", FILENAME, a[1], last_comment;
          last_comment = ""
        }
      ' {} + | sed "s|\[$functions_dir/||; s|\.sh\]|]|"
    fi
  ) | grep -i "${filter:-.}" | column -t -s $'\t' | fzf \
    --height 60% \
    --layout=reverse \
    --border \
    --prompt="  Comandos: " \
    --header "Busca por nombre, categoría o descripción. Formato: [Cat] Comando = Descripción (Origen)" \
    --preview "echo {}" \
    --preview-window up:1 \
    --ansi
}
