#!/bin/bash

# =============================================================================
# GLOBAL THEME ORCHESTRATOR
# =============================================================================

DOTFILES="$HOME/workspace/repos/dotfiles-2024"
THEMES_DIR="$DOTFILES/os/linux/themes"
CACHE_DIR="$HOME/.cache/dotfiles"
mkdir -p "$CACHE_DIR"

THEME=$1

if [ -z "$THEME" ]; then
    echo "Usage: set-theme <theme_name>"
    exit 1
fi

THEME_FILE="$THEMES_DIR/$THEME.sh"

if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme '$THEME' not found"
    exit 1
fi

# 1. Load Theme Variables
source "$THEME_FILE"

# 2. Update Cache
cat <<EOF > "$CACHE_DIR/current_theme.sh"
export GLOBAL_THEME="$THEME_NAME"
export COLOR_BG="$COLOR_BG"
export COLOR_FG="$COLOR_FG"
export COLOR_ACCENT="$COLOR_ACCENT"
export COLOR_BORDER="$COLOR_BORDER"
export COLOR_CRITICAL="$COLOR_CRITICAL"
export COLOR_ACTIVE="$COLOR_ACTIVE"
EOF

# 3. Update Neovim State
echo "return '$NVIM_THEME'" > "$HOME/.local/share/nvim/yc_theme_state.lua"

# 4. Update Ghostty
GHOSTTY_CONFIG="$DOTFILES/os/linux/ghostty/config"

if [ -f "$GHOSTTY_CONFIG" ]; then
    # Usamos la ruta del repositorio para asegurar que el archivo fuente cambie
    # Ghostty detectará el cambio a través del symlink en ~/.config/ghostty/config
    sed -i "s|^[[:space:]]*theme[[:space:]]*=.*|theme = \"$GHOSTTY_THEME\"|" "$GHOSTTY_CONFIG"
    # Reload Ghostty configuration instantly
    killall -SIGUSR2 ghostty 2>/dev/null
fi

# 4.5 Update Harlequin
HARLEQUIN_CONFIG_REPO="$DOTFILES/os/cross-platform/harlequin/config.toml"
HARLEQUIN_CONFIG_HOME="$HOME/.config/harlequin/config.toml"

update_harlequin() {
    local file=$1
    if [ -f "$file" ]; then
        sed -i "s/^theme = .*/theme = \"$HARLEQUIN_THEME\"/" "$file"
    fi
}

update_harlequin "$HARLEQUIN_CONFIG_REPO"
update_harlequin "$HARLEQUIN_CONFIG_HOME"

# 5. Generate UI Colors
cat <<EOF > "$HOME/.config/hypr/colors.conf"
\$bg = rgb(${COLOR_BG//#/})
\$fg = rgb(${COLOR_FG//#/})
\$accent = rgb(${COLOR_ACCENT//#/})
\$border = rgb(${COLOR_BORDER//#/})
EOF

cat <<EOF > "$HOME/.config/waybar/colors.css"
@define-color bg ${COLOR_BG};
@define-color fg ${COLOR_FG};
@define-color accent ${COLOR_ACCENT};
@define-color border ${COLOR_BORDER};
@define-color critical ${COLOR_CRITICAL};
EOF

# 6. Update Persistence
sed -i "s/^export TMUX_THEME=.*/export TMUX_THEME=\"$TMUX_THEME\"/" "$DOTFILES/shell/exports.sh"
sed -i "s/^export NVIM_THEME=.*/export NVIM_THEME=\"$NVIM_THEME\"/" "$DOTFILES/shell/exports.sh"

# 7. Reload
hyprctl reload > /dev/null 2>&1
killall -SIGUSR2 waybar 2>/dev/null || (killall waybar; waybar &) > /dev/null 2>&1

echo "Applied: $THEME_NAME"
