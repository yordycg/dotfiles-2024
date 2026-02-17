#!/bin/bash
# Self-define the DOTFILES variable based on the script's own location
# This makes the script portable and independent of the calling environment.
DOTFILES=$(dirname "$(readlink -f "$0" || realpath "$0")")

# Create directory if it doesn't exist
[ -d ~/.config ] || mkdir -p ~/.config

# If Linux...
rm -rf ~/.config/tmux; ln -sf $DOTFILES/os/linux/tmux ~/.config/
rm -rf ~/.config/kitty; ln -sf $DOTFILES/os/linux/kitty ~/.config/
rm -rf ~/.config/hyprland; ln -sf $DOTFILES/os/linux/hyprland ~/.config/
rm -rf ~/.config/waybar; ln -sf $DOTFILES/os/linux/waybar ~/.config/
rm -rf ~/.config/dunst; ln -sf $DOTFILES/os/linux/dunst ~/.config/
rm -rf ~/.config/wlogout; ln -sf $DOTFILES/os/linux/wlogout ~/.config/
rm -rf ~/.config/tofi; ln -sf $DOTFILES/os/linux/tofi ~/.config/
rm -rf ~/.config/alacritty; ln -sf $DOTFILES/os/linux/alacritty ~/.config/
rm -rf ~/.config/ghostty; ln -sf $DOTFILES/os/linux/ghostty ~/.config/
rm -rf ~/.config/wezterm; ln -sf $DOTFILES/os/cross-platform/wezterm ~/.config/
rm -rf ~/.config/starship; ln -sf $DOTFILES/os/cross-platform/starship/ ~/.config/
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
