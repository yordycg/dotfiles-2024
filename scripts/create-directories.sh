#!/usr/bin/bash
# Autor: Yordy Carmona
# Crea la estructura de directorios base para el espacio de trabajo.

set -ueo pipefail # fail on error and report it, debug all lines

# Definición de directorios
WORKSPACE_DIR="$HOME/workspace"
BACK_DIR="$HOME/BACKUP"
PERSONAL_PROJECT_DIR="$WORKSPACE_DIR/personal-projects"
ENG_COMPUTER_DIR="$WORKSPACE_DIR/computer-engineering"
REPO_DIR="$WORKSPACE_DIR/repos"

# Lista de directorios a crear
DIRECTORIES=(
  "$WORKSPACE_DIR"
  "$BACK_DIR"
  "$PERSONAL_PROJECT_DIR"
  "$ENG_COMPUTER_DIR"
  "$REPO_DIR"
)

echo "Creando directorios base necesarios del espacio de trabajo..."
for dir in "${DIRECTORIES[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "Creando directorio: '$dir'..."
    if mkdir -p "$dir"; then
      echo "Directorio '$dir' creado exitosamente."
    else
      echo "Error: Falló la creación del directorio '$dir'." >&2
      exit 1 # Sale si la creación del directorio falla
    fi
  else
    echo "El directorio '$dir' ya existe."
  fi
done

echo "Estructura de directorios base verificada/creada."
