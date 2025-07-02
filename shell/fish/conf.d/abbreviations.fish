# --------------------
# Smart Aliases
# --------------------

# Git:
abbr -a g git
abbr -a gi 'git init'
abbr -a gcl 'git clone'
##########
abbr -a ga 'git add'
abbr -a gaa 'git add -A'
##########
abbr -a gc 'git commit'           # open editor.
abbr -a gcm 'git commit -m'
##########
abbr -a gco 'git checkout'        # change a branch.
abbr -a gcob 'git checkout -b'    # new branch and change.
abbr -a gb 'git branch'
abbr -a gbr 'git branch --format=\'%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) - <%(authorname)>\''
##########
abbr -a gl 'git log --graph --all --pretty=oneline --decorate'
abbr -a glg 'git log --graph --all --date=relative --pretty=format:\'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n\''
##########
abbr -a gd 'git diff'             # install delta.
abbr -a gds 'git diff --staged'
abbr -a gdc 'git diff --cached'   # show diff in staged vs HEAD.
##########
abbr -a gs 'git status'
abbr -a gss 'git status -sb'
##########
abbr -a gf 'git fetch --all -p'   # update all remote branch and clear the deleted.
abbr -a gps 'git push'
abbr -a gpsf 'git push --force-with-lease' # force secured push.
abbr -a gpl 'git pull --rebase --autostash' # pull rebase, save changes.
##########
abbr -a gm 'git merge'
##########
abbr -a grb 'git rebase'
abbr -a grb3 'git rebase -i HEAD~3' # interactive rebase 3 last commits.

abbr -a gaf 'git ls-file -m -o --exclude-standar | grep -v "__pycache__" | fzf -m --print0 | xargs -0 -o -t git add' # git add + fzf
abbr -a grmf 'git ls-file -m -o --exclude-standar | fzf -m --print0 | xargs -0 -o -t git rm' # git rm + fzf
abbr -a grf 'git diff --name-only | fzf -m --print0 | xargs -0 -o -t git rm' # git restore + fzf
abbr -a grsf 'git diff --cached --name-only | fzf -m --print0 | xargs -0 -o -t git restore --staged' # git restore staged + fzf
abbr -a gbf 'git branch | fzf | xargs git checkout' # git branch + fzf
abbr -a lg 'lazygit' # need install...

# Directory Navigation:
abbr -a cd.. 'cd ..'
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .3 'cd ../../..'
abbr -a .4 'cd ../../../..'

# Ls:
if command -v eza >/dev/null
  # Need install 'eza'...
  abbr -a l 'eza -al --icons=always --color=always --group-directories-first --git'
  abbr -a ls 'eza -al --icons=always --color=always --group-directories-first --git'
  abbr -a la 'eza -a --icons=always --color=always --group-directories-first'
  abbr -a ll 'eza -l --icons=always --color=always --group-directories-first --git'
  abbr -a lt 'eza -aT --icons=always --color=always --group-directories-first'
  abbr -a l. 'eza -al --icons=always --color=always -group-directories-first --git ../'
  abbr -a l.. 'eza -al --icons=always --color=always -group-directories-first --git ../../'
  abbr -a l... 'eza -al --icons=always --color=always -group-directories-first --git ../../../'
else
  abbr -a l 'ls --color=auto'
  abbr -a la 'ls -la --color=auto'
  abbr -a ll 'ls -l --color=auto'
end

# System:
abbr -a c clear
abbr -a h history
abbr -a x exit
abbr -a v 'nvim .'
abbr -a vi nvim
abbr -a vim nvim
abbr -a svi 'sudo nvim'

if command -v bat >/dev/null
  # Need install 'bat'...
  abbr -a cat 'bat'
end

# Utils:
abbr -a ezsh 'nvim ~/.zshrc'
abbr -a ebash 'nvim ~/.bashrc'
abbr -a efish 'nvim $DOTFILES/shell/fish/config.fish'
abbr -a szsh 'source ~/.zshrc'
abbr -a sbash 'source ~/.bashrc'
# abbr -a sfish 'source ~/.fishrc' || exec fish || fish

if command -v fastfetch >/dev/null
  # Need instal 'fastfetch'...
  abbr -a ff 'fastfetch'
end

# Search:
abbr -a grep 'grep --color=auto'
abbr -a findd 'ls ~/ | grep $1'
abbr -a f 'find . | grep' # search in the current directory
abbr -a h 'history | grep' # search command line history
abbr -a search 'fzf --preview \'bat --color=always --style=numbers --line-range=:500 {}\' | xargs nvim'

# Tmux:
abbr -a t tmux
abbr -a ta 'tmux attach'
abbr -a tl 'tmux list-sessions'
abbr -a tn 'tmux new-session'
abbr -a tk 'tmux kill-session'
abbr -a tks 'tmux kill-server'

# Docker:
abbr -a d docker
abbr -a dc 'docker-compose'
abbr -a dcu 'docker-compose up'
abbr -a dcd 'docker-compose down'
abbr -a dcr 'dcd && dcu -d'
abbr -a dcb 'docker-compose build'
abbr -a dce 'docker-compose exec'
abbr -a ld 'lazydocker' # need install...

# Development:
abbr -a nr 'npm run'
abbr -a ni 'npm install'
abbr -a nig 'npm install -g'
abbr -a rmni 'rm -rf node_modules && npm cache clean --force && npm install'
abbr -a py python3
abbr -a pip pip3
abbr -a p 'pnpm'
abbr -a pi 'pnpm install'
abbr -a pa 'pnpm add'
abbr -a pad 'pnpm add -D'
abbr -a prs 'pnpm run star'
abbr -a prb 'pnpm run build'
abbr -a prd 'pnpm run dev'

# Shortcuts directories
abbr -a repos 'cd $REPOS_PATH'
abbr -a pojects 'cd $PROJECTS_PATH'
abbr -a dot 'cd $DOTFILES'
abbr -a dev 'cd $DEV_PATH'
abbr -a work 'cd $WORKSPACE_PATH'



















