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

# --- SMART PATH PICKER (zoxide + dynamic fd + fzf) ---

# Picker inteligente con visualización optimizada para rutas largas
function _smart_path_picker() {
  local INITIAL_QUERY="$1"
  local selection
  
  # Comando para formatear la salida: Home -> ~, Gris para ruta, Azul para carpeta final
  # Usamos una variable para evitar el infierno de las comillas en los binds de FZF
  local fmt_cmd='sed "s|$HOME|~|" | awk -F/ "{last=\$NF; path=\"\"; for(i=1; i<NF; i++) path=path \$i \"/\"; print \"\033[38;5;244m\" path \"\033[1;34m\" last \"\033[0m\"}"'

  selection=$( (zoxide query -l; fd --type d --max-depth 2 . "$HOME") | \
    awk '!seen[$0]++' | \
    eval "$fmt_cmd" | fzf \
    --ansi \
    --height 60% \
    --layout=reverse \
    --border=rounded \
    --prompt=" Destino: " \
    --query="$INITIAL_QUERY" \
    --keep-right \
    --tiebreak=end,length \
    --header="[ENTER] Confirmar | [ALT-D] Búsqueda profunda | [ALT-Z] Zoxide" \
    --bind "alt-d:reload(fd --type d --hidden --exclude .git . $HOME | $fmt_cmd)" \
    --bind "alt-z:reload(zoxide query -l | $fmt_cmd)" \
    --preview 'p=$(echo {} | sed "s/\x1b\[[0-9;]*m//g"); p=${p/\~/$HOME}; eza --icons --tree --level=2 --color=always "$p" | head -50' \
    --preview-window="right:50%:wrap" )

  # Devolvemos la ruta limpia (sin códigos de color y restaurando ~ a $HOME)
  if [[ -n "$selection" ]]; then
    local clean_path=$(echo "$selection" | sed 's/\x1b\[[0-9;]*m//g')
    echo "${clean_path/\~/$HOME}"
  fi
}

# Alias inteligentes que usan el picker
# Soporta argumentos opcionales para filtrar desde el inicio: cpz archivo "termino"
function cpz() {
  if [[ $# -lt 1 ]]; then
    echo "Uso: cpz <archivo> [termino_busqueda]"
    return 1
  fi
  
  local file="$1"
  shift # Sacamos el archivo de los argumentos
  local query="$*" # El resto es el término de búsqueda inicial
  
  local dest=$(_smart_path_picker "$query")
  if [[ -n "$dest" ]]; then
    cp -rv "$file" "$dest"
  fi
}

function mvz() {
  if [[ $# -lt 1 ]]; then
    echo "Uso: mvz <archivo> [termino_busqueda]"
    return 1
  fi

  local file="$1"
  shift
  local query="$*"
  
  local dest=$(_smart_path_picker "$query")
  if [[ -n "$dest" ]]; then
    mv -iv "$file" "$dest"
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

# [fzf] Interactive Process Killer (fkill)
function fkill() {
    local pid
    if [[ "$UID" != "0" ]]; then
        pid=$(ps -u "$USER" -o pid,ppid,comm,pcpu,pmem --sort=-pcpu | fzf --header "󰆙 Kill Process (User)" --header-lines=1 --multi | awk '{print $1}')
    else
        pid=$(ps -ef | fzf --header "󰆙 Kill Process (System)" --header-lines=1 --multi | awk '{print $2}')
    fi

    if [[ -n "$pid" ]]; then
        echo "$pid" | xargs kill -9
        echo -e "\033[1;32m✅ Proceso(s) $pid terminado(s).\033[0m"
    fi
}

# [fzf] Interactive Systemd Service Manager (fsvc)
function fsvc() {
    local service
    service=$(systemctl list-unit-files --type=service --state=enabled,disabled | fzf --header "⚙️ Systemd Services" --header-lines=1 | awk '{print $1}')
    
    [[ -z "$service" ]] && return 0

    local action
    action=$(echo -e "status\nstart\nstop\nrestart\nenable\ndisable" | fzf --header "󰑮 Action for $service")

    [[ -z "$action" ]] && return 0

    echo -e "\033[1;34m执行: sudo systemctl $action $service\033[0m"
    sudo systemctl "$action" "$service"
}

# [fzf] Interactive Env Variable Inspector (fenv)
function fenv() {
    local var
    var=$(env | fzf --header "󰈔 Environment Variables" | cut -d= -f1)
    
    if [[ -n "$var" ]]; then
        local val=${(P)var}
        echo -e "\033[1;34m$var=\033[0m$val"
        echo -n "$val" | wl-copy
        echo -e "\033[1;32m📋 Valor copiado al portapapeles.\033[0m"
    fi
}
