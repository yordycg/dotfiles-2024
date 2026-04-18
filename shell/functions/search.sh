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

# --- TMUX SEARCH FUNCTIONS ---

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
