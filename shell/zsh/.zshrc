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
antigen bundle git
antigen bundle fnm
antigen bundle djui/alias-tips
antigen bundle zsh-users/zsh-autosuggestions
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
if [ -f "$DOTFILES/shell/aliases.sh" ]; then
  source "$DOTFILES/shell/aliases.sh"
fi
