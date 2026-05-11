#!/bin/bash
# ----------------------------------------------------------------------
# MASTER SYMLINK MANAGER (Linux & Cross-Platform)
# ----------------------------------------------------------------------
# Este script crea enlaces simbolicos de forma idempotente y segura.
# ----------------------------------------------------------------------

set -e

# Colores para salida
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GRAY='\033[0;90m'
NC='\033[0m'

# Asegurar directorio de backup
BACKUP_DIR="$HOME/BACKUP/symlinks_$(date +%Y%m%d_%H%M%S)"

# --- Funcion de Utilidad: create_link ---
# $1: Target (donde apunta)
# $2: Link (donde se crea)
create_link() {
    local target="$1"
    local link="$2"

    # 1. Verificar si el link ya existe
    if [ -L "$link" ]; then
        local current_target
        current_target=$(readlink -f "$link")
        local absolute_target
        absolute_target=$(readlink -f "$target")

        if [ "$current_target" == "$absolute_target" ]; then
            echo -e "${GRAY}[OK] Enlace ya correcto: $link${NC}"
            return
        fi

        echo -e "${YELLOW}[INFO] Reemplazando enlace viejo en: $link${NC}"
        rm "$link"
    elif [ -e "$link" ]; then
        # 2. Si es un archivo/directorio real, hacer backup
        echo -e "${RED}[WARN] Se encontro un elemento REAL en $link. Moviendo a backup...${NC}"
        mkdir -p "$BACKUP_DIR"
        mv "$link" "$BACKUP_DIR/"
    fi

    # 3. Crear el link
    local parent_dir
    parent_dir=$(dirname "$link")
    mkdir -p "$parent_dir"
    ln -s "$target" "$link"
    echo -e "${GREEN}[SUCCESS] Enlace creado: $link -> $target${NC}"
}

# --- LOGICA PRINCIPAL ---

# Asegurar que DOTFILES este definido
if [ -z "$DOTFILES" ]; then
    DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
fi

echo -e "${BLUE}=== Iniciando Gestion de Enlaces Simbolicos ===${NC}"

# 1. Enlaces de Configuracion Base (Siempre necesarios)
create_link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
create_link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore"
create_link "$DOTFILES/shell/zsh/.zshrc" "$HOME/.zshrc"
create_link "$DOTFILES/os/cross-platform/starship/starship.toml" "$HOME/.config/starship.toml"
create_link "$DOTFILES/os/cross-platform/wezterm" "$HOME/.config/wezterm"
create_link "$DOTFILES/editors/nvim/nvim-yc-26" "$HOME/.config/nvim"
create_link "$DOTFILES/shell/zsh/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
create_link "$DOTFILES/editors/zed/settings.json" "$HOME/.config/zed/settings.json"
create_link "$DOTFILES/editors/zed/keymap.json" "$HOME/.config/zed/keymap.json"
create_link "$DOTFILES/os/cross-platform/harlequin/config.toml" "$HOME/.config/harlequin/config.toml"
create_link "$DOTFILES/os/linux/tmux" "$HOME/.config/tmux"
create_link "$DOTFILES/os/windows/programs/Fastfetch" "$HOME/.config/fastfetch"

# 2. Enlaces de Interfaz (Solo si NO es WSL / MINIMAL)
# Convertir a minúsculas para comparación robusta
MINIMAL_LOWER=$(echo "${MINIMAL:-false}" | tr '[:upper:]' '[:lower:]')
if [ "$MINIMAL_LOWER" != "true" ]; then
    echo -e "\n${BLUE}=== Configurando Enlaces de Interfaz (Bare Metal) ===${NC}"
    create_link "$DOTFILES/os/linux/kitty" "$HOME/.config/kitty"
    create_link "$DOTFILES/os/linux/hypr" "$HOME/.config/hypr"
    create_link "$DOTFILES/os/linux/waybar" "$HOME/.config/waybar"
    create_link "$DOTFILES/os/linux/dunst" "$HOME/.config/dunst"
    create_link "$DOTFILES/os/linux/wlogout" "$HOME/.config/wlogout"
    create_link "$DOTFILES/os/linux/tofi" "$HOME/.config/tofi"
    create_link "$DOTFILES/os/linux/alacritty" "$HOME/.config/alacritty"
    create_link "$DOTFILES/os/linux/ghostty" "$HOME/.config/ghostty"

    # Ejecutar setup de SDDM si existe
    if [ -f "$DOTFILES/os/linux/sddm/setup-sddm.sh" ]; then
        bash "$DOTFILES/os/linux/sddm/setup-sddm.sh"
    fi
else
    echo -e "\n${YELLOW}[INFO] Modo MINIMAL detectado. Saltando enlaces de interfaz grafica.${NC}"
fi

echo -e "\n${GREEN}=== Gestion de Enlaces Simbolicos Finalizada ===${NC}"
