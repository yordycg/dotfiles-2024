#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display messages
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# --- Main Installation Script ---

log_info "Starting Arch Linux post-installation script..."

# Detección de WSL
if grep -qi microsoft /proc/version; then
    log_info "WSL detectado. Activando modo MINIMAL (CLI + Kitty)."
    export MINIMAL=true
    bash ./wsl-setup.sh
else
    export MINIMAL=false
fi

# Ensure the script is run from its directory
cd "$(dirname "$0")" || log_error "Failed to change to script directory."

# --- Execute modular scripts ---

log_info "Running 00-yay.sh: Installing/updating yay (AUR helper)."
bash 00-yay.sh || log_error "00-yay.sh failed."

log_info "Running 01-packages.sh: Installing official and AUR packages."
bash 01-packages.sh || log_error "01-packages.sh failed."

# El resto de tareas (SSH, Dotfiles, Docker) ahora se orquestan desde el install.sh raíz 
# para asegurar el orden correcto de dependencias.

log_info "Arch Linux post-installation modular scripts completed!"
