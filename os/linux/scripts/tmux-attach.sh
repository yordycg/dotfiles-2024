#!/bin/bash
# Auto gestión de sesiones tmux
# - Sesiones persistentes por proyecto
# - "default" como punto de entrada

# Verificar si tmux está instalado
if which tmux >/dev/null 2>&1; then

  # Load environment variables if not present
  if [[ -z "$DOTFILES" ]]; then
    export DOTFILES="$HOME/workspace/repos/dotfiles-2024"
  fi
  [[ -s "$DOTFILES/shell/exports.sh" ]] && source "$DOTFILES/shell/exports.sh"

  # Evitar ejecutar dentro de tmux o entornos especiales
  if [[ -z "$TMUX" &&
        $TERM != "screen-256color" &&
        $TERM != "screen" &&
        -z "$VSCODE_INJECTION" &&
        -z "$INSIDE_EMACS" &&
        -z "$EMACS" &&
        -z "$VIM" &&
        -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then

      # Sesiones persistentes (entornos de trabajo)
      declare -A session_paths=(
        ["dotfiles"]="${DOTFILES:-$HOME/workspace/repos/dotfiles-2024}"
        ["learn-cpp"]="${CPP_PATH:-/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/02 Cpp}"
        ["learn-dsa"]="${DSA_PATH:-/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/04 DataStructure-Algorithms}"
        ["projects"]="${PROJECTS_PATH:-$HOME/workspace/dev/projects}"
        ["obsidian-notes"]="${OBSIDIAN:-$HOME/workspace/repos/obsidian-notes}"
      )

      # Crear sesiones en background si no existen
      for session_name in "${!session_paths[@]}"; do
        session_path="${session_paths[$session_name]}"

        if ! tmux has-session -t "$session_name" 2>/dev/null; then
          tmux new-session -d -s "$session_name" -c "$session_path"
        fi
      done

    # Sesión default (entrada principal)
    if ! tmux has-session -t default 2>/dev/null; then
      tmux new-session -d -s default -c "$HOME" \; \
        rename-window "main"
    fi

    # Conectarse con sesión propia e independiente (Opción B)
    SESSION_ID="term-$$"
    exec tmux new-session -s "$SESSION_ID" -c "$HOME"

    fi
    fi
