# Fzf
# CTRL-t = fzf select
# CTRL-r = fzf history
# ALT-c  = fzf cd
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --info=inline-right --border=rounded --color=hl:#2dd4bf"
export FZF_TMUX_OPTS=" -p70%,70% " # fzf default for tmux
# setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
