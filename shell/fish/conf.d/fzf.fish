# --------------------
# FZF Config
# --------------------
# 'ctrl_t' -> fzf select
# 'ctrl_r' -> fzf history
# 'alt_c' -> fzf cd

# Default options:
set -gx FZF_DEFAULT_OPTS '
--height 40%
--layout=reverse
--border
--margin=1
--padding=1
'

# Nord theme:
set -gx FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS '
--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
--color=fg+:#e5e9f0,bg+:#434c5e,hl+:#81a1c1
--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
--color=marker:#a3be8b,spiner:#b48dac,header:#a3be8b
'

# Use 'fd' if is available:
if command -v fd >/dev/null
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
  set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
end

# Key bindings (need fzf.fish plugin):
set -gx FZF_CTRL_T_OPTS '--preview \'bat --style=numbers -n --color=always --line-range:500 {}\''
set -gx FZF_ALT_C_OPTS '--preview "eza --tree --color=always {} | head -200"'

set -gx FZF_TMUX_OPTS ' -p70%,70%' # fzf default for tmux
