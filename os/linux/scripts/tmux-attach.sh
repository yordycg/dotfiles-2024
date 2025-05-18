#!/bin/bash
# Gestiona la conexion o creacion automatica de sesiones en Tmux
# Debe ser enlazado en el .zshrc

# Verificar si tmux esta intalado...
if which tmux >/dev/null 2>&1; then
  # Verificar que el entorno sea adecuado para iniciar tmux.
  if [[ -z "$TMUX" &&
      $TERM != "screen-256color" &&
      $TERM != "screen" &&
      -z "$VSCODE_INJECTION" &&
      -z "$INSIDE_EMACS" &&
      -z "$EMACS" &&
      -z "$VIM" &&
      -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then

      # Lista de sesiones a crear.
      # desired_sessions=("dotfiles" "cpp-workspace" "projects" "dsa-workspace" "obsidian-notes" "portfolio")
      # Mapear sesiones con su directorio base...
      declare -A session_paths=(
        ["dotfiles"]="${DOTFILES:-$HOME/workspace/repos/dotfiles-2024}"
        ["learn-cpp"]="${CPP_PATH:-/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/02 Cpp}"
        ["learn-dsa"]="${DSA_PATH:-/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/04 DataStructure-Algorithms}"
        ["projects"]="${PROJECTS_PATH:-$HOME/workspace/dev/projects}"
        ["obsidian-notes"]="${OBSIDIAN:-$HOME/workspace/repos/obsidian-notes}"
      )

      # Crear sesiones si no existen.
      for session_name in "${!session_paths[@]}"; do
        session_path="${session_paths[$session_name]}"
        if ! tmux has-session -t "$session_name" 2>/dev/null; then
          tmux new-session -d -s "$session_name" -c "$session_path"
          # NOTE: aqui en adelante irian las configuraciones para cada session
        fi
      done

      # Finalmente, entrar a 'default'
      tmux attach -t default || tmux new -s default

      exit
    fi
fi
