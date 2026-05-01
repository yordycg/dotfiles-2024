# -----------------------------------------------------------------------------
# DIRECTORIES & PATHS
# -----------------------------------------------------------------------------
export WORKSPACE_PATH="$HOME/workspace"
export REPOS_PATH="$WORKSPACE_PATH/repos"
export PERSONAL_PATH="$WORKSPACE_PATH/personal"
export UNIVERSITY_PATH="$WORKSPACE_PATH/university/year_3/semester_5"
export DOTFILES="$REPOS_PATH/dotfiles-2024"
export OBSIDIAN="$REPOS_PATH/obsidian-notes"
export WALLPAPERS="$REPOS_PATH/wallpapers"
export DSA_PATH="/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/04 DataStructure-Algorithms"
export CPP_PATH="/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/02 Cpp"

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# PATH updates
export PATH="$DOTFILES/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# -----------------------------------------------------------------------------
# APPS & PREFERENCES
# -----------------------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"

# Themes (Global consistency)
export TMUX_THEME="gruvbox"
export NVIM_THEME="gruvbox"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="nord"
export HARLEQUIN_THEME="everforest" # Sincronizado con bases de datos

# Secret Agent Configuration
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

# -----------------------------------------------------------------------------
# ZSH PLUGIN CONFIGURATIONS
# -----------------------------------------------------------------------------
# Zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# -----------------------------------------------------------------------------
# SHELL HISTORY
# -----------------------------------------------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
export HISTDUP=erase
export HISTCONTROL=erasedups:ignoredups:ignorespace

# -----------------------------------------------------------------------------
# FZF CONFIGURATION
# -----------------------------------------------------------------------------
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# UI Standard: Centered, Rounded Borders, Professional Colors
export FZF_DEFAULT_OPTS=" \
  --height 45% \
  --layout=reverse \
  --border=rounded \
  --margin=0,1 \
  --padding=0 \
  --info=inline-right \
  --prompt='󰭎 ' \
  --pointer=' ' \
  --marker='󰄲 ' \
  --color='hl:#2dd4bf,hl+:#2dd4bf,pointer:#f43f5e,marker:#10b981,border:#334155,header:#64748b' \
  --bind 'ctrl-u:preview-page-up,ctrl-d:preview-page-down' \
  --bind 'ctrl-y:execute-silent(echo {+} | wl-copy)+abort' \
"

export FZF_TMUX_OPTS=" -p70%,60% "
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
