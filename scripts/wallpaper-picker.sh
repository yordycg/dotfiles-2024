#!/usr/bin/env bash

# --- [hypr] Interactive Wallpaper Picker with SWWW ---
# Allows selecting a wallpaper from the repository and applies it with transition.

WALLPAPER_DIR="$HOME/workspace/repos/wallpapers"
STATE_FILE="$HOME/.cache/.current_wallpaper"

# Ensure awww daemon is running
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.5
fi

# 1. Select wallpaper using FZF (Popup version if in Tmux)
selection=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | \
    sed "s|$WALLPAPER_DIR/||" | \
    fzf-tmux -p 80%,70% -- --ansi --reverse \
        --prompt="󰸉 Select Wallpaper: " \
        --header="[ENTER] Apply | [ESC] Cancel" \
        --preview "chafa --size=60x30 $WALLPAPER_DIR/{}" \
        --preview-window="right:60%")

if [[ -n "$selection" ]]; then
    full_path="$WALLPAPER_DIR/$selection"
    
    # 2. Apply wallpaper with transition (in background to avoid blocking)
    awww img "$full_path" \
        --transition-type grow \
        --transition-pos top-right \
        --transition-duration 2 \
        --transition-fps 60 > /dev/null 2>&1 &

    # 3. Save state for persistence
    echo "$full_path" > "$STATE_FILE"
    
    # Clean up the terminal and exit
    clear
    echo "󰸉 Wallpaper applied: $selection"
    exit 0
fi
