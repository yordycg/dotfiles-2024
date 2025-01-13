# ----------------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------------
export VISUAL=nvim
export EDITOR=nvim
export REPOS="$HOME/workspace/repos"
export DOTFILES="$REPOS/dotfiles-2024"

# ----------------------------------------------------------------
# History Configuration
# ----------------------------------------------------------------
export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
# Don't put DUPLICATE LINES in the history and do not add lines that START WITH A SPACE
export HISTCONTROL=erasedups:ignoredups:ignorespace

# ----------------------------------------------------------------
# Antigen Configuration
# ----------------------------------------------------------------
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
antigen bundle httpie
antigen bundle command-not-found
antigen bundle rupa/z@master # z
# 'fzf' completion behaviour, ctrl-t, etc.
antigen bundle junegunn/fzf shell
antigen bundle junegunn/fzf shell/completion.zsh
antigen bundle junegunn/fzf shell/key-bindings.zsh
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

# ----------------------------------------------------------------
# Eval list
# ----------------------------------------------------------------
# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/usr/local/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"

# Node with fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# ----------------------------------------------------------------
# Upload Files
# ----------------------------------------------------------------
# Upload aliases
# if [ -f "$DOTFILES/shell/aliases.sh" ]; then
#   source "$DOTFILES/shell/aliases.sh"
# fi
[[ -s "$DOTFILES/shell/aliases.sh" ]] && source "$DOTFILES/shell/aliases.sh"

# Upload exports
[[ -s "$DOTFILES/shell/exports.sh" ]] && source "$DOTFILES/shell/exports.sh"

# Upload functions
[[ -s "$DOTFILES/shell/functions.sh" ]] && source "$DOTFILES/shell/functions.sh"
