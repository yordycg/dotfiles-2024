###############################################################################
# TMUX UTILS
###############################################################################

# "work": Entrar en una sesión de Tmux basada en el nombre de la carpeta actual.
# Uso: cd /path/to/project && work
function work() {
  local session_name
  session_name=$(basename "$PWD" | sed -e 's/\.//g')

  # Si no hay sesión de tmux activa, iniciarla o unirse.
  if [[ -z "$TMUX" ]]; then
    tmux new-session -A -s "$session_name" -c "$PWD"
  else
    # Si ya estamos dentro de tmux, crear la sesión si no existe y cambiar.
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
      tmux new-session -d -s "$session_name" -c "$PWD"
    fi
    tmux switch-client -t "$session_name"
  fi
}

# "jump": Buscador fuzzy para saltar entre proyectos y materias.
# Uso: jump (luego escribe el nombre de la carpeta)
function jump() {
  local target
  # Buscamos en repos y en la estructura de la universidad.
  target=$(find ~/workspace/repos ~/workspace/university -maxdepth 4 -mindepth 1 -type d \
    | fzf --height 40% --layout=reverse --border --prompt="Jump to: ")

  if [[ -n "$target" ]]; then
    cd "$target" || return
    work
  fi
}
