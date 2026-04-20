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

# --- Config File Links ---
# For files, `ln -sf` is sufficient to overwrite. No `rm` needed.
ln -sf $DOTFILES/os/cross-platform/starship/starship.toml "$HOME/.config/starship.toml"
ln -sf $DOTFILES/git/.gitconfig "$HOME/.gitconfig"
ln -sf $DOTFILES/shell/zsh/.zshrc "$HOME/.zshrc"

# Sheldon config
mkdir -p "$HOME/.config/sheldon"
ln -sf "$DOTFILES/shell/zsh/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

# Zed config
mkdir -p "$HOME/.config/zed"
ln -sf "$DOTFILES/editors/zed/settings.json" "$HOME/.config/zed/settings.json"
ln -sf "$DOTFILES/editors/zed/keymap.json" "$HOME/.config/zed/keymap.json"

# --- Linters & Formatters ---
ln -sf $DOTFILES/os/cross-platform/linters/.clang-format "$HOME/.clang-format"
ln -sf $DOTFILES/os/cross-platform/linters/.clangd "$HOME/.clangd"
ln -sf $DOTFILES/os/cross-platform/linters/.stylua.toml "$HOME/.stylua.toml"
ln -sf $DOTFILES/os/cross-platform/linters/.luacheckrc "$HOME/.luacheckrc"
ln -sf $DOTFILES/os/cross-platform/linters/.prettierrc "$HOME/.prettierrc"
ln -sf $DOTFILES/os/cross-platform/linters/.ruff.toml "$HOME/.ruff.toml"
ln -sf $DOTFILES/os/cross-platform/linters/.editorconfig "$HOME/.editorconfig"

# --- [SDDM] Setup Theme & Permissions ---
if [ -f "$DOTFILES/os/linux/sddm/setup-sddm.sh" ]; then
    bash "$DOTFILES/os/linux/sddm/setup-sddm.sh"
fi
