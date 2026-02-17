#!/bin/bash
# Self-define the DOTFILES variable based on the script's own location
# This makes the script portable and independent of the calling environment.
DOTFILES=$(dirname "$(readlink -f "$0" || realpath "$0")")

# Create directory if it doesn't exist
[ -d ~/.config ] || mkdir -p ~/.config

# If Linux...
ln -s $DOTFILES/os/linux/tmux ~/.config/
ln -s $DOTFILES/os/linux/kitty ~/.config/
ln -s $DOTFILES/os/linux/hyprland ~/.config/
ln -s $DOTFILES/os/linux/waybar ~/.config/
ln -s $DOTFILES/os/linux/dunst ~/.config/
ln -s $DOTFILES/os/linux/wlogout ~/.config/
ln -s $DOTFILES/os/linux/tofi ~/.config/
ln -s $DOTFILES/os/linux/alacritty ~/.config/
ln -s $DOTFILES/os/linux/ghostty ~/.config/
ln -s $DOTFILES/os/cross-platform/wezterm ~/.config/
ln -s $DOTFILES/os/cross-platform/starship/ ~/.config/
ln -fs $DOTFILES/git/.gitconfig ~/.gitconfig
ln -fs $DOTFILES/shell/zsh/.zshrc ~/.zshrc

# Sheldon config
mkdir -p ~/.config/sheldon
ln -sf "$DOTFILES/shell/zsh/sheldon/plugins.toml" ~/.config/sheldon/plugins.toml

## cpp
ln -sf $DOTFILES/os/cross-platform/clangd/.clang-format ~/.clang-format
ln -sf $DOTFILES/os/cross-platform/clangd/.clangd ~/.clangd

# If Windows...

# If macOs...
