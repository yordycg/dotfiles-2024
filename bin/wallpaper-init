#!/usr/bin/env bash

# --- [hypr] Wallpaper Initialization ---
# Restores the last used wallpaper or sets a default one.

STATE_FILE="$HOME/.cache/.current_wallpaper"
DEFAULT_WALLPAPER="$HOME/.config/assets/backgrounds/cat_leaves.png"

# Start awww daemon
awww-daemon &
sleep 1

# Check for saved state
if [[ -f "$STATE_FILE" ]]; then
    LAST_WALL=$(cat "$STATE_FILE")
    if [[ -f "$LAST_WALL" ]]; then
        awww img "$LAST_WALL" --transition-type none
    else
        awww img "$DEFAULT_WALLPAPER" --transition-type none
    fi
else
    awww img "$DEFAULT_WALLPAPER" --transition-type none
fi
