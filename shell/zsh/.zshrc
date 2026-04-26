# Load Exports (Environment Variables)
export DOTFILES="$HOME/workspace/repos/dotfiles-2024"
[[ -s "$DOTFILES/shell/exports.sh" ]] && source "$DOTFILES/shell/exports.sh"

# Load Functions (early for lazy-loading & performance)
[[ -s "$DOTFILES/shell/functions.sh" ]] && source "$DOTFILES/shell/functions.sh"

# --- ZSH COMPLETION SYSTEM (Early Init) ---
# Initialize compinit BEFORE plugins so 'compdef' is available
autoload -Uz compinit
if [ $(date +'%j') != $(stat -c '%a' ~/.zcompdump 2>/dev/null | cut -d' ' -f1) ]; then
  compinit
else
  compinit -C
fi

# Sheldon Plugin Manager
if command -v sheldon &> /dev/null; then
  eval "$(sheldon source 2>/dev/null)"
fi

# History Configuration (Standard Zsh settings)
setopt inc_append_history
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey -e
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward
bindkey '^[w' kill-region

# Completions styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# Fzf-tab configuration
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --tree --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons --tree --color=always $realpath | head -200'

# Eval list (External Tool Initializations)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
elif [ -f "/usr/share/fzf/key-bindings.zsh" ]; then
  source "/usr/share/fzf/key-bindings.zsh"
  source "/usr/share/fzf/completion.zsh"
fi

# Starship prompt
eval "$(starship init zsh)"

# Aliases
[[ -s "$DOTFILES/shell/aliases.sh" ]] && source "$DOTFILES/shell/aliases.sh"

# fzf-git
[[ -s "$HOME/.fzf-git/fzf.git.sh" ]] && source "$HOME/.fzf-git/fzf.git.sh"

# Fastfetch
if command -v fastfetch &> /dev/null; then
  fastfetch
fi
eval "$(direnv hook zsh)"
