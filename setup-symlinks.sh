#!/bin/bash
# Self-define the DOTFILES variable based on the script's own location
# This makes the script portable and independent of the calling environment.
DOTFILES=$(dirname "$(readlink -f "$0" || realpath "$0")")

# Create directory if it doesn't exist
[ -d ~/.config ] || mkdir -p ~/.config

# If Linux...
ln -sf $DOTFILES/os/linux/tmux ~/.config/
ln -sf $DOTFILES/os/linux/kitty ~/.config/
ln -sf $DOTFILES/os/linux/hyprland ~/.config/
ln -sf $DOTFILES/os/linux/waybar ~/.config/
ln -sf $DOTFILES/os/linux/dunst ~/.config/
ln -sf $DOTFILES/os/linux/wlogout ~/.config/
ln -sf $DOTFILES/os/linux/tofi ~/.config/
ln -sf $DOTFILES/os/linux/alacritty ~/.config/
ln -sf $DOTFILES/os/linux/ghostty ~/.config/
ln -sf $DOTFILES/os/cross-platform/wezterm ~/.config/
ln -sf $DOTFILES/os/cross-platform/starship/ ~/.config/
ln -sf $DOTFILES/git/.gitconfig ~/.gitconfig
ln -sf $DOTFILES/shell/zsh/.zshrc ~/.zshrc

# Sheldon config
mkdir -p ~/.config/sheldon
ln -sf "$DOTFILES/shell/zsh/sheldon/plugins.toml" ~/.config/sheldon/plugins.toml

## cpp
ln -sf $DOTFILES/os/cross-platform/clangd/.clang-format ~/.clang-format
ln -sf $DOTFILES/os/cross-platform/clangd/.clangd ~/.clangd

# If Windows...

# If macOs...
