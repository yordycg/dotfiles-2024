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

log_info "Iniciando configuracion de dotfiles..."

# Localizar la raiz del repositorio
DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
if [ -z "$DOTFILES_ROOT" ]; then
    DOTFILES_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
fi

# Ejecutar el gestor de symlinks maestro
if [ -f "$DOTFILES_ROOT/scripts/setup-symlinks.sh" ]; then
    log_info "Ejecutando gestor de enlaces simbolicos..."
    DOTFILES="$DOTFILES_ROOT" bash "$DOTFILES_ROOT/scripts/setup-symlinks.sh" || log_error "setup-symlinks.sh fallo."
else
    log_error "No se encontro setup-symlinks.sh en $DOTFILES_ROOT/scripts/setup-symlinks.sh"
fi

# --- Cambio de Shell a Zsh ---
log_info "Configurando Zsh como shell por defecto..."

ZSH_PATH=$(command -v zsh)
if [ -n "$ZSH_PATH" ]; then
    # Asegurar que Zsh este en /etc/shells
    if ! grep -qF "$ZSH_PATH" /etc/shells; then
        echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
    fi

    # Cambiar shell si es necesario
    CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
    if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
        log_info "Cambiando shell a Zsh (puede requerir contraseña)..."
        sudo chsh -s "$ZSH_PATH" "$USER"
    else
        log_info "Zsh ya es la shell por defecto."
    fi
else
    log_info "Zsh no esta instalado. Saltando cambio de shell."
fi

# --- Setup de Node.js (vía setup-node) ---
if [ -f "$DOTFILES_ROOT/bin/setup-node" ]; then
    log_info "Configurando entorno Node.js..."
    bash "$DOTFILES_ROOT/bin/setup-node" || log_info "Advertencia: setup-node fallo o no es compatible."
fi

log_info "Configuracion de dotfiles finalizada."

