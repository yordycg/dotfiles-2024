#!/usr/bin/env bash

# ----------------------------------------------------------------------
# MASTER INSTALLER: Arch Linux Dotfiles
# ----------------------------------------------------------------------
# Este script es el punto de entrada único para configurar una nueva
# máquina o actualizar la actual. Es idempotente (puedes correrlo
# muchas veces sin romper nada).
# ----------------------------------------------------------------------

set -e

# --- Colores ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE}      Yordy's Dotfiles Master Installer   ${NC}"
echo -e "${BLUE}==========================================${NC}"

# 1. Verificar si es Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}Error: Este script esta disenado exclusivamente para Arch Linux.${NC}"
    exit 1
fi

# Deteccion de WSL para modo minimalista
if grep -qi microsoft /proc/version; then
    echo -e "${BLUE}[INFO] WSL detectado. Activando modo MINIMAL (CLI + Kitty).${NC}"
    export MINIMAL=true
else
    export MINIMAL=false
fi

# 2. Instalar dependencias base si no existen
echo -e "${YELLOW}[INFO] Verificando dependencias base (git, curl, base-devel, openssh, inetutils, github-cli, jq)...${NC}"
sudo pacman -S --needed --noconfirm git curl base-devel openssh inetutils github-cli jq

# 3. Definir y preparar el directorio de dotfiles
WORKSPACE_DIR="$HOME/workspace"
INFRA_DIR="$WORKSPACE_DIR/infra"
DOTFILES_DIR="$INFRA_DIR/dotfiles-2024"

echo -e "${YELLOW}[INFO] Preparando estructura de directorios...${NC}"
mkdir -p "$WORKSPACE_DIR"
mkdir -p "$INFRA_DIR"
mkdir -p "$HOME/BACKUP"
mkdir -p "$WORKSPACE_DIR/personal"
mkdir -p "$WORKSPACE_DIR/ipvg"
mkdir -p "$WORKSPACE_DIR/work"

# 4. Clonar o actualizar repositorio de dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}[INFO] Clonando repositorio de dotfiles...${NC}"
    git clone https://github.com/yordycg/dotfiles-2024.git "$DOTFILES_DIR"
else
    echo -e "${GREEN}[OK] El directorio de dotfiles ya existe. Actualizando via HTTPS...${NC}"
    cd "$DOTFILES_DIR"
    # Forzamos HTTPS para la actualizacion del bootstrap para evitar problemas de SSH
    git remote set-url origin https://github.com/yordycg/dotfiles-2024.git
    git pull origin main
fi

# 5. Cambiar al directorio del repo para asegurar rutas relativas correctas
cd "$DOTFILES_DIR"

# 6. Ejecutar scripts modulares de Arch (Instalacion de paquetes y Docker)
echo -e "${YELLOW}[INFO] Ejecutando configuracion de Arch...${NC}"

# A. Instalar YAY (AUR Helper)
if [ -f "os/linux/post-install-arch/00-yay.sh" ]; then
    bash "os/linux/post-install-arch/00-yay.sh"
fi

# B. Instalar Paquetes (Oficiales y AUR) - Aquí se instala 'gh'
if [ -f "os/linux/post-install-arch/01-packages.sh" ]; then
    bash "os/linux/post-install-arch/01-packages.sh"
fi

# 7. Configuracion de SSH y GitHub (Ahora que 'gh' está instalado)
# -----------------------------------------------------------------------
# FIX: bash subshell no propaga variables de entorno al padre.
# git-gen-ssh guarda las vars del agente en ~/.ssh/agent.env.
# Las sourceamos aquí para que git clone funcione en este proceso.
# -----------------------------------------------------------------------
echo -e "${YELLOW}[INFO] Configurando SSH y GitHub...${NC}"

SSH_AGENT_ENV="$HOME/.ssh/agent.env"

if [ -f "bin/git-gen-ssh" ]; then
    if bash "bin/git-gen-ssh"; then
        # Sourcear el agente en el proceso PADRE para que git clone lo use.
        if [ -f "$SSH_AGENT_ENV" ]; then
            # shellcheck source=/dev/null
            source "$SSH_AGENT_ENV"
            echo -e "${GREEN}[OK] Agente SSH activado en el proceso actual.${NC}"
        fi
    else
        echo -e "${RED}[FAIL] Setup SSH fallo. No se puede continuar con git clone.${NC}"
        echo -e "${YELLOW}   Ejecuta manualmente: bash bin/git-gen-ssh${NC}"
        echo -e "${YELLOW}   Luego: source ~/.ssh/agent.env${NC}"
        exit 1
    fi
fi

# 8. Clonar o actualizar repositorios adicionales (Ahora con SSH listo)
echo -e "${YELLOW}[INFO] Sincronizando repositorios adicionales (obsidian, wallpapers)...${NC}"
REPOS=(
  "git@github.com:yordycg/obsidian-notes.git"
  "git@github.com:yordycg/wallpapers.git"
)

for repo_url in "${REPOS[@]}"; do
    repo_name=$(basename "$repo_url" .git)
    repo_dest="$INFRA_DIR/$repo_name"
    if [ ! -d "$repo_dest" ]; then
        echo -e "${BLUE}   - Clonando $repo_name...${NC}"
        git clone "$repo_url" "$repo_dest" || echo -e "${RED}Advertencia: No se pudo clonar $repo_name.${NC}"
    else
        echo -e "${BLUE}   - Actualizando $repo_name...${NC}"
        (cd "$repo_dest" && git pull) || true
    fi
done

# 9. Configurar Dotfiles (Symlinks, Shell, Node)
echo -e "${YELLOW}[INFO] Configurando Dotfiles (Shell, Node, Symlinks)...${NC}"
if [ -f "os/linux/post-install-arch/02-dotfiles.sh" ]; then
    bash "os/linux/post-install-arch/02-dotfiles.sh"
else
    # Fallback to direct symlinks if modular script is missing
    bash "./scripts/setup-symlinks.sh"
fi

if [ -f "os/linux/post-install-arch/03-services.sh" ]; then
    bash "os/linux/post-install-arch/03-services.sh"
fi

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}      Instalacion completada con exito!   ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "${YELLOW}Sugerencia: Reinicia tu sesion para aplicar todos los cambios.${NC}"