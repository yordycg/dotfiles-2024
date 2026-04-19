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

# "tcl": Limpieza interactiva de sesiones de Tmux inactivas.
# Uso: tcl (abre un selector de fzf para matar sesiones)
function tcl() {
  local sessions
  # Obtenemos las sesiones con su nombre y última vez que fueron conectadas.
  sessions=$(tmux list-sessions -F "#{session_name} | Last: #{session_last_attached}" 2>/dev/null)

  if [[ -z "$sessions" ]]; then
    echo "No hay sesiones de Tmux activas."
    return
  fi

  # Usamos fzf para seleccionar una o más sesiones y las cerramos.
  echo "$sessions" | fzf --multi --header="Selecciona sesiones para CERRAR (TAB para selección múltiple):" --prompt="Kill session: " \
    | cut -d' ' -f1 | xargs -r -n 1 tmux kill-session -t
}

# "tmux_bootstrap": Asegura que las sesiones core estén creadas.
function tmux_bootstrap() {
  # Si tmux está instalado, crear sesión dotfiles en segundo plano si no existe.
  if command -v tmux &>/dev/null; then
    if ! tmux has-session -t "dotfiles" 2>/dev/null; then
      tmux new-session -d -s "dotfiles" -c "$DOTFILES"
    fi
  fi
}

# Ejecutar el bootstrap al cargar (solo si no estamos ya en tmux o en una tty sin entorno)
if [[ -z "$TMUX" && "$TERM" != "linux" ]]; then
  tmux_bootstrap
fi

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
