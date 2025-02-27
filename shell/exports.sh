
export EDITOR="nvim" # Use nvim as default editor
export VISUAL="nvim"

export BROWSER="firefox"

# Directories
export WORKSPACE="$HOME/workspace"
export OBSIDIAN="$WORKSPACE/obsidian-notes"
export REPOS="$WORKSPACE/repos"
export DOTFILES="$REPOS/dotfiles-2024"

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

# Fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_TMUX_OPTS=" -p90%,70% " # fzf default for tmux
# setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# PATH config
export PATH="/usr/local/bin:$PATH"
