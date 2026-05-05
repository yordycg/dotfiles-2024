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
echo -e "${BLUE}   🚀 Yordy's Dotfiles Master Installer   ${NC}"
echo -e "${BLUE}==========================================${NC}"

# 1. Verificar si es Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo -e "${RED}❌ Error: Este script está diseñado exclusivamente para Arch Linux.${NC}"
    exit 1
fi

# 2. Instalar dependencias base si no existen
echo -e "${YELLOW}🔍 Verificando dependencias base (git, curl, base-devel, openssh, inetutils)...${NC}"
sudo pacman -S --needed --noconfirm git curl base-devel openssh inetutils

# 3. Definir y preparar el directorio de dotfiles
WORKSPACE_DIR="$HOME/workspace"
INFRA_DIR="$WORKSPACE_DIR/infra"
DOTFILES_DIR="$INFRA_DIR/dotfiles-2024"

echo -e "${YELLOW}📂 Preparando estructura de directorios...${NC}"
mkdir -p "$WORKSPACE_DIR"
mkdir -p "$INFRA_DIR"
mkdir -p "$HOME/BACKUP"
mkdir -p "$WORKSPACE_DIR/personal"
mkdir -p "$WORKSPACE_DIR/ipvg"
mkdir -p "$WORKSPACE_DIR/work"

# 4. Clonar o actualizar repositorio de dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}📥 Clonando repositorio de dotfiles...${NC}"
    git clone https://github.com/yordycg/dotfiles-2024.git "$DOTFILES_DIR"
else
    echo -e "${GREEN}📂 El directorio de dotfiles ya existe. Actualizando...${NC}"
    cd "$DOTFILES_DIR" && git pull origin main
fi

# 5. Cambiar al directorio del repo para asegurar rutas relativas correctas
cd "$DOTFILES_DIR"

# 6. Ejecutar scripts modulares de Arch (Instalación de paquetes y Docker)
echo -e "${YELLOW}🏗️  Ejecutando configuración de Arch...${NC}"

# A. Instalar YAY (AUR Helper)
if [ -f "os/linux/post-install-arch/00-yay.sh" ]; then
    bash "os/linux/post-install-arch/00-yay.sh"
fi

# B. Instalar Paquetes (Oficiales y AUR) - Aquí se instala 'gh'
if [ -f "os/linux/post-install-arch/01-packages.sh" ]; then
    bash "os/linux/post-install-arch/01-packages.sh"
fi

# 7. Configuración de SSH y GitHub (Ahora que 'gh' está instalado)
echo -e "${YELLOW}🔑 Configurando SSH y GitHub...${NC}"
if [ -f "bin/git-gen-ssh" ]; then
    bash "bin/git-gen-ssh" || echo -e "${RED}⚠️ No se pudo configurar SSH. Es posible que necesites login manual de 'gh'.${NC}"
fi

# 8. Clonar o actualizar repositorios adicionales (Ahora con SSH listo)
echo -e "${YELLOW}🔄 Sincronizando repositorios adicionales (obsidian, wallpapers)...${NC}"
REPOS=(
  "git@github.com:yordycg/obsidian-notes.git"
  "git@github.com:yordycg/wallpapers.git"
)

for repo_url in "${REPOS[@]}"; do
    repo_name=$(basename "$repo_url" .git)
    repo_dest="$INFRA_DIR/$repo_name"
    if [ ! -d "$repo_dest" ]; then
        echo -e "${BLUE}   - Clonando $repo_name...${NC}"
        git clone "$repo_url" "$repo_dest" || echo -e "${RED}⚠️ No se pudo clonar $repo_name.${NC}"
    else
        echo -e "${BLUE}   - Actualizando $repo_name...${NC}"
        (cd "$repo_dest" && git pull) || true
    fi
done

# 9. Configurar Symlinks y Servicios
echo -e "${YELLOW}🔗 Finalizando configuración (Symlinks y Servicios)...${NC}"
bash "./scripts/setup-symlinks.sh"

if [ -f "os/linux/post-install-arch/03-services.sh" ]; then
    bash "os/linux/post-install-arch/03-services.sh"
fi

# D. Instalar Docker
if [ -f "install/install-docker.sh" ]; then
    bash "install/install-docker.sh"
fi

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}   ✨ Instalación completada con éxito!   ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "${YELLOW}💡 Sugerencia: Reinicia tu sesión para aplicar todos los cambios.${NC}"
