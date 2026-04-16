# --------------------
# Environment Variables (Synchronized with shell/exports.sh)
# --------------------
# NOTE: To maintain a single source of truth, consider using 'bass' 
# or a script to generate this file from exports.sh.

# Editors
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER firefox

# Directories Paths
set -gx WORKSPACE_PATH "$HOME/workspace"
set -gx DEV_PATH "$WORKSPACE_PATH/dev"
set -gx REPOS_PATH "$WORKSPACE_PATH/repos"
set -gx DOTFILES "$REPOS_PATH/dotfiles-2024"
set -gx PROJECTS_PATH "$DEV_PATH/projects"
set -gx OBSIDIAN "$REPOS_PATH/obsidian-notes"
set -gx WALLPAPERS "$REPOS_PATH/wallpapers"
set -gx DSA_PATH "/mnt/d/Escitorio 2/Cursos-Yordy/00 - Cursos Programacion/04 DataStructure-Algorithms"
set -gx CPP_PATH "/mnt/d/Escitorio 2/Cursos-Yordy/00 - Cursos Programacion/02 Cpp"

## XDG Base Directories
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

# Themes
set -gx TMUX_THEME nord
set -gx NVIM_THEME nord
set -gx STARSHIP_THEME nord
set -gx WEZTERM_THEME nord

# Path Config
fish_add_path /usr/local/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

# Homebrew
if test -d /home/linuxbrew/.linuxbrew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
