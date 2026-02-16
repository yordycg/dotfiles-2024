#!/usr/bin/bash
# Autor: Yordy Carmona
# Clona los repositorios base en el directorio de repos.

set -ueo pipefail # fail on error and report it, debug all lines

# Definición de directorios y repositorios
WORKSPACE_DIR="$HOME/workspace"
REPO_DIR="$WORKSPACE_DIR/repos"

REPOSITORIES_TO_CLONE=(
  "https://github.com/yordycg/dotfiles-2024.git"  # Dotfiles
  "https://github.com/yordycg/obsidian-notes.git" # Obsidian notes
  "https://github.com/yordycg/wallpapers.git"     # Wallpapers
)

echo "Iniciando clonación de repositorios en '$REPO_DIR'..."

# Asegurarse de que el directorio base de repositorios exista
if [ ! -d "$REPO_DIR" ]; then
  echo "Error: El directorio de repositorios '$REPO_DIR' no existe." >&2
  echo "Por favor, ejecuta el script 'create-directories.sh' primero." >&2
  exit 1
fi

if [ ${#REPOSITORIES_TO_CLONE[@]} -eq 0 ]; then
  echo "No hay repositorios definidos para clonar."
  exit 0
fi

for repo_url in "${REPOSITORIES_TO_CLONE[@]}"; do
  repo_name=$(basename "$repo_url" .git)
  repo_dest="$REPO_DIR/$repo_name"

  echo "Procesando repositorio: $repo_url"

  # Comprobar si el directorio de destino ya existe
  if [ -d "$repo_dest" ]; then
    echo "El directorio '$repo_dest' ya existe. Omitiendo clonación."
  else
    echo "Clonando '$repo_url' en '$repo_dest'..."
    if git clone "$repo_url" "$repo_dest"; then
      echo "Clonación de '$repo_url' exitosa."
    else
      echo "Error: Falló la clonación de '$repo_url'. Continúando con el siguiente..." >&2
    fi
  fi
done

echo "Proceso de clonación de repositorios completado."
