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

log_info "Running dotfiles setup script..."

# Navigate to the root of the dotfiles repository
DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
if [ -z "$DOTFILES_ROOT" ]; then
    # Fallback if not in a git repo or if git is not yet fully configured
    # Assumes post-install-arch is directly under os/linux/ and dotfiles root is two levels up
    DOTFILES_ROOT="$(dirname "$(dirname "$(dirname "$0")")")"
fi

# Execute the main setup-symlinks.sh script from the dotfiles root
if [ -f "$DOTFILES_ROOT/scripts/setup-symlinks.sh" ]; then
    log_info "Executing $DOTFILES_ROOT/scripts/setup-symlinks.sh with absolute path..."
    # Prepending the command with DOTFILES="$DOTFILES_ROOT" injects the absolute path
    # as an environment variable into the script, ensuring it's always set correctly.
    DOTFILES="$DOTFILES_ROOT" bash "$DOTFILES_ROOT/scripts/setup-symlinks.sh" || log_error "setup-symlinks.sh failed."
else
    log_error "setup-symlinks.sh not found at $DOTFILES_ROOT/scripts/setup-symlinks.sh. Please ensure it exists."
fi

# --- Change default shell to Zsh ---
log_info "Changing default shell to Zsh..."

# Check if Zsh is installed
ZSH_PATH=$(command -v zsh)
if [ -z "$ZSH_PATH" ]; then
    log_error "Zsh is not installed. Please install it before changing the shell."
fi

# FIX AUTOMATIZADO: Asegurar que Zsh esté en /etc/shells
if ! grep -qF "$ZSH_PATH" /etc/shells; then
    log_info "Adding $ZSH_PATH to /etc/shells..."
    echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

# Check if the shell is already Zsh
if [ "$SHELL" != "$ZSH_PATH" ]; then
    log_info "Attempting to set Zsh as the default shell. This may require your password."
    if sudo chsh -s "$ZSH_PATH" "$USER"; then
        log_info "Default shell changed to Zsh successfully."
    else
        log_error "Failed to change the default shell."
    fi
else
    log_info "Default shell is already Zsh. Skipping."
fi

# --- Setup Node.js with fnm ---
if [ -f "$DOTFILES_ROOT/bin/setup-node" ]; then
    log_info "Executing $DOTFILES_ROOT/bin/setup-node..."
    bash "$DOTFILES_ROOT/bin/setup-node" || log_error "setup-node failed."
else
    log_info "setup-node not found at $DOTFILES_ROOT/bin/setup-node. Skipping."
fi

log_info "Dotfiles setup complete."
