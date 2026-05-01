#!/bin/bash
[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"

# --- Linux & Cross-Platform Directory Links ---
rm -rf "$HOME/.config/tmux"; ln -s $DOTFILES/os/linux/tmux "$HOME/.config/"
rm -rf "$HOME/.config/kitty"; ln -s $DOTFILES/os/linux/kitty "$HOME/.config/"
rm -rf "$HOME/.config/hypr"; ln -s $DOTFILES/os/linux/hypr "$HOME/.config/"
rm -rf "$HOME/.config/waybar"; ln -s $DOTFILES/os/linux/waybar "$HOME/.config/"
rm -rf "$HOME/.config/dunst"; ln -s $DOTFILES/os/linux/dunst "$HOME/.config/"
rm -rf "$HOME/.config/wlogout"; ln -s $DOTFILES/os/linux/wlogout "$HOME/.config/"
rm -rf "$HOME/.config/tofi"; ln -s $DOTFILES/os/linux/tofi "$HOME/.config/"
rm -rf "$HOME/.config/alacritty"; ln -s $DOTFILES/os/linux/alacritty "$HOME/.config/"
rm -rf "$HOME/.config/ghostty"; ln -s $DOTFILES/os/linux/ghostty "$HOME/.config/"
rm -rf "$HOME/.config/wezterm"; ln -s $DOTFILES/os/cross-platform/wezterm "$HOME/.config/"
rm -rf "$HOME/.config/nvim"; ln -s $DOTFILES/editors/nvim/nvim-yc-26 "$HOME/.config/nvim"

# --- Config File Links ---
ln -sf $DOTFILES/os/cross-platform/starship/starship.toml "$HOME/.config/starship.toml"
ln -sf $DOTFILES/git/.gitconfig "$HOME/.gitconfig"
ln -sf $DOTFILES/git/.gitignore_global "$HOME/.gitignore"
ln -sf $DOTFILES/shell/zsh/.zshrc "$HOME/.zshrc"

# Sheldon config
mkdir -p "$HOME/.config/sheldon"
ln -sf "$DOTFILES/shell/zsh/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

# Zed config
mkdir -p "$HOME/.config/zed"
ln -sf "$DOTFILES/editors/zed/settings.json" "$HOME/.config/zed/settings.json"
ln -sf "$DOTFILES/editors/zed/keymap.json" "$HOME/.config/zed/keymap.json"

# Harlequin config
rm -rf "$HOME/.config/harlequin"
mkdir -p "$HOME/.config/harlequin"
ln -sf "$DOTFILES/os/cross-platform/harlequin/config.toml" "$HOME/.config/harlequin/config.toml"

# --- [SDDM] Setup Theme & Permissions ---
if [ -f "$DOTFILES/os/linux/sddm/setup-sddm.sh" ]; then
    bash "$DOTFILES/os/linux/sddm/setup-sddm.sh"
fi
