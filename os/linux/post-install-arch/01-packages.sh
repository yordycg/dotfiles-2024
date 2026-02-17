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

log_info "Installing packages from official repositories..."
if [ -f "./packages/pkglist-official.txt" ]; then
    yay -Syu --noconfirm --needed - < "./packages/pkglist-official.txt" || log_error "Failed to install official packages."
else
    log_info "No official package list found (./packages/pkglist-official.txt). Skipping."
fi

log_info "Installing packages from AUR..."
if [ -f "./packages/pkglist-aur.txt" ]; then
    yay -Syu --noconfirm --needed - < "./packages/pkglist-aur.txt" || log_error "Failed to install AUR packages."
else
    log_info "No AUR package list found (./packages/pkglist-aur.txt). Skipping."
fi

log_info "Package installation complete."
