#!/usr/bin/bash
# Autor: Yordy Carmona
# Crea la estructura de directorios base para el espacio de trabajo.

set -ueo pipefail # fail on error and report it, debug all lines

# Definición de directorios
WORKSPACE_DIR="$HOME/workspace"
BACK_DIR="$HOME/BACKUP"
REPO_DIR="$WORKSPACE_DIR/repos"
PERSONAL_DIR="$WORKSPACE_DIR/personal"
UNIVERSITY_DIR="$WORKSPACE_DIR/university/year_3/semester_5"

# Lista de directorios a crear
DIRECTORIES=(
  "$WORKSPACE_DIR"
  "$BACK_DIR"
  "$REPO_DIR"
  "$PERSONAL_DIR"
  "$UNIVERSITY_DIR"
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
