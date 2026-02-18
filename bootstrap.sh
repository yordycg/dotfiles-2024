#!/bin/bash

# Simple bootstrap script for dotfiles

# Exit on error
set -e

# Define colors
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Starting bootstrap process...${NC}"

# 1. Install Git
echo -e "${GREEN}Ensuring Git is installed...${NC}"
if ! command -v git &> /dev/null; then
    sudo pacman -S --noconfirm git
else
    echo "Git is already installed."
fi

# 2. Clone the repository
DOTFILES_DIR="$HOME/.dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${GREEN}Dotfiles directory already exists. Pulling latest changes...${NC}"
    (cd "$DOTFILES_DIR" && git pull origin main) # Assuming main is the default branch
else
    echo -e "${GREEN}Cloning dotfiles repository to $DOTFILES_DIR...${NC}"
    git clone https://github.com/yordycg/dotfiles-2024.git "$DOTFILES_DIR"
fi

# 3. Execute the main installation script
INSTALL_SCRIPT="$DOTFILES_DIR/os/linux/post-install-arch/install.sh"
if [ -f "$INSTALL_SCRIPT" ]; then
    echo -e "${GREEN}Executing main installation script...${NC}"
    # Make sure scripts are executable before running
    chmod +x "$DOTFILES_DIR/os/linux/post-install-arch/"*.sh
    bash "$INSTALL_SCRIPT"
else
    echo "Installation script not found at $INSTALL_SCRIPT"
    exit 1
fi

echo -e "${GREEN}Bootstrap process complete. Please restart your system or log out/log in.${NC}"
