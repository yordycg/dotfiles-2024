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
echo -e "${YELLOW}🔍 Verificando dependencias base (git, curl, base-devel)...${NC}"
sudo pacman -S --needed --noconfirm git curl base-devel

# 3. Definir y preparar el directorio de dotfiles
WORKSPACE_DIR="$HOME/workspace"
REPO_DIR="$WORKSPACE_DIR/repos"
DOTFILES_DIR="$REPO_DIR/dotfiles-2024"

echo -e "${YELLOW}📂 Preparando estructura de directorios...${NC}"
mkdir -p "$WORKSPACE_DIR"
mkdir -p "$REPO_DIR"
mkdir -p "$HOME/BACKUP"
mkdir -p "$WORKSPACE_DIR/personal-projects"
mkdir -p "$WORKSPACE_DIR/computer-engineering"

# 4. Clonar o actualizar repositorio de dotfiles
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}📥 Clonando repositorio de dotfiles...${NC}"
    git clone https://github.com/yordycg/dotfiles-2024.git "$DOTFILES_DIR"
else
    echo -e "${GREEN}📂 El directorio de dotfiles ya existe. Actualizando...${NC}"
    cd "$DOTFILES_DIR" && git pull origin main
fi

# 5. Clonar o actualizar repositorios adicionales
echo -e "${YELLOW}🔄 Sincronizando repositorios adicionales (obsidian, wallpapers)...${NC}"
REPOS=(
  "git@github.com:yordycg/obsidian-notes.git"
  "git@github.com:yordycg/wallpapers.git"
)

for repo_url in "${REPOS[@]}"; do
    repo_name=$(basename "$repo_url" .git)
    repo_dest="$REPO_DIR/$repo_name"
    if [ ! -d "$repo_dest" ]; then
        echo -e "${BLUE}   - Clonando $repo_name...${NC}"
        git clone "$repo_url" "$repo_dest" || echo -e "${RED}⚠️ No se pudo clonar $repo_name (¿SSH configurado?)${NC}"
    else
        echo -e "${BLUE}   - Actualizando $repo_name...${NC}"
        (cd "$repo_dest" && git pull) || true
    fi
done

# 6. Cambiar al directorio del repo para asegurar rutas relativas correctas
cd "$DOTFILES_DIR"

# 5. Ejecutar la cadena de scripts de instalación
# Aseguramos que tengan permisos
chmod +x setup-symlinks.sh
chmod +x os/linux/post-install-arch/*.sh

# A. Instalar YAY (AUR Helper)
if [ -f "os/linux/post-install-arch/00-yay.sh" ]; then
    echo -e "${YELLOW}🏗️  Configurando YAY...${NC}"
    bash "os/linux/post-install-arch/00-yay.sh"
fi

# B. Instalar Paquetes (Oficiales y AUR)
if [ -f "os/linux/post-install-arch/01-packages.sh" ]; then
    echo -e "${YELLOW}📦 Instalando paquetes...${NC}"
    bash "os/linux/post-install-arch/01-packages.sh"
fi

# C. Configurar Symlinks
echo -e "${YELLOW}🔗 Configurando enlaces simbólicos...${NC}"
bash "./scripts/setup-symlinks.sh"

# D. Configurar Servicios y SDDM
if [ -f "os/linux/post-install-arch/03-services.sh" ]; then
    echo -e "${YELLOW}⚙️  Configurando servicios de sistema...${NC}"
    bash "os/linux/post-install-arch/03-services.sh"
fi

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}   ✨ Instalación completada con éxito!   ${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "${YELLOW}💡 Sugerencia: Reinicia tu sesión para aplicar todos los cambios.${NC}"
