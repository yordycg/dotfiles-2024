# Load Exports (Environment Variables)
# We assume the repo is at a standard location if DOTFILES is not set, 
# but usually it's better to source it relatively or via an absolute path if known.
# Since this file is in $DOTFILES/shell/zsh/.zshrc, we can try to find it.
export DOTFILES="$HOME/workspace/repos/dotfiles-2024"
[[ -s "$DOTFILES/shell/exports.sh" ]] && source "$DOTFILES/shell/exports.sh"

# Load Functions (early for lazy-loading & performance)
[[ -s "$DOTFILES/shell/functions.sh" ]] && source "$DOTFILES/shell/functions.sh"

# Sheldon Plugin Manager
# Initializes sheldon. It will automatically source plugins from the config file.
if command -v sheldon &> /dev/null; then
  eval "$(sheldon init --shell zsh 2> /dev/null)"
fi

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

# Eval list (External Tool Initializations)
# Zoxide - Smarter cd command
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Atuin - SQLite based shell history
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# Fzf - Fuzzy Finder integrations (Keybindings & Auto-completion)
# Usually installed via package manager or script in ~/.fzf
if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
elif [ -f "/usr/share/fzf/key-bindings.zsh" ]; then # Arch Linux default
  source "/usr/share/fzf/key-bindings.zsh"
  source "/usr/share/fzf/completion.zsh"
fi

# Starship prompt
eval "$(starship init zsh)"

# Node with fnm
# Initialization is handled via lazy-loading in shell/functions/performance.sh
FNM_PATH="$HOME/.fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.fnm:$PATH"
fi

# Aliases
[[ -s "$DOTFILES/shell/aliases.sh" ]] && source "$DOTFILES/shell/aliases.sh"

# fzf-git
[[ -s "$HOME/.fzf-git/fzf.git.sh" ]] && source "$HOME/.fzf-git/fzf.git.sh"
