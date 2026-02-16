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
if [ -f "$DOTFILES_ROOT/setup-symlinks.sh" ]; then
    log_info "Executing $DOTFILES_ROOT/setup-symlinks.sh"
    bash "$DOTFILES_ROOT/setup-symlinks.sh" || log_error "setup-symlinks.sh failed."
else
    log_error "setup-symlinks.sh not found at $DOTFILES_ROOT/setup-symlinks.sh. Please ensure it exists."
fi

log_info "Dotfiles setup complete."
