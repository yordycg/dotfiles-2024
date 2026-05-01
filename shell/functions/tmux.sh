###############################################################################
# TMUX UTILS - Optimized & Professional
###############################################################################

# "work": Entrar o crear una sesión de Tmux basada en la carpeta actual.
# Uso: work [session_name]
function work() {
  local session_name
  # Si se pasa un argumento, usarlo como nombre. Si no, usar el nombre de la carpeta.
  session_name="${1:-$(basename "$PWD" | sed -e 's/\.//g')}"

  if [[ -z "$TMUX" ]]; then
    tmux new-session -A -s "$session_name" -c "$PWD"
  else
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
      tmux new-session -d -s "$session_name" -c "$PWD"
    fi
    tmux switch-client -t "$session_name"
  fi
}

# "tcl": Limpieza interactiva con preview de ventanas.
function tcl() {
  local sessions
  sessions=$(tmux list-sessions -F "#{session_name} | #{session_windows} windows | Last: #{session_last_attached}" 2>/dev/null)

  if [[ -z "$sessions" ]]; then
    echo "No hay sesiones activas."
    return
  fi

  # Seleccionamos con preview de las ventanas que tiene la sesión
  echo "$sessions" | fzf --multi \
    --header="[TAB] para selección múltiple | [ENTER] para CERRAR" \
    --prompt="Kill session: " \
    --preview 'tmux list-windows -t $(echo {} | cut -d" " -f1) -F "#I: #W (#P panes)"' \
    | cut -d' ' -f1 | xargs -r -n 1 tmux kill-session -t
}

# "jump": Selector rápido de sesiones activas (Estilo Popup).
function jump() {
  local session
  local preview_cmd='tmux list-windows -t {} -F "#I: #W (#P panes)"'

  if [[ -n "$TMUX" ]]; then
    # Dentro de Tmux: Popup nativo centrado
    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | \
      fzf-tmux -p 65%,50% \
        --reverse \
        --border \
        --prompt="󱄲 Jump: " \
        --header="Sesiones activas en Tmux" \
        --preview "$preview_cmd" \
        --preview-window=right:60%:wrap)
  else
    # Fuera de Tmux: Simular popup con márgenes
    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | \
      fzf --margin=15%,20% \
        --reverse \
        --border \
        --prompt="󱄲 Jump: " \
        --header="Sesiones activas en Tmux" \
        --preview "$preview_cmd" \
        --preview-window=right:60%:wrap)
  fi

  if [[ -n "$session" ]]; then
    if [[ -z "$TMUX" ]]; then
      tmux attach-session -t "$session"
    else
      tmux switch-client -t "$session"
    fi
  fi
}

# "tmux_bootstrap": Sesiones core.
function tmux_bootstrap() {
  if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
    if ! tmux has-session -t "dotfiles" 2>/dev/null; then
      tmux new-session -d -s "dotfiles" -c "$DOTFILES"
    fi
  fi
}

# Solo ejecutar el bootstrap en shells interactivas y no dentro de otro tmux.
# Desactivado para evitar duplicidad; usar 'work' manualmente.
# [[ $- == *i* && -z "$TMUX" ]] && tmux_bootstrap
