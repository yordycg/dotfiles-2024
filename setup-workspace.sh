#!/bin/bash
# Script principal para configurar el espacio de trabajo para sistemas Unix-like (Linux/macOS).
# 1. Crea la estructura de directorios base (~/workspace, etc.).
# 2. Clona los repositorios principales en ~/workspace/repos.
# 3. Ejecuta la post-instalación de Arch Linux desde el repositorio clonado.

set -e # Salir inmediatamente si un comando falla.

# Encontrar el directorio donde se encuentra el script para poder llamar a los otros de forma fiable.
# Nota: Esto es principalmente útil si el script se ejecuta desde una ubicación local.
# Cuando se ejecuta a través de curl, SCRIPT_DIR podría no ser relevante.
SCRIPT_DIR=$(dirname "$(readlink -f "$0" || realpath "$0")")

echo "--- Iniciando configuración del espacio de trabajo ---"
echo

# Si el script se ejecuta localmente, los scripts de componentes estarán en SCRIPT_DIR.
# Si se ejecuta con curl, los componentes no existen, por lo que el script DEBE ser autocontenido
# O tener la lógica aquí. Por simplicidad del flujo con curl, vamos a ejecutar los
# scripts que ya creamos en el repo.

echo "PASO 1: Creando estructura de directorios..."
# La lógica de create-directories.sh se trae aquí para que curl | bash funcione.
WORKSPACE_DIR="$HOME/workspace"
REPO_DIR="$WORKSPACE_DIR/repos"
DIRECTORIES=(
  "$WORKSPACE_DIR"
  "$HOME/BACKUP"
  "$WORKSPACE_DIR/personal-projects"
  "$WORKSPACE_DIR/computer-engineering"
  "$REPO_DIR"
)
for dir in "${DIRECTORIES[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
  fi
done
echo "PASO 1: ¡Completado!"
echo

echo "PASO 2: Clonando repositorios..."
# La lógica de clone-repos.sh se trae aquí.
REPOSITORIES_TO_CLONE=(
  "https://github.com/yordycg/dotfiles-2024.git"
  "https://github.com/yordycg/obsidian-notes.git"
  "https://github.com/yordycg/wallpapers.git"
)
for repo_url in "${REPOSITORIES_TO_CLONE[@]}"; do
  repo_name=$(basename "$repo_url" .git)
  repo_dest="$REPO_DIR/$repo_name"
  if [ ! -d "$repo_dest" ]; then
    git clone "$repo_url" "$repo_dest"
  else
    echo "El directorio '$repo_dest' ya existe. Omitiendo clonación."
  fi
done
echo "PASO 2: ¡Completado!"
echo

echo "--- Configuración del espacio de trabajo finalizada con éxito ---"
echo

# --- Continuación automática: Instalación del sistema Arch Linux ---
echo "PASO 3: Iniciando la instalación del sistema desde los dotfiles clonados..."
DOTFILES_DIR="$HOME/workspace/repos/dotfiles-2024"

if [ -f "$DOTFILES_DIR/os/linux/post-install-arch/install.sh" ]; then
  # Pasamos al directorio de dotfiles y ejecutamos la instalación
  cd "$DOTFILES_DIR"
  echo "Cambiado al directorio: $(pwd)"
  echo "Ejecutando script de post-instalación de Arch..."
  bash os/linux/post-install-arch/install.sh
else
  echo "Error: No se encontró el script de instalación de Arch en '$DOTFILES_DIR/os/linux/post-install-arch/install.sh'." >&2
  exit 1
fi

echo
echo "--- Proceso de instalación de Arch finalizado. ---"
echo "--- ¡Configuración completa! ---"
