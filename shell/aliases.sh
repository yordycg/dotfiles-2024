# Enable aliases to be sudo’ed
alias sudo='sudo '

# Change directory aliases
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."

# Eza | install eza
alias ls="eza -al --icons=always --color=always --group-directories-first --git"
alias la="eza -a --icons=always --color=always --group-directories-first"                    # all files and direcotories
alias ll="eza -l --icons=always --color=always --group-directories-first --git"              # long format
alias lt="eza -aT --icons=always --color=always --group-directories-first"                   # tree listing
alias l.="eza -al --icons=always --color=always --group-directories-first --git ../"         # ls on the PARENT directory
alias l..="eza -al --icons=always --color=always --group-directories-first --git ../../"     # ls on directory 2 levels up
alias l...="eza -al --icons=always --color=always --group-directories-first --git ../../../" # ls on directory 3 levels up

alias ~="cd ~"
# alias dotfiles='cd $DOTFILES_PATH'

# Git
alias g="git"
alias gcl="git clone"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd="git pretty-diff"
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gpp="git pull && git push"
alias gm="git merge"
alias gb="git branch"
alias gl="git pretty-log"
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias lg="lazygit" # need install lazygit

# Docker
alias d="docker"
alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcd="docker-compose down"
alias dce="docker-compose exec"
alias dcl="docker-compose logs"
alias dcu="docker-compose up"
alias dcr="dcd && dcu -d"
alias ld="lazydocker" # need install lazydocker

# Utils
alias setup="mkdir \"$1\" && cd \"$1\""
alias eal="$EDITOR $DOTFILES/shell/aliases.sh"
alias ez="$EDITOR ~/.zshrc"
# alias ebrc="$EDITOR ~/.bashrc"
# alias ea="$EDITOR ~/.config/alacritty/alacritty.toml"
alias ek="$EDITOR $DOTFILES/os/linux/kitty/kitty.conf"
alias ew="$EDITOR $DOTFILES/os/cross-platform/wezterm/wezterm.lua"
# alias sb="source ~/.bashrc"
alias sz="source ~/.zshrc"
alias t="tmux"
alias c="clear"
alias x="exit"
alias cat="bat" # instalar desde 'bat/github'
alias ff="fastfetch"
# alias wifi="nmtui"

# Search
alias grep="grep --color=auto"
alias findd="ls ~/ | grep $1"
alias f="find . | grep "  # search in the current folder
alias h="history | grep " # search command line history
alias search="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"

# Vim
alias vim="nvim"
alias vi="nvim"
alias svi="sudo nvim"
alias v="nvim ."

# Directories
alias dot="cd $DOTFILES"
alias repos="cd $REPOS"

# Pacman and YAY - Arch
# alias pacsyu="sudo pacman -Syu"       # update only standard pkgs
# alias pacsyyu="sudo pacman -Syyu"     # refresh pkglist & update standard pkgs
# alias yaysyu="yay -Syu --noconfirm"   # update only AUR pkgs (yay)
# alias yaysyyu="yay -Syyu --noconfirm" # update standard pkgs & AUR pks (yay)

# Apt - Arch
alias aptuu="sudo apt update -y ; sudo apt upgrade -y" # update and upgrade pkgs

# WSL
alias win="cd /mnt/c/Users/Yordy" # change a yordyWIN
alias dev="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/"
alias dircpp="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/02\ Cpp/"

# Dev
# NodeJS
alias npmd="npm run dev"
alias npms="npm start"
alias rmnpmi="rm -rf node_modules && npm cache clean --force && npm i"
alias pn="pnpm"
alias pnd="pn run dev"
