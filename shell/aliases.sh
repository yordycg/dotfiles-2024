# System
alias shutdown="sudo shutdown now"
alias restart="sudo reboot"
alias c="clear"
alias x="exit"

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
alias gacm="git add . && git commit -m" # Agregar y hacer commit, cualquier archivo
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -am" # Agregar y hacer commit, no toma en cuenta archivos nuevos
alias gcam="git commit --amend -m" # Editar el MENSAJE del ultimo commit
alias gcane="git add --all && git commit --amend --no-edit" # Util para agregar cambios olvidados al ultimo commit
alias gco="git checkout"
alias gcob="git checkout -b"
# alias gd="git pretty-diff"
alias gd="git diff"
alias gs="git status"
alias gss="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gpp="git pull && git push"
alias gm="git merge"
alias gb="git branch"
alias gbr="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) - <%(authorname)>' --sort=-committerdate"
alias gl="git --no-pager log --pretty=oneline --abbrev-commit --decorate --all"
alias glg="git log --graph --abbrev-commit --date=relative --pretty=format:'%C(yellow)%h%C(reset) -%C(red)%d%C(reset) %s %C(green)(%ar) %C(bold blue)<%an>%C(reset)'"
# alias gg="git log --graph --abbrev-commit --date=relative --pretty=format:'%C(bold)%h%C(reset)%C(magenta)%d%C(reset) %s %C(yellow)<%an> %C(cyan)(%cr)%C(reset)'"

# Git witth fzf
alias gafzf='git ls-file -m -o --exclude-standar | grep -v "__pycache__" | fzf -m --print0 | xargs -0 -o -t git add' # Git add con fzf
alias grmfzf='git ls-file -m -o --exclude-standar | fzf -m --print0 | xargs -0 -o -t git rm' # Git rm con fzf
alias grfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore' # Git restore con fzf
alias grsfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore --staged' # Git restore --staged con fzf
alias gbfzf='git branch | fzf | xargs git checkout' # Seleccionar una branch con fzf

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
