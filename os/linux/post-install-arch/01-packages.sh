#!/bin/bash
# ----------------------------------------------------------------------
# Arch Linux Package Installer
# ----------------------------------------------------------------------

set -e

log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
log_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; exit 1; }

# Directorio de los paquetes
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$SCRIPT_DIR/packages"

# 1. Definicion de Filtros para WSL (Modo Minimal)
# Paquetes de Hardware, Kernel, Boot y GUI pesada que NO queremos en WSL
SYSTEM_FILTER="grub|efibootmgr|os-prober|linux|linux-firmware|networkmanager|blueman|brightnessctl|vulkan-intel|mesa"
GUI_FILTER="hyprland|sddm|waybar|mako|wofi|thunar|nwg-look|kvantum|qt5-wayland|qt6-wayland|xdg-desktop-portal-hyprland"
BROWSER_FILTER="firefox|chrome|brave|edge|thorium"
FONT_FILTER="ttf-cascadia|ttf-fira|ttf-jetbrains|ttf-lilex|ttf-roboto"

# Combinar filtros si estamos en modo Minimal
if [ "$MINIMAL" = "true" ]; then
    log_info "Modo MINIMAL (WSL) detectado. Se filtraran paquetes de sistema y GUI pesada."
    EXCLUDE_PATTERN="^($SYSTEM_FILTER|$GUI_FILTER|$BROWSER_FILTER|$FONT_FILTER)"
else
    log_info "Modo FULL (Bare Metal) detectado. Se instalara todo el ecosistema."
    EXCLUDE_PATTERN="^$" # No excluir nada
fi

# 2. Instalacion de Paquetes Oficiales
if [ -f "$PKG_DIR/pkglist-official.txt" ]; then
    log_info "Instalando paquetes desde repositorios oficiales..."
    tr -d '\r' < "$PKG_DIR/pkglist-official.txt" | grep -vE "$EXCLUDE_PATTERN" | yay -Syu --noconfirm --needed - || log_error "Fallo la instalacion de paquetes oficiales."
fi

# 3. Instalacion de Paquetes AUR
if [ -f "$PKG_DIR/pkglist-aur.txt" ]; then
    log_info "Instalando paquetes desde AUR..."
    tr -d '\r' < "$PKG_DIR/pkglist-aur.txt" | grep -vE "$EXCLUDE_PATTERN" | yay -Syu --noconfirm --needed - || log_error "Fallo la instalacion de paquetes AUR."
fi

log_info "Instalacion de paquetes completada."
