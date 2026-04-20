#!/usr/bin/env bash

# --- [sddm] Automated SDDM Theme Setup ---
# This script configures the sugar-candy theme with Catppuccin Macchiato style.

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || dirname "$(dirname "$(realpath "$0")")")"
SDDM_THEME_DIR="/usr/share/sddm/themes/sugar-candy"
SDDM_BG_DIR="$SDDM_THEME_DIR/Backgrounds"
SDDM_CONF_FILE="$SDDM_THEME_DIR/theme.conf.user"
LOCAL_CONF="$DOTFILES_ROOT/os/linux/sddm/theme.conf.user"

echo "󰸉 Starting SDDM Theme Setup..."

# 1. Check if theme is installed
if [ ! -d "$SDDM_THEME_DIR" ]; then
    echo "󰀦 Error: sugar-candy theme not found in $SDDM_THEME_DIR"
    echo "Please install it first (e.g., yay -S sddm-sugar-candy-git)"
    exit 1
fi

# 2. Apply Theme Configuration (requires sudo)
if [ -f "$LOCAL_CONF" ]; then
    echo "󰄬 Copying theme configuration (requires sudo)..."
    sudo cp "$LOCAL_CONF" "$SDDM_CONF_FILE"
    sudo chmod 644 "$SDDM_CONF_FILE"
else
    echo "󰀦 Error: Local config not found at $LOCAL_CONF"
    exit 1
fi

# 3. Setup Background Permissions for seamless sync
echo "󰄬 Setting up background directory permissions..."
sudo mkdir -p "$SDDM_BG_DIR"
sudo chown "$USER:$USER" "$SDDM_BG_DIR"
sudo chmod 775 "$SDDM_BG_DIR"

# 4. Initial Wallpaper Sync (if exists)
STATE_FILE="$HOME/.cache/.current_wallpaper"
if [ -f "$STATE_FILE" ]; then
    CURRENT_WP=$(cat "$STATE_FILE")
    echo "󰄬 Syncing current wallpaper: $(basename "$CURRENT_WP")"
    cp "$CURRENT_WP" "$SDDM_BG_DIR/current_wallpaper.jpg"
    chmod 644 "$SDDM_BG_DIR/current_wallpaper.jpg"
fi

echo "󰄬 SDDM Setup Complete! Layout is now centered and modern."
