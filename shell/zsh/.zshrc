# PATH config
# export PATH="/usr/local/bin:$PATH"

export EDITOR="nvim" # Use nvim as default editor
export VISUAL="nvim"

export BROWSER="firefox"

# Directories
export WORKSPACE_PATH="$HOME/workspace"
export DEV_PATH="$WORKSPACE_PATH/dev"
export REPOS_PATH="$WORKSPACE_PATH/repos"
export DOTFILES="$REPOS_PATH/dotfiles-2024"
export OBSIDIAN="$REPOS_PATH/obsidian-notes"
export WALLPAPERS="$REPOS_PATH/wallpapers"
export PROJECTS_PATH="$DEV_PATH/projects"
export DSA_PATH="/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/04 DataStructure-Algorithms"
export CPP_PATH="/mnt/d/Escritorio 2/Cursos-Yordy/00 - Cursos Programacion/02 Cpp"
# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Theme config
export TMUX_THEME="nord" # nord | onedark
export NVIM_THEME="nord"
export STARSHIP_THEME="nord"
export WEZTERM_THEME="nord"

# History config
export HISTFILE=~/.zsh_history
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTDUP=erase
# Don't put DUPLICATE LINES in the history and do not add lines that START WITH A SPACE
export HISTCONTROL=erasedups:ignoredups:ignorespace


# Antigen Configuration
# Laod Antigen
# source "$HOME/antigen.zsh"
source /home/linuxbrew/.linuxbrew/share/antigen/antigen.zsh

# Load Antigen configurations
# antigen init $HOME/.antigenrc

# Load oh-my-zsh library
antigen use oh-my-zsh

# Load plugins
antigen bundle aws
# antigen bundle fnm
# antigen bundle docker
antigen bundle dotnet
antigen bundle git
# antigen bundle gh
antigen bundle httpie
antigen bundle command-not-found
antigen bundle vscode
antigen bundle rupa/z@master # z
# 'fzf' completion behaviour, ctrl-t, etc.
antigen bundle junegunn/fzf shell
antigen bundle junegunn/fzf shell/completion.zsh
antigen bundle junegunn/fzf shell/key-bindings.zsh
antigen bundle Aloxaf/fzf-tab
antigen bundle desyncr/zsh-ctrlp                   # find files with fzf | ctrl-p
antigen bundle joshskidmore/zsh-fzf-history-search # uses fzf for searching command history
antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle alexrochas/zsh-git-semantic-commits
antigen bundle zdharma-continuum/fast-syntax-highlighting

# Load theme
# antigen theme denysdovhan/spaceship-prompt

# Tell Antigen that you're done
antigen apply

# Others
# History Configuration
setopt appendhistory
setopt sharehistory      # Share history between sessions
setopt hist_ignore_space # Don't save when prefixed with space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups # Don't save duplicate lines
setopt hist_find_no_dups
# keybindings
bindkey -e                           # Usa el modo de edicion emacs (estandar)
bindkey '^n' history-search-forward  # ctrl-n para buscar hacia adelante en el historial
bindkey '^p' history-search-backward # ctrl-p para buscar hacia atras en el historial
bindkey '^[w' kill-region            # alt-w para borrar region seleccionada
# Completions styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case insensitive matching
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colorear completados
# zstyle ':completion:*' menu no                          # No mostrar menú de selección para completados
# Fzf-tab config
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --tree --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons --tree --color=always $realpath | head -200'

# Eval list
# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/usr/local/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"

# Node with fnm
# NOTE: install using curl not brew!
FNM_PATH="$HOME/.fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.fnm:$PATH" # agregar directorio al PATH
  eval "`fnm env --use-on-cd`"
fi

# Upload Files...
# Aliases
[[ -s "$DOTFILES/shell/aliases.sh" ]] && source "$DOTFILES/shell/aliases.sh"

# Exports
[[ -s "$DOTFILES/shell/exports.sh" ]] && source "$DOTFILES/shell/exports.sh"

# Functions
[[ -s "$DOTFILES/shell/functions.sh" ]] && source "$DOTFILES/shell/functions.sh"

# fzf-git
[[ -s "$HOME/.fzf-git/fzf.git.sh" ]] && source "$HOME/.fzf-git/fzf.git.sh"

# Tmux attach
[[ -x "$DOTFILES/os/linux/scripts/tmux-attach.sh" ]] && "$DOTFILES/os/linux/scripts/tmux-attach.sh"
