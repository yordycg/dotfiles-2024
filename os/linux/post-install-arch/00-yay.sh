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

if command -v yay &> /dev/null
then
    log_info "yay is already installed. Updating yay..."
    yay -Syu --noconfirm || log_error "Failed to update yay."
else
    log_info "yay is not installed. Installing yay..."
    # Install base-devel if not present
    sudo pacman -S --noconfirm base-devel git || log_error "Failed to install base-devel or git."

    # Clone yay AUR helper
    git clone https://aur.archlinux.org/yay.git /tmp/yay || log_error "Failed to clone yay repository."
    cd /tmp/yay || log_error "Failed to change directory to /tmp/yay."
    makepkg -si --noconfirm || log_error "Failed to install yay."
    cd - > /dev/null # Go back to previous directory
    rm -rf /tmp/yay || log_error "Failed to remove /tmp/yay."
    log_info "yay installed successfully."
fi

log_info "yay setup complete."
