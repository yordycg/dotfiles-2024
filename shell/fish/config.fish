# --------------------
# Fish Config
# --------------------

set -g fish_greeting            # deshabilitar greeting.
set -g fish_history_limit 1000  # config historial.
fish_vi_key_bindings            # habilitar vi key-bindings.

# Config colors in 'man' pages.
set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;31m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;44;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[01;32m'

# Load specifig config.
# ...

# Environment Variables
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER firefox

# Directories
set -gx WORKSPACE_PATH "$HOME/workspace"
set -gx DEV_PATH "$WORKSPACE_PATH/dev"
set -gx PROJECTS_PATH "$DEV_PATH/projects"
set -gx REPOS_PATH "$WORKSPACE_PATH/repos"
set -gx DOTFILES "$REPOS_PATH/dotfiles-2024"
set -gx OBSIDIAN "$REPOS_PATH/obsidian-notes"
set -gx WALLPAPERS_PATH "$REPOS_PATH/wallpapers"
set -gx DSA_PATH "/mnt/d/Escitorio 2/Cursos-Yordy/00 - Cursos Programacion/04 DataStructure-Algorithms"
set -gx CPP_PATH "/mnt/d/Escitorio 2/Cursos-Yordy/00 - Cursos Programacion/02 Cpp"

## XDG Base Directories
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

# Themes
# Options: adib-hanna | minimal | nord | onedark | dracula | catppuccin
set -gx TMUX_THEME nord
set -gx NVIM_THEME nord
set -gx STARSHIP_THEME nord
set -gx WEZTERM_THEME nord

# Path Config
fish_add_path /usr/local/bin
fish_add_path ~/.local/bin

# Tmux attach
if test -x "$DOTFILES/os/linux/scripts/tmux-attach.sh"
  "$DOTFILES/os/linux/scripts/tmux-attach.sh"
end

# Homebrew
if test -d /home/linuxbrew/.linuxbrew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# Init Starship Prompt.
if command -v starship >/dev/null
  starship init fish | source
end

# Init Zoxide.
if command -v zoxide >/dev/null
  zoxide init fish | source
end
