###############################################################################
# SYSTEM & NAVIGATION
###############################################################################
alias c="clear"
alias x="exit"
alias ~="cd ~"
alias dot="cd $DOTFILES"
alias repos="cd $REPOS"
alias shutdown="sudo shutdown now"
alias restart="sudo reboot"
alias mv="mv -i"

# Directory Navigation
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."

# Eza (Modern ls)
alias ls="eza -al --icons=always --color=always --group-directories-first --git"
alias la="eza -a --icons=always --color=always --group-directories-first"
alias ll="eza -l --icons=always --color=always --group-directories-first --git"
alias lt="eza -aT --icons=always --color=always --group-directories-first"
alias l.="eza -al --icons=always --color=always --group-directories-first --git ../"
alias l..="eza -al --icons=always --color=always --group-directories-first --git ../../"
alias l...="eza -al --icons=always --color=always --group-directories-first --git ../../../"

###############################################################################
# SEARCH & UTILS
###############################################################################
alias grep="grep --color=auto"
alias f="find . | grep "
alias h="history | grep "
alias cat="bat"
alias ff="fastfetch"
alias wifi="nmtui"
alias search="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"

# Functions
findd() { ls ~/ | grep "$1"; }

# Editors & Config
alias vim="nvim"
alias vi="nvim"
alias svi="sudo nvim"
alias v="nvim ."
alias eal="$EDITOR $DOTFILES/shell/aliases.sh"
alias ezsh="$EDITOR ~/.zshrc"
alias ebash="$EDITOR ~/.bashrc"
alias eatty="$EDITOR ~/.config/alacritty/alacritty.toml"
alias ektty="$EDITOR $DOTFILES/os/linux/kitty/kitty.conf"
alias ewterm="$EDITOR $DOTFILES/os/cross-platform/wezterm/wezterm.lua"
alias sbash="source ~/.bashrc"
alias szsh="source ~/.zshrc"

###############################################################################
# GIT & GITHUB
###############################################################################
alias g="git"
alias gs="git status"
alias gss="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gfix="git add . && git commit --amend --no-edit"
alias gamend="git commit --amend --no-edit"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gb="git branch"
alias gd="git diff"
alias gds="git diff --staged"
alias gdc="git diff --cached"
alias gl="git log --graph --all --pretty=oneline --decorate"
alias glg="git log --graph --all --date=relative --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n'"
alias gout="git log @{u}.."
alias gps="git push"
alias gpsf="git push --force-with-lease"
alias gpl="git pull --rebase --autostash"
alias gf="git fetch --all -p"
alias gpp="git pull && git push"
alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias grb="git rebase"
alias grb3="git rebase -i HEAD~3"
alias grb5="git rebase -i HEAD~5"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"
alias gcp="git cherry-pick"
alias gst="git stash"
alias gsts="git stash save"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gstd="git stash drop"
alias gstc="git stash clear"
alias gt="git tag"
alias gtd="git tag -d"
alias lg="lazygit"

# Git + FZF
alias gafzf='git ls-file -m -o --exclude-standar | grep -v "__pycache__" | fzf -m --print0 | xargs -0 -o -t git add'
alias grmfzf='git ls-file -m -o --exclude-standar | fzf -m --print0 | xargs -0 -o -t git rm'
alias grfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore'
alias grsfzf='git diff --cached --name-only | fzf -m --print0 | xargs -0 -o -t git restore --staged'
alias gbfzf='git branch | fzf | xargs git checkout'

# GitHub CLI (GH)
alias ghr='gh repo'
alias ghrc='gh repo create'
alias ghrl='gh repo list'
alias ghrf='gh repo fork'
alias ghrv='gh repo view'
alias ghrw='gh repo view -w'
alias ghpr='gh pr'
alias ghprc='gh pr create'
alias ghprl='gh pr list'
alias ghprv='gh pr view'
alias ghprco='gh pr checkout'
alias ghprm='gh pr merge'
alias ghi='gh issue'
alias ghic='gh issue create'
alias ghil='gh issue list'
alias ghiv='gh issue view'
alias ghg='gh gist'
alias ghgc='gh gist create'
alias ghgl='gh gist list'
alias ghra='gh release'
alias ghrac='gh release create'
alias ghral='gh release list'

###############################################################################
# INFRASTRUCTURE (DOCKER & TMUX)
###############################################################################
# Docker
alias d="docker"
alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcd="docker-compose down"
alias dce="docker-compose exec"
alias dcl="docker-compose logs"
alias dcu="docker-compose up"
alias dcr="dcd && dcu -d"
alias ld="lazydocker"
alias dprune="docker system prune -a --volumes"

# Tmux
alias t="tmux"
alias tks="tmux kill-server"

###############################################################################
# ENVIRONMENT SPECIFIC (OS & WSL)
###############################################################################
# Arch Linux (Pacman & Yay)
alias pacsyu="sudo pacman -Syu"
alias yaysyu="yay -Syu --noconfirm"

# Debian/Ubuntu (Apt)
alias aptuu="sudo apt update -y ; sudo apt upgrade -y"

# WSL & Paths
alias win="cd /mnt/c/Users/Yordy"
alias dev="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/"
alias dircpp="cd /mnt/d/Escritorio\ 2/Cursos-Yordy/00\ -\ Cursos\ Programacion/02\ Cpp/"

###############################################################################
# LANGUAGES & FRAMEWORKS
###############################################################################
# Node.js (NPM & PNPM)
alias npmd="npm run dev"
alias npms="npm start"
alias rmnpmi="rm -rf node_modules && npm cache clean --force && npm i"
alias pn="pnpm"
alias pni="pnpm install"
alias pna="pnpm add"
alias pnad="pnpm add -D"
alias pnrs="pnpm run start"
alias pnrb="pnpm run build"
alias pnrd="pnpm run dev"

# Python & Django
alias py="python3"
alias venv="python3 -m venv .venv"
alias va="source .venv/bin/activate"
alias pipi="pip install"
alias pipr="pip install -r requirements.txt"
alias pyclean="find . -type d -name '__pycache__' -exec rm -rf {} +"

# Django Specific
alias pm="python manage.py"
alias djadmin="django-admin"
alias djsp="django-admin startproject"
alias pmsa="python manage.py startapp"
alias pmr="python manage.py runserver"
alias pmm="python manage.py migrate"
alias pmmm="python manage.py makemigrations"
alias pms="python manage.py shell"
alias pmsp="python manage.py createsuperuser"
alias pmt="python manage.py test"
alias pmcs="python manage.py collectstatic"
