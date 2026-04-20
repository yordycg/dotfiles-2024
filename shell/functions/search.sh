###############################################################################
# SEARCH & EDIT UTILS
###############################################################################

# Buscar contenido con ripgrp y fzf, y abrir en vim en la línea exacta
function findedit() {
  local file=$(
    rg --line-number --no-heading --color=always --smart-case "$1" |
      fzf --ansi --preview "bat {1} --highlight-line {2}"
  )
  if [[ -n $file ]]; then
    vim "$(echo "$file" | cut -d':' -f1)" "+$(echo "$file" | cut -d':' -f2)"
  fi
}

# --- SMART PATH PICKER (zoxide + fd + fzf) ---

# Picker genérico: combina carpetas visitadas (zoxide) con carpetas reales (fd)
# Prioriza las visitadas arriba y busca en todo el HOME (profundidad 4 para velocidad)
function _smart_path_picker() {
  (
    # 1. Carpetas de zoxide (las que más usas)
    zoxide query -l
    # 2. Carpetas reales en HOME (evitando .git y ocultas innecesarias)
    fd --type d --hidden --exclude .git --max-depth 4 . "$HOME"
  ) | awk '!seen[$0]++' | fzf \
    --height 40% \
    --layout=reverse \
    --border=rounded \
    --prompt=" Seleccionar Destino: " \
    --header="[Zoxide + Home Search]" \
    --preview 'eza --icons --tree --color=always {} | head -50'
}

# Alias inteligentes que usan el picker
function cpz() {
  local dest=$(_smart_path_picker)
  if [[ -n "$dest" ]]; then
    cp -rv "$@" "$dest"
  fi
}

function mvz() {
  local dest=$(_smart_path_picker)
  if [[ -n "$dest" ]]; then
    mv -iv "$@" "$dest"
  fi
}

# Seleccionar sesión de Tmux con fzf
function tmux-sessions() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height=100% --reverse --header="Jump to session" --prompt=" Sessions: ")
  
  if [[ -n "$session" ]]; then
    tmux switch-client -t "$session"
  fi
}

# Seleccionar ventana de Tmux con fzf
function tmux-windows() {
  local window
  window=$(tmux list-windows -a -F "#S:#I: #W" | \
    fzf --height=100% --reverse --header="Jump to window" --prompt=" Windows: ")
  
  if [[ -n "$window" ]]; then
    tmux select-window -t "$(echo "$window" | cut -d: -f1,2)"
    tmux switch-client -t "$(echo "$window" | cut -d: -f1)"
  fi
}
