# --- OPTIMIZED LOADING HELPERS ---
# Cache expensive eval commands in ~/.cache/zsh
ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE_DIR"

run_cached() {
    local name="$1"
    local cmd="$2"
    local cache_file="$ZSH_CACHE_DIR/$name.zsh"
    # Update cache if it doesn't exist or is older than 24h
    if [[ ! -f "$cache_file" || $(find "$cache_file" -mmin +1440) ]]; then
        eval "$cmd" > "$cache_file" 2>/dev/null
    fi
    source "$cache_file"
}

# 1. Base Configuration
export DOTFILES="$HOME/workspace/repos/dotfiles-2024"
[[ -s "$DOTFILES/shell/exports.sh" ]] && source "$DOTFILES/shell/exports.sh"
[[ -s "$DOTFILES/shell/functions.sh" ]] && source "$DOTFILES/shell/functions.sh"

# --- ZSH COMPLETION SYSTEM (Early Init) ---
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

# Sheldon Plugin Manager (Cached)
if command -v sheldon &> /dev/null; then
    run_cached "sheldon" "sheldon source"
fi

# History, Keybindings & Styling (Unchanged)
setopt inc_append_history
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey -e
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward
bindkey '^[w' kill-region

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --tree --color=always $realpath | head -200'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons --tree --color=always $realpath | head -200'

# --- FAST TOOL INITIALIZATION (Cached) ---
[[ -x $(command -v zoxide) ]] && run_cached "zoxide" "zoxide init zsh"
[[ -x $(command -v atuin) ]]  && run_cached "atuin" "atuin init zsh"
[[ -x $(command -v starship) ]] && run_cached "starship" "starship init zsh"
[[ -x $(command -v direnv) ]] && run_cached "direnv" "direnv hook zsh"

# FZF Keybindings
if [ -f "/usr/share/fzf/key-bindings.zsh" ]; then
  source "/usr/share/fzf/key-bindings.zsh"
  source "/usr/share/fzf/completion.zsh"
fi

# Aliases & Support scripts
[[ -s "$DOTFILES/shell/aliases.sh" ]] && source "$DOTFILES/shell/aliases.sh"
[[ -s "$HOME/.fzf-git/fzf.git.sh" ]] && source "$HOME/.fzf-git/fzf.git.sh"

# Fastfetch (Only on interactive login or manual source)
if [[ -z "$TMUX" && -x $(command -v fastfetch) ]]; then
    fastfetch
fi
