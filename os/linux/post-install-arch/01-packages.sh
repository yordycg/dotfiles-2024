#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to display messages (re-defined for modularity or can be sourced)
log_info() {
    echo -e "\033[0;32m[INFO]\033[0m $1"
}

log_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $1"
    exit 1
}

# Ensure we are in the script's directory for relative paths to work
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

log_info "Installing packages from official repositories..."
if [ -f "./packages/pkglist-official.txt" ]; then
    if [ "$MINIMAL" = "true" ]; then
        log_info "Filtrando paquetes GUI pesados (manteniendo Kitty)..."
        # Excluimos el entorno de escritorio y apps pesadas, pero NO kitty ni herramientas dev
        GUI_EXCLUDE="hypr|sddm|waybar|mako|wofi|thunar|firefox|obsidian|sway|wayland-utils"
        tr -d '\r' < "./packages/pkglist-official.txt" | grep -vE "$GUI_EXCLUDE" | yay -Syu --noconfirm --needed - || log_error "Failed to install official packages."
    else
        tr -d '\r' < "./packages/pkglist-official.txt" | yay -Syu --noconfirm --needed - || log_error "Failed to install official packages."
    fi
else
    log_info "No official package list found (./packages/pkglist-official.txt). Skipping."
fi

log_info "Installing packages from AUR..."
if [ -f "./packages/pkglist-aur.txt" ]; then
    if [ "$MINIMAL" = "true" ]; then
        log_info "Filtrando paquetes AUR GUI..."
        # Excluimos navegadores y decoraciones de escritorio
        AUR_EXCLUDE="chrome|brave|edge|wlogout|walker|sddm-sugar-candy"
        tr -d '\r' < "./packages/pkglist-aur.txt" | grep -vE "$AUR_EXCLUDE" | yay -Syu --noconfirm --needed - || log_error "Failed to install AUR packages."
    else
        tr -d '\r' < "./packages/pkglist-aur.txt" | yay -Syu --noconfirm --needed - || log_error "Failed to install AUR packages."
    fi
else
    log_info "No AUR package list found (./packages/pkglist-aur.txt). Skipping."
fi

log_info "Package installation complete."
