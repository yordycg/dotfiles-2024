# -----------------------------------------------------------------------------
# DIRECTORIES & PATHS
# -----------------------------------------------------------------------------
export WORKSPACE_PATH="$HOME/workspace"
export DEV_PATH="$WORKSPACE_PATH/dev"
export REPOS_PATH="$WORKSPACE_PATH/repos"
export DOTFILES="$REPOS_PATH/dotfiles-2024"
export OBSIDIAN="$REPOS_PATH/obsidian-notes"
export WALLPAPERS="$REPOS_PATH/wallpapers"
export PROJECTS_PATH="$DEV_PATH/projects"
export DSA_PATH="/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/04 DataStructure-Algorithms"
export CPP_PATH="/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/02 Cpp"

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# -----------------------------------------------------------------------------
# APPS & PREFERENCES
# -----------------------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"

# Themes (Global consistency)
export TMUX_THEME="catppuccin-minimal" # adib-hanna | minimalist | nord | onedark | catppuccin-minimal
export NVIM_THEME="nord"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="nord"

# -----------------------------------------------------------------------------
# SHELL HISTORY
# -----------------------------------------------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
export HISTCONTROL=erasedups:ignoredups:ignorespace

# -----------------------------------------------------------------------------
# FZF CONFIGURATION
# -----------------------------------------------------------------------------
# CTRL-t = fzf select files
# CTRL-r = fzf history
# ALT-c  = fzf cd into directory
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --info=inline-right --border=rounded --color=hl:#2dd4bf"
export FZF_TMUX_OPTS=" -p70%,70% " # fzf default for tmux
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
