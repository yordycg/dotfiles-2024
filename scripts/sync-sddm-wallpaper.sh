#!/usr/bin/env bash

# --- [sddm] Sync Wallpaper and Theme Config ---
# Syncs both the wallpaper and the theme configuration for SDDM sugar-candy.

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || dirname "$(dirname "$(realpath "$0")")")"
WALLPAPER_PATH="$1"
SDDM_THEME_DIR="/usr/share/sddm/themes/sugar-candy"
SDDM_BG_DIR="$SDDM_THEME_DIR/Backgrounds"
SDDM_BG_FILE="$SDDM_BG_DIR/current_wallpaper.jpg"
SDDM_CONF_FILE="$SDDM_THEME_DIR/theme.conf.user"

# 1. Sync Theme Configuration
if [[ -f "$DOTFILES_ROOT/os/linux/sddm/theme.conf.user" ]]; then
    echo "Syncing SDDM theme configuration..."
    sudo cp "$DOTFILES_ROOT/os/linux/sddm/theme.conf.user" "$SDDM_CONF_FILE"
    sudo chmod 644 "$SDDM_CONF_FILE"
fi

# 2. Sync Wallpaper
if [[ -n "$WALLPAPER_PATH" && -f "$WALLPAPER_PATH" ]]; then
    echo "Syncing SDDM wallpaper: $WALLPAPER_PATH"
    # Ensure directory exists (might need sudo if not done yet, but we'll try without)
    mkdir -p "$SDDM_BG_DIR"
    # Copy and overwrite the background
    cp "$WALLPAPER_PATH" "$SDDM_BG_FILE"
    # Ensure SDDM can read it
    chmod 644 "$SDDM_BG_FILE"
    echo "SDDM Wallpaper updated: $SDDM_BG_FILE"
else
    echo "No wallpaper path provided or file doesn't exist. Skipping wallpaper sync."
fi
