# PATH config
# export PATH="/usr/local/bin:$PATH"

export EDITOR="nvim" # Use nvim as default editor
export VISUAL="nvim"

export BROWSER="firefox"

# Directories
export WORKSPACE="$HOME/workspace"
export REPOS="$WORKSPACE/repos"
export DOTFILES="$REPOS/dotfiles-2024"
export OBSIDIAN="$REPOS/obsidian-notes"
export WALLPAPERS="$REPOS/wallpapers"

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
antigen bundle fnm
antigen bundle docker
antigen bundle dotnet
antigen bundle git
antigen bundle gh
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
# TODO: error fnm multishells
export FNM_MULTISHELL_PATH=disabled
eval "$(fnm env --use-on-cd --shell zsh)"


# Tmux
# Always work in a tmux session if Tmux is installed
if which tmux >/dev/null 2>&1; then
  # Check if the current environment is suitable for tmux
  if [[ -z "$TMUX" &&
    $TERM != "screen-256color" &&
    $TERM != "screen" &&
    -z "$VSCODE_INJECTION" &&
    -z "$INSIDE_EMACS" &&
    -z "$EMACS" &&
    -z "$VIM" &&
    -z "$INTELLIJ_ENVIRONMENT_READER" ]]; then
    # Try to attach to the default tmux session, or create a new one if it doesn't exist
    tmux attach -t default || tmux new -s default
    exit
  fi
fi

# Add script/ directorie to PATH
export PATH="$DOTFILES/os/linux/scripts:$PATH"

# Upload Files...
# Aliases
# if [ -f "$DOTFILES/shell/aliases.sh" ]; then
#   source "$DOTFILES/shell/aliases.sh"
# fi
[[ -s "$HOME/workspace/repos/dotfiles-2024/shell/aliases.sh" ]] && source "$HOME/workspace/repos/dotfiles-2024/shell/aliases.sh"
# Exports
[[ -s "$HOME/workspace/repos/dotfiles-2024/shell/exports.sh" ]] && source "$HOME/workspace/repos/dotfiles-2024/shell/exports.sh"
# Functions
[[ -s "$HOME/workspace/repos/dotfiles-2024/shell/functions.sh" ]] && source "$HOME/workspace/repos/dotfiles-2024/shell/functions.sh"
# fzf-git
[[ -s "$HOME/.fzf-git/fzf.git.sh" ]] && source "$HOME/.fzf-git/fzf.git.sh"
