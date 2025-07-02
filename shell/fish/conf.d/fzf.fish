# --------------------
# FZF Config
# --------------------
# 'ctrl_t' -> fzf select
# 'ctrl_r' -> fzf history
# 'alt_c' -> fzf cd

# FZF default options
set -gx FZF_DEFAULT_OPTS '
--height 40%
--layout=reverse
--border
--margin=1
--padding=1
'

# FZF Theme: Nord
set -gx FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS '
--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
--color=fg+:#e5e9f0,bg+:#434c5e,hl+:#81a1c1
--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
'

# Use 'fd' if available
if command -v fd >/dev/null
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
  set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
end

# FZF key bindings | Need fzf.fish plugin
set -gx FZF_CTRL_T_OPTS '--preview "bat --color=always --line-range :500 {}"'
set -gx FZF_ALT_C_OPTS '--preview "eza --tree --color=always {} | head -200"'
