# System
alias shutdown="sudo shutdown now"
alias restart="sudo reboot"
alias c="clear"
alias x="exit"
alias mv="mv -i"

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
alias gi="git init"
alias gcl="git clone"
##########
alias ga="git add"
alias gaa="git add -A"
##########
alias gc="git commit" # open editor
alias gcm="git commit -m"
alias gca="git commit -a"   # add modified files and open editor
alias gcam="git commit -am" # add modified files with "message"
##########
alias gcp="git cherry-pick"
##########
alias gst="git stash"
alias gsts="git stash save"
alias gstl="git stash list"
alias gstp="git stash pop" # apply last stash
alias gstd="git stash drop"
alias gstc="git stash clear"
##########
alias gt="git tag"
alias gtd="git tag -d" # delete tag
##########
alias gd="git diff"
alias gds="git diff --staged"
alias gdc="git diff --cached" # show diff in staged vs HEAD
##########
alias gs="git status"
alias gss="git status -sb"
##########
alias grb="git rebase"
alias grb3="git rebase -i HEAD~3"
alias grb5="git rebase -i HEAD~5"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"
##########
alias gps="git push"
alias gpsf="git push --force-with-lease"
alias gpl="git pull --rebase --autostash"
alias gf="git fetch --all -p"
alias gpp="git pull && git push"
##########
alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"
##########
alias gco="git checkout"     # change a branch
alias gcob="git checkout -b" # new branch and change
alias gb="git branch"
alias gbr="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) - <%(authorname)>'"
##########
alias gl="git log --graph --all --pretty=oneline --decorate"
alias glg="git log --graph --all --date=relative --pretty=format:'%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n'"
# alias glg="git log --graph --all --abbrev-commit --date=relative --pretty=format:'%C(yellow)%h%C(reset) -%C(red)%d%C(reset) %s %C(green)(%ar) %C(bold blue)<%an>%C(reset)'"
# alias gg="git log --graph --abbrev-commit --date=relative --pretty=format:'%C(bold)%h%C(reset)%C(magenta)%d%C(reset) %s %C(yellow)<%an> %C(cyan)(%cr)%C(reset)'"

# %h - commit hash
# %an - author name
# %ar - commit time
# %D - ref names
# %n - new line
# %s - commit message

# Git add with fzf
alias gafzf='git ls-file -m -o --exclude-standar | grep -v "__pycache__" | fzf -m --print0 | xargs -0 -o -t git add'
# Git rm wthh fzf
alias grmfzf='git ls-file -m -o --exclude-standar | fzf -m --print0 | xargs -0 -o -t git rm'
# Git restore with fzf
alias grfzf='git diff --name-only | fzf -m --print0 | xargs -0 -o -t git restore'
alias grsfzf='git diff --cached --name-only | fzf -m --print0 | xargs -0 -o -t git restore --staged'
# Selected a branch with fzf
alias gbfzf='git branch | fzf | xargs git checkout'

alias lg="lazygit" # need install lazygit

# GH CLI
alias ghr='gh repo'
alias ghrc='gh repo create'
alias ghrl='gh repo list'
alias ghrf='gh repo fork'
alias ghrv='gh repo view'
alias ghrw='gh repo view -w' # open in browser
alias ghpr= 'gh pr'
alias ghprc= 'gh pr create'
alias ghprl= 'gh pr list'
alias ghprv= 'gh pr view'
alias ghprco= 'gh pr checkout'
alias ghprm= 'gh pr merge'
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
alias eal="$EDITOR $DOTFILES/shell/aliases.sh"
alias ezsh="$EDITOR ~/.zshrc"
alias ebash="$EDITOR ~/.bashrc"
alias eatty="$EDITOR ~/.config/alacritty/alacritty.toml"
alias ektty="$EDITOR $DOTFILES/os/linux/kitty/kitty.conf"
alias ewterm="$EDITOR $DOTFILES/os/cross-platform/wezterm/wezterm.lua"
alias sbash="source ~/.bashrc"
alias szsh="source ~/.zshrc"
alias t="tmux"
alias tks="tmux kill-server"
alias cat="bat" # install 'bat/github'
alias ff="fastfetch"
alias wifi="nmtui"

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
# npm
alias npmd="npm run dev"
alias npms="npm start"
alias rmnpmi="rm -rf node_modules && npm cache clean --force && npm i"
# pnpm
alias pn="pnpm"
alias pni="pnpm install"
alias pna="pnpm add"
alias pnad="pnpm add -D"
alias pnrs="pnpm run star"
alias pnrb="pnpm run build"
alias pnrd="pnpm run dev"
